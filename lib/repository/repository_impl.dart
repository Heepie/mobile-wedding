import 'package:mobile_wedding/model/content.dart';
import 'package:mobile_wedding/model/conversation.dart';
import 'package:mobile_wedding/repository/local_datasource.dart';
import 'package:mobile_wedding/repository/repository.dart';

/// Repository implementation using local data source
///
/// Implements [Repository] interface with [LocalDataSource].
class RepositoryImpl implements Repository {
  final LocalDataSource _localDataSource;

  RepositoryImpl(this._localDataSource);

  @override
  List<ConversationWithDelay> getConversationsWithDelay() {
    return _localDataSource.getConversationList();
  }

  @override
  List<Conversation> getAllConversations() {
    return _localDataSource
        .getConversationList()
        .map((e) => e.conversation)
        .toList();
  }

  @override
  List<String> getImagePathsForCache() {
    final conversations = getAllConversations();
    final paths = <String>[];

    for (final conversation in conversations) {
      if (conversation is Message) {
        _extractImagePaths(conversation.content, paths);
      }
    }

    // Add paths from local data source
    paths.addAll(_localDataSource.getImagePathsForCache());

    return paths.toSet().toList(); // Remove duplicates
  }

  /// Extracts image paths from content recursively
  void _extractImagePaths(Content content, List<String> paths) {
    switch (content) {
      case LocalImageContent():
        paths.add(content.path);
      case RemoteImageContent():
        break;
      case VideoContent():
        if (!content.thumbnailPath.startsWith('http')) {
          paths.add(content.thumbnailPath);
        }
      case MediaListContent():
        for (final media in content.mediaList) {
          _extractImagePaths(media, paths);
        }
      case MapContent():
        _extractImagePaths(content.image, paths);
      case TextContent():
      case RichTextContent():
      case CopyableTextContent():
      case CopyableTextListContent():
      case TypingContent():
        break;
    }
  }
}
