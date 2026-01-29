import 'package:mobile_wedding/model/content.dart';
import 'package:mobile_wedding/model/user.dart';

/// Sealed class representing conversation flow
///
/// Represents the start, end, and messages in a conversation.
/// Uses sealed class for exhaustive switch pattern matching.
sealed class Conversation {}

/// Represents the start of a conversation
class Start extends Conversation {}

/// Represents the end of a conversation
class End extends Conversation {}

/// Represents an actual message in the conversation
///
/// [from] - Message sender
/// [to] - Message recipient
/// [content] - Message content
class Message extends Conversation {
  final User from;
  final User to;
  final Content content;

  Message({required this.from, required this.to, required this.content});
}

/// Wrapper class containing delay information for a conversation
///
/// Used for displaying messages sequentially in AnimatedList.
/// [conversation] - The conversation object
/// [delayMs] - Delay until next message (in milliseconds)
class ConversationWithDelay {
  final Conversation conversation;
  final int delayMs;

  const ConversationWithDelay({
    required this.conversation,
    required this.delayMs,
  });
}

/// Extension to add delay information to a Conversation
///
/// Usage: `Message(...).addDelay(1000)`
extension AddDelay on Conversation {
  ConversationWithDelay addDelay(int delayMs) {
    return ConversationWithDelay(conversation: this, delayMs: delayMs);
  }
}
