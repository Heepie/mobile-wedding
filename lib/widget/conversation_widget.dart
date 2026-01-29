import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_wedding/model/content.dart';
import 'package:mobile_wedding/model/conversation.dart';
import 'package:mobile_wedding/model/user.dart';
import 'package:mobile_wedding/router/app_router.dart';
import 'package:mobile_wedding/config/wedding_config.dart';
import 'package:mobile_wedding/util/const.dart';
import 'package:mobile_wedding/viewmodel/conversation_viewmodel.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:mobile_wedding/widget/carousel_image_list.dart';
import 'package:mobile_wedding/widget/copyable_text.dart';
import 'package:mobile_wedding/widget/linkable_map.dart';
import 'package:mobile_wedding/widget/scroll_top_button.dart';
import 'package:mobile_wedding/widget/single_image.dart';

class ConversationWidget extends StatefulWidget {
  final ConversationViewModel viewModel;
  final ScrollController scrollController;

  const ConversationWidget({
    super.key,
    required this.viewModel,
    required this.scrollController,
  });

  @override
  State<ConversationWidget> createState() => _ConversationWidgetState();
}

class _ConversationWidgetState extends State<ConversationWidget> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();
  StreamSubscription<int>? _insertSubscription;
  StreamSubscription<int>? _removeSubscription;
  bool _isInitialized = false;
  bool _isAlreadyCheckedScrollNeed = false;

  @override
  void initState() {
    super.initState();
    _subscribeToStreams();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _isInitialized = true;
      _precacheImages();
      widget.viewModel.startConversation();
    }
  }

  void _precacheImages() {
    for (final path in widget.viewModel.getImagePathsForCache()) {
      precacheImage(AssetImage(path), context);
    }
  }

  void _subscribeToStreams() {
    _insertSubscription = widget.viewModel.onInsert.listen((index) {
      _listKey.currentState?.insertItem(index, duration: Duration.zero);
      _handleScrollIfNeeded(index);

      // End 아이템 추가 시 Padding 제거를 위해 rebuild
      final conversations = widget.viewModel.conversations;
      if (index < conversations.length && conversations[index] is End) {
        setState(() {});
      }
    });

    _removeSubscription = widget.viewModel.onRemove.listen((index) {
      _listKey.currentState?.removeItem(
        index,
        (context, animation) => const SizedBox.shrink(),
        duration: Duration.zero,
      );
    });
  }

  void _handleScrollIfNeeded(int index) {
    final conversations = widget.viewModel.conversations;
    if (index >= conversations.length) return;

    final item = conversations[index];
    if (item is! Message) return;

    bool isSendMessage = item.from == User.me;

    if (isSendMessage &&
        item.content is MediaListContent &&
        !_isAlreadyCheckedScrollNeed) {
      Future.delayed(const Duration(milliseconds: 300), () {
        widget.scrollController.animateTo(
          widget.scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
        _isAlreadyCheckedScrollNeed = true;
      });
    }
  }

  @override
  void dispose() {
    _insertSubscription?.cancel();
    _removeSubscription?.cancel();
    widget.viewModel.dispose();
    super.dispose();
  }

  bool get _hasEnded {
    final conversations = widget.viewModel.conversations;
    return conversations.isNotEmpty && conversations.last is End;
  }

  @override
  Widget build(BuildContext context) {
    final child = widget.viewModel.isShowImmediately
        ? _buildImmediateList()
        : _buildAnimatedList();

    return Padding(
      padding: _hasEnded
          ? EdgeInsetsDirectional.zero
          : const EdgeInsetsDirectional.only(bottom: 200),
      child: child,
    );
  }

  Widget _buildAnimatedList() {
    return AnimatedList(
      key: _listKey,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index, animation) {
        final conversation = widget.viewModel.conversations[index];
        final prevIsSameSender = _checkPrevIsSameSender(index);
        return SlideTransition(
          position: animation.drive(
            Tween(
              begin: const Offset(0, 0.3),
              end: Offset.zero,
            ).chain(CurveTween(curve: Curves.easeOut)),
          ),
          child: FadeTransition(
            opacity: animation,
            child: _buildConversationItem(conversation, prevIsSameSender),
          ),
        );
      },
    );
  }

  Widget _buildImmediateList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.viewModel.conversations.length,
      itemBuilder: (context, index) {
        final prevIsSameSender = _checkPrevIsSameSender(index);
        return _buildConversationItem(
          widget.viewModel.conversations[index],
          prevIsSameSender,
        );
      },
    );
  }

  bool _checkPrevIsSameSender(int index) {
    if (index == 0) return false;
    final current = widget.viewModel.conversations[index];
    final previous = widget.viewModel.conversations[index - 1];
    if (current is! Message || previous is! Message) return false;
    return current.from == previous.from;
  }

  Widget _buildConversationItem(
    Conversation conversation,
    bool prevIsSameSender,
  ) {
    return switch (conversation) {
      Start() => const _EndWidget(text: 'Conversation started'),
      End() => _buildEndWidgets(),
      Message() => _MessageWidget(
        message: conversation,
        prevIsSameSender: prevIsSameSender,
        onMediaTap: _onMediaTap,
        onProfileTap: () => _onProfileTap(context),
      ),
    };
  }

  Widget _buildEndWidgets() {
    return Column(
      children: [
        Padding(
          key: const ValueKey("endMessage"),
          padding: const EdgeInsets.fromLTRB(12, 30, 12, 10),
          child: Center(
            child: SizedBox(
              width: maxWidth,
              height: 200,
              child: AutoSizeText.rich(
                spanFromString(
                    WeddingConfig.endingMessage),
                style: const TextStyle(fontSize: 50),
                minFontSize: 20,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        ScrollTopButton(scrollController: widget.scrollController),
        const Padding(
          padding: EdgeInsets.only(bottom: 2),
          child: Text(
            WeddingConfig.footerText,
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
        ),
        const SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsetsDirectional.only(bottom: 20, end: 16),
            child: Text(appVersion, textAlign: TextAlign.end),
          ),
        ),
      ],
    );
  }

  void _onMediaTap(List<MediaContent> mediaList, int index) {
    context.push(
      '/viewer',
      extra: ImageViewerParams(
        initialIndex: index,
        mediaList: mediaList,
        enableInfiniteScroll: mediaList.length > 1,
      ),
    );
  }

  void _onProfileTap(BuildContext context) {
    context.push(
      '/viewer',
      extra: ImageViewerParams(
        initialIndex: 0,
        mediaList: [
          LocalImageContent(
            path: WeddingConfig.profileTapImage,
            isWidthBigger: false,
            alignment: Alignment.bottomCenter,
          ),
        ],
        enableInfiniteScroll: false,
      ),
    );
  }
}

class _EndWidget extends StatelessWidget {
  final String text;

  const _EndWidget({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: Text(text, style: const TextStyle(color: Colors.grey)),
      ),
    );
  }
}

class _MessageWidget extends StatelessWidget {
  final Message message;
  final bool prevIsSameSender;
  final void Function(List<MediaContent> mediaList, int index)? onMediaTap;
  final VoidCallback? onProfileTap;

  const _MessageWidget({
    required this.message,
    required this.prevIsSameSender,
    this.onMediaTap,
    this.onProfileTap,
  });

  bool get _isReceived => message.from == User.me;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: _buildLeading(),
      title: _buildTitle(),
      subtitle: _buildSubtitle(context),
      contentPadding: const EdgeInsetsDirectional.fromSTEB(
        edgePadding,
        0,
        edgePadding,
        0,
      ),
      titleAlignment: ListTileTitleAlignment.top,
      minVerticalPadding: 2,
    );
  }

  Widget? _buildLeading() {
    if (!_isReceived) return null;

    return GestureDetector(
      onTap: onProfileTap,
      child: CircleAvatar(
        radius: 20,
        backgroundImage:
            prevIsSameSender
                ? null
                : ResizeImage(
                  AssetImage(WeddingConfig.profileImage),
                  width: 160,
                  height: 160,
                ),
        backgroundColor: prevIsSameSender ? backgroundColor : null,
      ),
    );
  }

  Widget _buildTitle() {
    final alignment =
        _isReceived ? CrossAxisAlignment.start : CrossAxisAlignment.end;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        if (!prevIsSameSender && _isReceived)
          Text(WeddingConfig.senderDisplayName, style: const TextStyle(fontSize: 14)),
        if (!prevIsSameSender && !_isReceived) const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    final alignment =
        _isReceived ? CrossAxisAlignment.start : CrossAxisAlignment.end;

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 4, 0, 2),
          child: _buildMessageBubble(context),
        ),
      ],
    );
  }

  Widget _buildMessageBubble(BuildContext context) {
    final bubbleColor =
        _isReceived ? Theme.of(context).colorScheme.surface : sendMessageColor;

    final borderRadius =
        _isReceived
            ? BorderRadius.only(
              topLeft:
                  prevIsSameSender
                      ? const Radius.circular(messageRadius)
                      : Radius.zero,
              topRight: const Radius.circular(messageRadius),
              bottomLeft: const Radius.circular(messageRadius),
              bottomRight: const Radius.circular(messageRadius),
            )
            : BorderRadius.only(
              topLeft: const Radius.circular(messageRadius),
              topRight:
                  prevIsSameSender
                      ? const Radius.circular(messageRadius)
                      : Radius.zero,
              bottomLeft: const Radius.circular(messageRadius),
              bottomRight: const Radius.circular(messageRadius),
            );

    return Material(
      type: MaterialType.card,
      borderRadius: borderRadius,
      elevation: 1,
      color: bubbleColor,
      surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: _buildContent(context, message.content),
      ),
    );
  }

  Widget _buildContent(BuildContext context, Content content) {
    final textColor = _isReceived ? null : Colors.black;

    return switch (content) {
      TextContent() => Text(content.text, style: TextStyle(color: textColor)),
      RichTextContent() => Text.rich(
        parseBoldText(content.text),
        style: TextStyle(color: textColor),
      ),
      CopyableTextContent() => Text(
        content.description,
        style: TextStyle(color: textColor),
      ),
      CopyableTextListContent() => CopyableTextWidget(content: content),
      LocalImageContent() => SingleImage(
        path: content.path,
        isRemote: false,
        isWidthBigger: content.isWidthBigger,
        alignment: content.alignment,
        onTap: () => onMediaTap?.call([content], 0),
      ),
      RemoteImageContent() => SingleImage(
        path: content.path,
        isRemote: true,
        isWidthBigger: content.isWidthBigger,
        alignment: content.alignment,
        onTap: () => onMediaTap?.call([content], 0),
      ),
      VideoContent() => SingleImage(
        path: content.thumbnailPath,
        isRemote: false,
        isWidthBigger: content.isWidthBigger,
        alignment: content.alignment,
        isVideoThumbnail: true,
        onTap: () => onMediaTap?.call([content], 0),
      ),
      MediaListContent() => CarouselImageList(
        mediaList: content.mediaList,
        onItemTap: (index) => onMediaTap?.call(content.mediaList, index),
      ),
      MapContent() => LinkableMapWidget(content: content),
      TypingContent() => Image.asset(
        'assets/images/typing.gif',
        width: 50,
        height: 30,
        color: const Color(0xFF777D04),
      ),
    };
  }
}
