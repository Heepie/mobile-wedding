import 'package:flutter/material.dart';
import 'package:mobile_wedding/util/const.dart';

class ScrollTopButton extends StatelessWidget {
  final ScrollController scrollController;

  const ScrollTopButton({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: maxWidth),
      child: Container(
        margin: const EdgeInsets.only(top: 30, bottom: 60),
        child: Align(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 8, 16),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white24,
              ),
              child: IconButton(
                icon: Icon(
                  color: Theme.of(context).colorScheme.onSecondaryFixedVariant,
                  Icons.arrow_upward_rounded,
                  size: 60,
                ),
                tooltip: "맨 위로",
                onPressed: () {
                  scrollController.animateTo(
                    0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.ease,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
