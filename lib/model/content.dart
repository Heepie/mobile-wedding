import 'package:flutter/material.dart';

/// Sealed class representing message content
///
/// Base class for all message types.
/// Uses sealed class for exhaustive switch pattern matching.
sealed class Content {}

/// Plain text message
class TextContent extends Content {
  final String text;

  TextContent({required this.text});
}

/// Rich text message with formatting
class RichTextContent extends Content {
  final String text;

  RichTextContent({required this.text});
}

/// Copyable text message
class CopyableTextContent extends Content {
  final String description;
  final List<String> copyableTextList;

  CopyableTextContent({
    required this.description,
    required this.copyableTextList,
  });
}

/// List of copyable text messages
class CopyableTextListContent extends Content {
  final String title;
  final List<CopyableTextContent> copyableTextList;

  CopyableTextListContent({
    required this.title,
    required this.copyableTextList,
  });
}

/// Base sealed class for media content
///
/// Defines common properties for image, video, and other media types.
sealed class MediaContent extends Content {
  final String path;
  final bool isWidthBigger;
  final Alignment alignment;

  MediaContent({
    required this.path,
    required this.isWidthBigger,
    this.alignment = Alignment.center,
  });
}

/// Local image message
class LocalImageContent extends MediaContent {
  LocalImageContent({
    required super.path,
    required super.isWidthBigger,
    super.alignment,
  });
}

/// Remote image message
class RemoteImageContent extends MediaContent {
  RemoteImageContent({
    required super.path,
    required super.isWidthBigger,
    super.alignment,
  });
}

/// Video message
class VideoContent extends MediaContent {
  final String thumbnailPath;

  VideoContent({
    required super.path,
    required super.isWidthBigger,
    required this.thumbnailPath,
    super.alignment,
  });
}

/// List of media messages
class MediaListContent extends Content {
  final List<MediaContent> mediaList;

  MediaListContent({required this.mediaList});
}

/// Map message with navigation links
class MapContent extends Content {
  final MediaContent image;
  final String naverLink;
  final String kakaoLink;

  MapContent({
    required this.image,
    required this.naverLink,
    required this.kakaoLink,
  });
}

/// Typing indicator message
class TypingContent extends Content {}
