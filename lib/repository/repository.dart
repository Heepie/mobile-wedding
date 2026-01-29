import 'package:mobile_wedding/model/conversation.dart';

/// Repository interface for accessing conversation data
///
/// Defines the contract for data access operations.
/// Implementations can use local data, remote API, or other data sources.
abstract class Repository {
  /// Returns list of conversations with delay information
  ///
  /// Used for sequential message display with animations.
  List<ConversationWithDelay> getConversationsWithDelay();

  /// Returns all conversations without delay
  ///
  /// Used for immediate display mode.
  List<Conversation> getAllConversations();

  /// Returns list of image paths for preloading
  ///
  /// Extracts image paths from MediaContent for cache warming.
  List<String> getImagePathsForCache();
}
