import 'package:flutter/material.dart';
import 'package:mobile_wedding/config/wedding_config.dart';
import 'package:mobile_wedding/model/content.dart';
import 'package:mobile_wedding/model/conversation.dart';
import 'package:mobile_wedding/model/user.dart';

/// Local data source providing wedding conversation data
///
/// Contains the wedding invitation conversation flow.
/// Replace content in WeddingConfig with your own wedding details.
class LocalDataSource {
  LocalDataSource._privateConstructor();

  static final LocalDataSource _instance =
      LocalDataSource._privateConstructor();

  factory LocalDataSource() => _instance;

  /// Main conversation data with delays
  final List<ConversationWithDelay> _mainConversation = [
    Message(
      from: User.me,
      to: User.you,
      content: TypingContent(),
    ).addDelay(300),
    Message(
      from: User.me,
      to: User.you,
      content: TextContent(text: WeddingConfig.inviteGreeting),
    ).addDelay(1000),

    // Wedding pictures
    Message(
      from: User.me,
      to: User.you,
      content: MediaListContent(
        mediaList: [
          LocalImageContent(
            path: WeddingConfig.localWeddingImages[0],
            isWidthBigger: false,
            alignment: Alignment.bottomCenter,
          ),
          LocalImageContent(
            path: WeddingConfig.localWeddingImages[1],
            isWidthBigger: true,
          ),
          RemoteImageContent(
            path: WeddingConfig.remoteWeddingImages[0],
            isWidthBigger: false,
          ),
          RemoteImageContent(
            path: WeddingConfig.remoteWeddingImages[1],
            isWidthBigger: false,
            alignment: Alignment.topCenter,
          ),
          RemoteImageContent(
            path: WeddingConfig.remoteWeddingImages[2],
            isWidthBigger: false,
            alignment: Alignment.topCenter,
          ),
          RemoteImageContent(
            path: WeddingConfig.remoteWeddingImages[3],
            isWidthBigger: true,
          ),
          RemoteImageContent(
            path: WeddingConfig.remoteWeddingImages[4],
            isWidthBigger: false,
          ),
          RemoteImageContent(
            path: WeddingConfig.remoteWeddingImages[5],
            isWidthBigger: false,
            alignment: Alignment.topCenter,
          ),
          RemoteImageContent(
            path: WeddingConfig.remoteWeddingImages[6],
            isWidthBigger: true,
          ),
          RemoteImageContent(
            path: WeddingConfig.remoteWeddingImages[7],
            isWidthBigger: true,
          ),
          LocalImageContent(
            path: WeddingConfig.localWeddingImages[2],
            isWidthBigger: false,
            alignment: Alignment.center,
          ),
        ],
      ),
    ).addDelay(1000),

    Message(
      from: User.you,
      to: User.me,
      content: TextContent(text: WeddingConfig.questionWhen),
    ).addDelay(1500),

    // Map
    Message(
      from: User.me,
      to: User.you,
      content: TypingContent(),
    ).addDelay(700),
    Message(
      from: User.me,
      to: User.you,
      content: TextContent(text: WeddingConfig.dateVenueMessage),
    ).addDelay(1500),
    Message(
      from: User.me,
      to: User.you,
      content: MapContent(
        image: LocalImageContent(
          path: WeddingConfig.mapImage,
          isWidthBigger: true,
        ),
        naverLink: WeddingConfig.naverMapLink,
        kakaoLink: WeddingConfig.kakaoMapLink,
      ),
    ).addDelay(1500),

    Message(
      from: User.you,
      to: User.me,
      content: TextContent(text: WeddingConfig.questionAccount),
    ).addDelay(1000),

    // Copyable text
    Message(
      from: User.me,
      to: User.you,
      content: TypingContent(),
    ).addDelay(700),
    Message(
      from: User.me,
      to: User.you,
      content: TextContent(text: WeddingConfig.accountGuideMessage),
    ).addDelay(1000),
    Message(
      from: User.me,
      to: User.you,
      content: CopyableTextListContent(
        title: WeddingConfig.copyableTitle,
        copyableTextList: [
          CopyableTextContent(
            description: WeddingConfig.groomSideLabel,
            copyableTextList: WeddingConfig.groomAccounts,
          ),
          CopyableTextContent(
            description: WeddingConfig.brideSideLabel,
            copyableTextList: WeddingConfig.brideAccounts,
          ),
        ],
      ),
    ).addDelay(1000),

    // History
    Message(
      from: User.you,
      to: User.me,
      content: TextContent(text: WeddingConfig.questionHistory),
    ).addDelay(1000),
    Message(
      from: User.me,
      to: User.you,
      content: TypingContent(),
    ).addDelay(700),
    Message(
      from: User.me,
      to: User.you,
      content: TextContent(text: WeddingConfig.historyIntro),
    ).addDelay(1000),
    Message(
      from: User.me,
      to: User.you,
      content: MediaListContent(
        mediaList: [
          LocalImageContent(
            path: WeddingConfig.localGroomHistoryImages[0],
            isWidthBigger: false,
            alignment: Alignment.topCenter,
          ),
          LocalImageContent(
            path: WeddingConfig.localGroomHistoryImages[1],
            isWidthBigger: false,
            alignment: Alignment.topCenter,
          ),
          RemoteImageContent(
            path: WeddingConfig.remoteGroomHistoryImages[0],
            isWidthBigger: false,
            alignment: Alignment.topCenter,
          ),
          RemoteImageContent(
            path: WeddingConfig.remoteGroomHistoryImages[1],
            isWidthBigger: false,
            alignment: Alignment.topCenter,
          ),
          RemoteImageContent(
            path: WeddingConfig.remoteGroomHistoryImages[2],
            isWidthBigger: false,
            alignment: Alignment.topCenter,
          ),
          LocalImageContent(
            path: WeddingConfig.localGroomHistoryImages[2],
            isWidthBigger: false,
            alignment: Alignment.topCenter,
          ),
        ],
      ),
    ).addDelay(1000),

    Message(
      from: User.me,
      to: User.you,
      content: TextContent(text: WeddingConfig.groomHistoryDescription),
    ).addDelay(1000),

    Message(
      from: User.me,
      to: User.you,
      content: TypingContent(),
    ).addDelay(500),
    Message(
      from: User.me,
      to: User.you,
      content: MediaListContent(
        mediaList: [
          LocalImageContent(
            path: WeddingConfig.localBrideHistoryImages[0],
            isWidthBigger: false,
            alignment: Alignment.topCenter,
          ),
          LocalImageContent(
            path: WeddingConfig.localBrideHistoryImages[1],
            isWidthBigger: true,
          ),
          RemoteImageContent(
            path: WeddingConfig.remoteBrideHistoryImages[0],
            isWidthBigger: true,
          ),
          RemoteImageContent(
            path: WeddingConfig.remoteBrideHistoryImages[1],
            isWidthBigger: true,
          ),
          RemoteImageContent(
            path: WeddingConfig.remoteBrideHistoryImages[2],
            isWidthBigger: true,
          ),
          LocalImageContent(
            path: WeddingConfig.localBrideHistoryImages[2],
            isWidthBigger: false,
            alignment: Alignment.topCenter,
          ),
        ],
      ),
    ).addDelay(1000),

    Message(
      from: User.me,
      to: User.you,
      content: TextContent(text: WeddingConfig.brideHistoryDescription),
    ).addDelay(1000),

    // Attraction
    Message(
      from: User.you,
      to: User.me,
      content: TextContent(text: WeddingConfig.questionAttraction),
    ).addDelay(1000),
    Message(
      from: User.me,
      to: User.you,
      content: TypingContent(),
    ).addDelay(700),
    Message(
      from: User.me,
      to: User.you,
      content: RichTextContent(text: WeddingConfig.attractionAnswer),
    ).addDelay(1500),
    Message(
      from: User.me,
      to: User.you,
      content: TextContent(text: WeddingConfig.hobbyMessage),
    ).addDelay(300),
    Message(
      from: User.me,
      to: User.you,
      content: MediaListContent(
        mediaList: [
          LocalImageContent(
            path: WeddingConfig.localHobbyImages[0],
            isWidthBigger: true,
          ),
          LocalImageContent(
            path: WeddingConfig.localHobbyImages[1],
            isWidthBigger: true,
          ),
          VideoContent(
            path: WeddingConfig.hobbyBrideVideo,
            isWidthBigger: true,
            thumbnailPath: WeddingConfig.hobbyBrideVideoThumbnail,
          ),
          RemoteImageContent(
            path: WeddingConfig.remoteHobbyImages[0],
            isWidthBigger: false,
          ),
          VideoContent(
            path: WeddingConfig.hobbyGroomVideo,
            isWidthBigger: false,
            thumbnailPath: WeddingConfig.hobbyGroomVideoThumbnail,
            alignment: Alignment.topCenter,
          ),
          RemoteImageContent(
            path: WeddingConfig.remoteHobbyImages[1],
            isWidthBigger: true,
          ),
          RemoteImageContent(
            path: WeddingConfig.remoteHobbyImages[2],
            isWidthBigger: true,
          ),
          RemoteImageContent(
            path: WeddingConfig.remoteHobbyImages[3],
            isWidthBigger: true,
          ),
          LocalImageContent(
            path: WeddingConfig.localHobbyImages[2],
            isWidthBigger: true,
          ),
        ],
      ),
    ).addDelay(1000),
    Message(
      from: User.you,
      to: User.me,
      content: TextContent(text: WeddingConfig.hobbyReaction),
    ).addDelay(1000),

    Message(
      from: User.me,
      to: User.you,
      content: TypingContent(),
    ).addDelay(700),
    Message(
      from: User.me,
      to: User.you,
      content: LocalImageContent(
        path: WeddingConfig.localWeddingImages[3],
        isWidthBigger: true,
      ),
    ).addDelay(1000),

    End().addDelay(300),
  ];

  /// Returns list of conversations with delay information
  List<ConversationWithDelay> getConversationList() => _mainConversation;

  /// Returns list of image paths for preloading
  List<String> getImagePathsForCache() {
    return WeddingConfig.imagesToPreload;
  }
}
