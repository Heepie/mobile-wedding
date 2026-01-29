// ignore_for_file: avoid_print
import 'dart:io';

/// Reads wedding_config.dart to extract config values,
/// then generates web/index.html from web/index.template.html.
///
/// Usage: dart run tool/generate_index_html.dart
void main() {
  final configFile = File('lib/config/wedding_config.dart');
  if (!configFile.existsSync()) {
    print('Error: lib/config/wedding_config.dart not found.');
    exit(1);
  }

  final templateFile = File('web/index.template.html');
  if (!templateFile.existsSync()) {
    print('Error: web/index.template.html not found.');
    exit(1);
  }

  final configContent = configFile.readAsStringSync();

  final ogTitle = _extractString(configContent, 'ogTitle');
  final ogDescription = _extractString(configContent, 'ogDescription');
  final ogImage = _extractString(configContent, 'ogImage');

  if (ogTitle == null || ogDescription == null || ogImage == null) {
    print('Error: Could not extract OG tag values from wedding_config.dart.');
    print('  ogTitle: $ogTitle');
    print('  ogDescription: $ogDescription');
    print('  ogImage: $ogImage');
    exit(1);
  }

  var template = templateFile.readAsStringSync();
  template = template.replaceAll('{{OG_TITLE}}', ogTitle);
  template = template.replaceAll('{{OG_DESCRIPTION}}', ogDescription);
  template = template.replaceAll('{{OG_IMAGE}}', ogImage);

  final outputFile = File('web/index.html');
  outputFile.writeAsStringSync(template);
  print('Generated web/index.html successfully.');
  print('  og:title       = $ogTitle');
  print('  og:description = $ogDescription');
  print('  og:image       = $ogImage');
}

String? _extractString(String content, String fieldName) {
  // Match: static const String fieldName = 'value'; or "value"
  final pattern = RegExp(
    "static\\s+const\\s+String\\s+$fieldName\\s*=\\s*['\"](.+?)['\"]\\s*;",
  );
  final match = pattern.firstMatch(content);
  if (match != null) return match.group(1);

  // Handle multi-line with string concatenation using single quotes
  final multiLinePattern = RegExp(
    "static\\s+const\\s+String\\s+$fieldName\\s*=\\s*\\n?\\s*['\"]([^'\"]+)['\"]\\s*;",
    multiLine: true,
  );
  final multiMatch = multiLinePattern.firstMatch(content);
  return multiMatch?.group(1);
}
