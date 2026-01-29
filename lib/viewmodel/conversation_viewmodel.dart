import 'dart:async';

import 'package:mobile_wedding/model/content.dart';
import 'package:mobile_wedding/model/conversation.dart';
import 'package:mobile_wedding/repository/repository.dart';

/// ViewModel for managing conversation state and stream
///
/// Handles conversation data flow between Repository and View.
/// Uses Stream to emit indices for AnimatedList animations.
class ConversationViewModel {
  final Repository _repository;

  /// Accumulated conversation list (owned by ViewModel)
  final List<Conversation> _conversations = [];

  /// StreamController for emitting insert indices
  final _insertController = StreamController<int>.broadcast();

  /// StreamController for emitting remove indices (TypingContent removal)
  final _removeController = StreamController<int>.broadcast();

  /// Flag to prevent duplicate calls
  bool _isStarted = false;

  /// Flag for immediate display mode
  bool _isShowImmediately = false;

  ConversationViewModel(this._repository);

  //=== Getters for View ===

  /// Read-only access to accumulated conversations
  List<Conversation> get conversations => List.unmodifiable(_conversations);

  /// Stream of indices for AnimatedList.insertItem
  Stream<int> get onInsert => _insertController.stream;

  /// Stream of indices for AnimatedList.removeItem (TypingContent removal)
  Stream<int> get onRemove => _removeController.stream;

  /// Whether immediate display mode is active
  bool get isShowImmediately => _isShowImmediately;

  //=== Methods for View ===

  /// Starts conversation with delays between messages
  ///
  /// Emits indices through [onInsert] and [onRemove] streams
  /// for AnimatedList animations.
  /// Automatically removes TypingContent when the next message arrives.
  Future<void> startConversation() async {
    if (_isStarted) return;
    _isStarted = true;

    final dataList = _repository.getConversationsWithDelay();

    for (final item in dataList) {
      await Future.delayed(Duration(milliseconds: item.delayMs));

      // Stop if reset() was called during the delay
      if (!_isStarted) return;

      // Remove previous TypingContent after delay (so it's visible on screen)
      if (_conversations.isNotEmpty) {
        final last = _conversations.last;
        if (last is Message && last.content is TypingContent) {
          final removeIndex = _conversations.length - 1;
          _conversations.removeLast();
          _removeController.add(removeIndex);
        }
      }

      _conversations.add(item.conversation);
      _insertController.add(_conversations.length - 1);
    }
  }

  /// Switches to immediate display mode
  ///
  /// Loads all conversations at once without delays.
  /// Filters out TypingContent messages.
  void showAllImmediately() {
    _isShowImmediately = true;
    _conversations.clear();
    _conversations.addAll(
      _repository.getAllConversations().where((conversation) {
        if (conversation is Message && conversation.content is TypingContent) {
          return false;
        }
        return true;
      }),
    );
  }

  /// Returns image paths for preloading
  List<String> getImagePathsForCache() {
    return _repository.getImagePathsForCache();
  }

  /// Resets conversation state
  void reset() {
    _isStarted = false;
    _conversations.clear();
  }

  /// Disposes resources
  void dispose() {
    _insertController.close();
    _removeController.close();
  }
}
