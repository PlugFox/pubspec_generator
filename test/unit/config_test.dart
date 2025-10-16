import 'package:build/build.dart';
import 'package:pubspec_generator/src/pubspec_builder_config.dart';
import 'package:test/test.dart';

/// Tests for PubspecBuilderConfig.
///
/// Validates configuration parsing, validation, and default values.
void main() {
  group('PubspecBuilderConfig', () {
    group('constructor', () {
      test('creates config with valid parameters', () {
        final config = PubspecBuilderConfig(
          output: 'lib/pubspec.g.dart',
          timestamp: true,
        );

        expect(config.output, equals('lib/pubspec.g.dart'));
        expect(config.timestamp, isTrue);
      });

      test('creates config with timestamp disabled', () {
        final config = PubspecBuilderConfig(
          output: 'lib/pubspec.g.dart',
          timestamp: false,
        );

        expect(config.timestamp, isFalse);
      });

      test('throws on empty output path', () {
        expect(
          () => PubspecBuilderConfig(output: '', timestamp: true),
          throwsA(isA<AssertionError>()),
        );
      });

      test('throws on non-dart output file', () {
        expect(
          () => PubspecBuilderConfig(
            output: 'lib/pubspec.g.txt',
            timestamp: true,
          ),
          throwsA(isA<AssertionError>()),
        );
      });
    });

    group('fromBuilderOptions', () {
      test('uses default output path when not specified', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{}, isRoot: true),
        );

        expect(
          config.output,
          equals('lib/src/constants/pubspec.yaml.g.dart'),
        );
      });

      test('uses default timestamp (true) when not specified', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{}, isRoot: true),
        );

        expect(config.timestamp, isTrue);
      });

      test('parses custom output path', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'output': 'lib/custom/path.dart',
          }, isRoot: true),
        );

        expect(config.output, equals('lib/custom/path.dart'));
      });

      test('parses timestamp as boolean true', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'timestamp': true,
          }, isRoot: true),
        );

        expect(config.timestamp, isTrue);
      });

      test('parses timestamp as boolean false', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'timestamp': false,
          }, isRoot: true),
        );

        expect(config.timestamp, isFalse);
      });

      test('parses timestamp from "time" key', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'time': true,
          }, isRoot: true),
        );

        expect(config.timestamp, isTrue);
      });

      test('parses timestamp from "date" key', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'date': false,
          }, isRoot: true),
        );

        expect(config.timestamp, isFalse);
      });

      test('parses timestamp from "now" key', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'now': true,
          }, isRoot: true),
        );

        expect(config.timestamp, isTrue);
      });

      test('parses timestamp from "ts" key', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'ts': false,
          }, isRoot: true),
        );

        expect(config.timestamp, isFalse);
      });

      test('parses timestamp from "datetime" key', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'datetime': true,
          }, isRoot: true),
        );

        expect(config.timestamp, isTrue);
      });

      test('parses timestamp as string "false"', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'timestamp': 'false',
          }, isRoot: true),
        );

        expect(config.timestamp, isFalse);
      });

      test('parses timestamp as string "no"', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'timestamp': 'no',
          }, isRoot: true),
        );

        expect(config.timestamp, isFalse);
      });

      test('parses timestamp as string "0"', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'timestamp': '0',
          }, isRoot: true),
        );

        expect(config.timestamp, isFalse);
      });

      test('parses timestamp as string "-"', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'timestamp': '-',
          }, isRoot: true),
        );

        expect(config.timestamp, isFalse);
      });

      test('parses timestamp as string "true"', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'timestamp': 'true',
          }, isRoot: true),
        );

        expect(config.timestamp, isTrue);
      });

      test('parses timestamp as string "yes"', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'timestamp': 'yes',
          }, isRoot: true),
        );

        expect(config.timestamp, isTrue);
      });

      test('parses timestamp as number 0', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'timestamp': 0,
          }, isRoot: true),
        );

        expect(config.timestamp, isFalse);
      });

      test('parses timestamp as number 1', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'timestamp': 1,
          }, isRoot: true),
        );

        expect(config.timestamp, isTrue);
      });

      test('parses timestamp as negative number', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'timestamp': -1,
          }, isRoot: true),
        );

        expect(config.timestamp, isFalse);
      });

      test('handles timestamp with whitespace in string', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'timestamp': '  false  ',
          }, isRoot: true),
        );

        expect(config.timestamp, isFalse);
      });

      test('handles mixed case in timestamp string', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'timestamp': 'FALSE',
          }, isRoot: true),
        );

        expect(config.timestamp, isFalse);
      });

      test('throws on invalid output path with ".."', () {
        expect(
          () => PubspecBuilderConfig.fromBuilderOptions(
            const BuilderOptions(<String, Object>{
              'output': '../lib/pubspec.g.dart',
            }, isRoot: true),
          ),
          throwsArgumentError,
        );
      });

      test('throws on absolute output path', () {
        expect(
          () => PubspecBuilderConfig.fromBuilderOptions(
            const BuilderOptions(<String, Object>{
              'output': '/lib/pubspec.g.dart',
            }, isRoot: true),
          ),
          throwsArgumentError,
        );
      });

      test('throws on output path without .dart extension', () {
        expect(
          () => PubspecBuilderConfig.fromBuilderOptions(
            const BuilderOptions(<String, Object>{
              'output': 'lib/pubspec',
            }, isRoot: true),
          ),
          throwsArgumentError,
        );
      });

      test('throws on empty output path', () {
        expect(
          () => PubspecBuilderConfig.fromBuilderOptions(
            const BuilderOptions(<String, Object>{
              'output': '',
            }, isRoot: true),
          ),
          throwsArgumentError,
        );
      });
    });

    group('toString', () {
      test('returns formatted string representation', () {
        final config = PubspecBuilderConfig(
          output: 'lib/pubspec.g.dart',
          timestamp: true,
        );

        final str = config.toString();

        expect(str, contains('PubspecBuilderConfig'));
        expect(str, contains('output: lib/pubspec.g.dart'));
        expect(str, contains('timestamp: true'));
      });

      test('shows false timestamp', () {
        final config = PubspecBuilderConfig(
          output: 'lib/pubspec.g.dart',
          timestamp: false,
        );

        final str = config.toString();

        expect(str, contains('timestamp: false'));
      });
    });

    group('edge cases', () {
      test('handles deeply nested output path', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'output': 'lib/src/generated/constants/pubspec.g.dart',
          }, isRoot: true),
        );

        expect(
          config.output,
          equals('lib/src/generated/constants/pubspec.g.dart'),
        );
      });

      test('handles output path with underscores and dots', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'output': 'lib/my_package.pubspec.yaml.g.dart',
          }, isRoot: true),
        );

        expect(config.output, contains('my_package'));
        expect(config.output, endsWith('.dart'));
      });

      test('timestamp defaults to true with unrecognized value', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'timestamp': 'maybe',
          }, isRoot: true),
        );

        expect(config.timestamp, isTrue);
      });

      test('timestamp defaults to true with object value', () {
        final config = PubspecBuilderConfig.fromBuilderOptions(
          const BuilderOptions(<String, Object>{
            'timestamp': <String, String>{'value': 'true'},
          }, isRoot: true),
        );

        expect(config.timestamp, isTrue);
      });
    });
  });
}
