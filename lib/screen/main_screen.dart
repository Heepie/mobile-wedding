import 'package:flutter/material.dart';
import 'package:mobile_wedding/util/const.dart';
import 'package:mobile_wedding/viewmodel/conversation_viewmodel.dart';
import 'package:mobile_wedding/widget/announcement.dart';
import 'package:mobile_wedding/widget/conversation_widget.dart';
import 'package:mobile_wedding/widget/date_divider.dart';

class MainScreen extends StatefulWidget {
  final ConversationViewModel viewModel;

  const MainScreen({super.key, required this.viewModel});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onShowImmediately() {
    widget.viewModel.reset();
    widget.viewModel.showAllImmediately();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView(
          controller: _scrollController,
          children: [
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: maxWidth),
                child: Announcement(onShowImmediately: _onShowImmediately),
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: maxWidth),
                child: const DateDivider(),
              ),
            ),
            Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: maxWidth),
                child: ConversationWidget(
                  viewModel: widget.viewModel,
                  scrollController: _scrollController,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
