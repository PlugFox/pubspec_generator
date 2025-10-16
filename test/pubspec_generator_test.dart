import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:pubspec_generator/src/pubspec_builder.dart';
import 'package:test/test.dart';

void main() {
  group('PubspecBuilder', () {
    late Map<String, String> testAssets;

    setUp(() {
      testAssets = <String, String>{
        'a|pubspec.yaml': _validPubspec,
      };
    });

    test('Code generator test', () async {
      final srcs = Map<String, String>.from(<String, String>{
        'a|pubspec.yaml': _$pubspec,
      });

      await testBuilder(
        pubspecBuilder(
          const BuilderOptions(
            <String, Object?>{'output': 'lib/src/pubspec.g.dart'},
            isRoot: true,
          ),
        ),
        srcs,
      );
    });

    test('generates correct output structure', () async {
      await testBuilder(
        pubspecBuilder(const BuilderOptions({
          'output': 'lib/src/pubspec.g.dart',
          'timestamp': false,
        }, isRoot: true)),
        testAssets,
        outputs: {
          'a|lib/src/pubspec.g.dart':
              decodedMatches(contains('sealed class Pubspec')),
        },
      );
    });

    test('respects timestamp configuration', () async {
      await testBuilder(
        pubspecBuilder(const BuilderOptions({
          'timestamp': true,
        }, isRoot: true)),
        testAssets,
        outputs: {
          'a|lib/src/constants/pubspec.yaml.g.dart':
              decodedMatches(contains('timestamp')),
        },
      );
    });
  });
}

// ignore: unnecessary_raw_strings
const String _$pubspec = r'''
name: pubspec_generator
description: >
  Code generator pubspec.yaml.g.dart from pubspec.yaml.
  Just import `pubspec_generator` and then run `dart run build_runner build`
version: 4.0.0-pre.1
repository: https://github.com/PlugFox/pubspec_generator/tree/master
issue_tracker: https://github.com/PlugFox/pubspec_generator/issues
homepage: https://github.com/PlugFox/pubspec_generator
publish_to: https://pub.dev/

funding:
  - https://www.buymeacoffee.com/plugfox
  - https://www.patreon.com/plugfox
  - https://boosty.to/plugfox

#documentation: https://github.com/PlugFox/pubspec_generator/tree/master

#authors:
#  - Plague Fox <plugfox@gmail.com>

topics:
  - yaml
  - pubspec
  - generator
  - build
  - build_runner
  - codegeneration

screenshots:
  - description: 'Version'
    path: .img/version.png

# This package supports all platforms listed below.
platforms:
  android:
  ios:
  linux:
  macos:
  web:
  windows:

environment:
  sdk: '>=3.0.0 <4.0.0'
''';

const String _validPubspec = '''
name: test_package
description: A test package
version: 1.0.0
environment:
  sdk: '>=3.0.0 <4.0.0'
dependencies:
  meta: ^1.16.0
dev_dependencies:
  test: ^1.21.0
''';
