import 'package:flutter/material.dart';
import 'package:mobile_wedding/config/wedding_config.dart';

const double maxWidth = 700;

const double edgePadding = 10;

const double messageRadius = 12;

const double widthBiggerRatio = 3 / 2;
const double widthSmallerRatio = 2 / 3;

const Color backgroundColor = Color.fromARGB(255, 255, 251, 243);

const String appVersion = 'ver 1.2.0';

const Color sendMessageColor = Color(0xFF67dc6f);

TextSpan spanFromString(String text) {
  final styles = [
    const TextStyle(fontSize: 30),
    const TextStyle(fontSize: 50),
  ];
  final targetWord = List<String>.from(WeddingConfig.nameCharacters);

  final spans = text.split('').map((word) {
    final style = targetWord.contains(word) ? styles[1] : styles[0];
    targetWord.remove(word);
    return TextSpan(style: style, text: word);
  }).toList();

  spans.add(const TextSpan(text: " \u{2764}", style: TextStyle(fontSize: 30)));
  return TextSpan(text: '', children: spans);
}

/// Parses text with **bold** markers into TextSpan
TextSpan parseBoldText(String input) {
  List<TextSpan> spans = [];
  RegExp regExp = RegExp(r"\*\*(.*?)\*\*");
  Iterable<RegExpMatch> matches = regExp.allMatches(input);

  int lastMatchEnd = 0;
  for (final match in matches) {
    if (match.start > lastMatchEnd) {
      spans.add(TextSpan(text: input.substring(lastMatchEnd, match.start)));
    }
    spans.add(
      TextSpan(
        text: match.group(1),
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );
    lastMatchEnd = match.end;
  }

  if (lastMatchEnd < input.length) {
    spans.add(TextSpan(text: input.substring(lastMatchEnd)));
  }

  return TextSpan(children: spans);
}
