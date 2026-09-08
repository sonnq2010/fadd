import 'dart:convert';
import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('localization contracts', () {
    test('all locales define the same leaf keys', () {
      final englishKeys = _readLeafKeys('assets/translations/en.json');
      final vietnameseKeys = _readLeafKeys('assets/translations/vi.json');

      final missingInEnglish = vietnameseKeys.difference(englishKeys);
      final missingInVietnamese = englishKeys.difference(vietnameseKeys);

      expect(
        missingInEnglish,
        isEmpty,
        reason: 'Missing English keys: ${missingInEnglish.join(', ')}',
      );
      expect(
        missingInVietnamese,
        isEmpty,
        reason: 'Missing Vietnamese keys: ${missingInVietnamese.join(', ')}',
      );
    });

    test('production code uses generated locale keys', () {
      final rawTranslation = RegExp(
        r'''(?:'[^']+'|"[^"]+")\s*\.tr\(''',
        multiLine: true,
      );
      final violations = <String>[];

      for (final entity in Directory('lib').listSync(recursive: true)) {
        if (entity is! File || !entity.path.endsWith('.dart')) {
          continue;
        }
        if (entity.path.contains(
          '${Platform.pathSeparator}generated${Platform.pathSeparator}',
        )) {
          continue;
        }

        final source = entity.readAsStringSync();
        for (final match in rawTranslation.allMatches(source)) {
          final line =
              '\n'.allMatches(source.substring(0, match.start)).length + 1;
          violations.add('${entity.path}:$line: ${match.group(0)}');
        }
      }

      expect(
        violations,
        isEmpty,
        reason:
            'Replace raw translation keys with LocaleKeys:\n${violations.join('\n')}',
      );
    });
  });
}

Set<String> _readLeafKeys(String path) {
  final decoded = jsonDecode(File(path).readAsStringSync());
  return _collectLeafKeys(decoded as Map<String, dynamic>);
}

Set<String> _collectLeafKeys(
  Map<String, dynamic> values, [
  String prefix = '',
]) {
  final keys = <String>{};

  for (final entry in values.entries) {
    final key = prefix.isEmpty ? entry.key : '$prefix.${entry.key}';
    if (entry.value is Map<String, dynamic>) {
      keys.addAll(_collectLeafKeys(entry.value as Map<String, dynamic>, key));
    } else {
      keys.add(key);
    }
  }

  return keys;
}
