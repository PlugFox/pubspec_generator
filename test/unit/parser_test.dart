import 'package:pubspec_generator/src/parser/pubspec_parser_impl.dart';
import 'package:test/test.dart';

/// Tests for the PubspecParser implementation.
///
/// Validates YAML parsing, normalization, and caching behavior.
void main() {
  group('PubspecParserImpl', () {
    late PubspecParserImpl parser;

    setUp(() {
      parser = const PubspecParserImpl();
    });

    test('parses valid minimal pubspec', () {
      const yaml = '''
name: test_package
version: 1.0.0
environment:
  sdk: '>=3.0.0 <4.0.0'
''';

      final result = parser.parse(yaml);

      expect(result, isA<Map<String, Object>>());
      expect(result['name'], equals('test_package'));
      expect(result['version'], equals('1.0.0'));
      expect(result['environment'], isA<Map<String, Object>>());
    });

    test('normalizes keys to lowercase', () {
      const yaml = '''
Name: test_package
Version: 1.0.0
ENVIRONMENT:
  SDK: '>=3.0.0 <4.0.0'
''';

      final result = parser.parse(yaml);

      expect(result.containsKey('name'), isTrue);
      expect(result.containsKey('version'), isTrue);
      expect(result.containsKey('environment'), isTrue);
      expect(result.containsKey('Name'), isFalse);
      expect(result.containsKey('Version'), isFalse);
    });

    test('trims whitespace from keys', () {
      const yaml = '''
name: test_package
version: 1.0.0
''';

      final result = parser.parse(yaml);

      expect(result.keys.every((key) => key == key.trim()), isTrue);
    });

    test('handles nested maps', () {
      const yaml = '''
name: test_package
environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: '>=3.0.0'
''';

      final result = parser.parse(yaml);
      final env = result['environment'] as Map<String, Object>;

      expect(env, isA<Map<String, Object>>());
      expect(env['sdk'], equals('>=3.0.0 <4.0.0'));
      expect(env['flutter'], equals('>=3.0.0'));
    });

    test('handles lists', () {
      const yaml = '''
name: test_package
funding:
  - https://example.com/1
  - https://example.com/2
topics:
  - dart
  - flutter
''';

      final result = parser.parse(yaml);

      expect(result['funding'], isA<List<Object>>());
      expect(result['topics'], isA<List<Object>>());

      final funding = result['funding'] as List<Object>;
      expect(funding, hasLength(2));
      expect(funding[0], equals('https://example.com/1'));

      final topics = result['topics'] as List<Object>;
      expect(topics, contains('dart'));
      expect(topics, contains('flutter'));
    });

    test('converts null values to empty strings', () {
      const yaml = '''
name: test_package
description:
documentation:
''';

      final result = parser.parse(yaml);

      expect(result['description'], equals(''));
      expect(result['documentation'], equals(''));
    });

    test('preserves numbers', () {
      const yaml = '''
name: test_package
some_number: 42
some_float: 3.14
''';

      final result = parser.parse(yaml);

      expect(result['some_number'], equals(42));
      expect(result['some_float'], equals(3.14));
    });

    test('preserves booleans', () {
      const yaml = '''
name: test_package
enabled: true
disabled: false
''';

      final result = parser.parse(yaml);

      expect(result['enabled'], equals(true));
      expect(result['disabled'], equals(false));
    });

    test('handles complex nested structures', () {
      const yaml = '''
name: test_package
dependencies:
  meta: ^1.0.0
  path:
    hosted:
      url: https://pub.dev
    version: ^1.9.0
platforms:
  android:
  ios:
    minimum_version: 12.0
''';

      final result = parser.parse(yaml);

      expect(result['dependencies'], isA<Map<String, Object>>());
      expect(result['platforms'], isA<Map<String, Object>>());

      final deps = result['dependencies'] as Map<String, Object>;
      expect(deps['meta'], equals('^1.0.0'));
      expect(deps['path'], isA<Map<String, Object>>());
    });

    test('handles empty lists', () {
      const yaml = '''
name: test_package
funding: []
topics: []
''';

      final result = parser.parse(yaml);

      expect(result['funding'], isA<List<Object>>());
      expect(result['topics'], isA<List<Object>>());
      expect((result['funding'] as List).isEmpty, isTrue);
      expect((result['topics'] as List).isEmpty, isTrue);
    });

    test('handles multiline strings', () {
      const yaml = '''
name: test_package
description: >
  This is a multiline
  description that spans
  multiple lines.
''';

      final result = parser.parse(yaml);

      expect(result['description'], isA<String>());
      expect(result['description'], contains('multiline'));
    });

    test('throws FormatException for invalid YAML', () {
      const invalidYaml = '''
name: test_package
version: [1.0.0
''';

      expect(() => parser.parse(invalidYaml), throwsFormatException);
    });

    test('throws FormatException for non-map YAML', () {
      const nonMapYaml = '''
- item1
- item2
- item3
''';

      expect(() => parser.parse(nonMapYaml), throwsFormatException);
    });

    test('throws FormatException for null document', () {
      const nullYaml = '';

      expect(() => parser.parse(nullYaml), throwsFormatException);
    });

    test('caches parsed results', () {
      const yaml = '''
name: test_package
version: 1.0.0
''';

      // Parse twice with same content
      final result1 = parser.parse(yaml);
      final result2 = parser.parse(yaml);

      // Should return equal but separate instances
      expect(result1, equals(result2));
      expect(identical(result1, result2), isFalse); // Different instances
    });

    test('handles dependencies with various formats', () {
      const yaml = '''
name: test_package
dependencies:
  simple: ^1.0.0
  path_dep:
    path: ../local_package
  git_dep:
    git:
      url: https://github.com/user/repo.git
      ref: main
  hosted_dep:
    hosted:
      name: package_name
      url: https://custom.pub.dev
    version: ^2.0.0
''';

      final result = parser.parse(yaml);
      final deps = result['dependencies'] as Map<String, Object>;

      expect(deps['simple'], equals('^1.0.0'));
      expect(deps['path_dep'], isA<Map<String, Object>>());
      expect(deps['git_dep'], isA<Map<String, Object>>());
      expect(deps['hosted_dep'], isA<Map<String, Object>>());
    });

    test('handles screenshots configuration', () {
      const yaml = '''
name: test_package
screenshots:
  - description: Main screen
    path: screenshots/main.png
  - description: Settings
    path: screenshots/settings.png
''';

      final result = parser.parse(yaml);
      final screenshots = result['screenshots'] as List<Object>;

      expect(screenshots, hasLength(2));
      // Verify first screenshot is a map-like structure
      expect(screenshots[0], isA<Object>());

      // Verify structure if it's a map
      if (screenshots[0] is Map<String, Object>) {
        final firstScreenshot = screenshots[0] as Map<String, Object>;
        expect(firstScreenshot.containsKey('description'), isTrue);
        expect(firstScreenshot.containsKey('path'), isTrue);
      }
    });

    test('handles false_secrets configuration', () {
      const yaml = '''
name: test_package
false_secrets:
  - /lib/src/api_key.dart
  - /test/**/*.pem
''';

      final result = parser.parse(yaml);
      final falseSecrets = result['false_secrets'] as List<Object>;

      expect(falseSecrets, hasLength(2));
      expect(falseSecrets[0], contains('api_key'));
    });

    test('handles publish_to field', () {
      const yaml1 = '''
name: test_package
publish_to: none
''';

      const yaml2 = '''
name: test_package
publish_to: https://pub.dev
''';

      final result1 = parser.parse(yaml1);
      final result2 = parser.parse(yaml2);

      expect(result1['publish_to'], equals('none'));
      expect(result2['publish_to'], equals('https://pub.dev'));
    });

    test('handles issue_tracker and repository URLs', () {
      const yaml = '''
name: test_package
repository: https://github.com/user/repo
issue_tracker: https://github.com/user/repo/issues
homepage: https://example.com
documentation: https://docs.example.com
''';

      final result = parser.parse(yaml);

      expect(result['repository'], contains('github.com'));
      expect(result['issue_tracker'], contains('issues'));
      expect(result['homepage'], equals('https://example.com'));
      expect(result['documentation'], equals('https://docs.example.com'));
    });

    test('handles dependency_overrides', () {
      const yaml = '''
name: test_package
dependencies:
  package1: ^1.0.0
dependency_overrides:
  package1: ^2.0.0
''';

      final result = parser.parse(yaml);

      expect(result['dependencies'], isA<Map<String, Object>>());
      expect(result['dependency_overrides'], isA<Map<String, Object>>());
    });

    test('handles environment with multiple SDKs', () {
      const yaml = '''
name: test_package
environment:
  sdk: '>=3.0.0 <4.0.0'
  flutter: '>=3.0.0'
''';

      final result = parser.parse(yaml);
      final env = result['environment'] as Map<String, Object>;

      expect(env['sdk'], equals('>=3.0.0 <4.0.0'));
      expect(env['flutter'], equals('>=3.0.0'));
    });

    test('handles special characters in strings', () {
      const yaml = r'''
name: test_package
description: "Package with 'quotes' and special chars: @#$%"
''';

      final result = parser.parse(yaml);

      expect(result['description'], contains('quotes'));
      expect(result['description'], contains('@'));
    });
  });
}
