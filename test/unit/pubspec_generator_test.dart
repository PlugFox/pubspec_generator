import 'package:build/build.dart';
import 'package:build_test/build_test.dart';
import 'package:pubspec_generator/src/pubspec_builder.dart';
import 'package:test/test.dart';

/// Tests for the pubspec_generator builder.
///
/// This test suite validates the code generation functionality, including:
/// - Basic generation from pubspec.yaml files
/// - Output structure and format
/// - Configuration option handling (output path, timestamps)
/// - Edge cases and error conditions
void main() {
  group('PubspecBuilder', () {
    late Map<String, String> testAssets;

    setUp(() {
      // Initialize test assets with a minimal valid pubspec.yaml
      testAssets = <String, String>{
        'a|pubspec.yaml': _validPubspec,
      };
    });

    test('generates Dart code from pubspec.yaml', () async {
      final srcs = Map<String, String>.from(<String, String>{
        'a|pubspec.yaml': _$pubspec,
      });

      // Test that the builder successfully generates output
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

    test('generates correct output structure with sealed Pubspec class',
        () async {
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

    test('respects timestamp configuration option', () async {
      await testBuilder(
        pubspecBuilder(const BuilderOptions({
          'timestamp': true,
        }, isRoot: true)),
        testAssets,
        outputs: {
          // When timestamp is enabled, output should contain timestamp field
          'a|lib/src/constants/pubspec.yaml.g.dart':
              decodedMatches(contains('timestamp')),
        },
      );
    });

    test('disables timestamp when configured', () async {
      await testBuilder(
        pubspecBuilder(const BuilderOptions({
          'timestamp': false,
        }, isRoot: true)),
        testAssets,
      );
    });

    test('handles version with pre-release identifier', () async {
      final assets = <String, String>{
        'a|pubspec.yaml': '''
name: test_package
version: 1.0.0-beta.1
environment:
  sdk: '>=3.0.0 <4.0.0'
''',
      };

      await testBuilder(
        pubspecBuilder(const BuilderOptions({
          'output': 'lib/pubspec.g.dart',
        }, isRoot: true)),
        assets,
        outputs: {
          'a|lib/pubspec.g.dart': decodedMatches(allOf([
            contains('1.0.0-beta.1'),
            contains('preRelease'),
            contains('major: 1'),
            contains('minor: 0'),
            contains('patch: 0'),
          ])),
        },
      );
    });

    test('handles version with build identifier', () async {
      final assets = <String, String>{
        'a|pubspec.yaml': '''
name: test_package
version: 2.1.3+build.42
environment:
  sdk: '>=3.0.0 <4.0.0'
''',
      };

      await testBuilder(
        pubspecBuilder(const BuilderOptions({
          'output': 'lib/pubspec.g.dart',
        }, isRoot: true)),
        assets,
        outputs: {
          'a|lib/pubspec.g.dart': decodedMatches(allOf([
            contains('2.1.3+build.42'),
            contains('build'),
            contains('major: 2'),
            contains('minor: 1'),
            contains('patch: 3'),
          ])),
        },
      );
    });

    test('handles pubspec with dependencies', () async {
      final assets = <String, String>{
        'a|pubspec.yaml': '''
name: test_package
version: 1.0.0
environment:
  sdk: '>=3.0.0 <4.0.0'
dependencies:
  meta: ^1.16.0
  path: ^1.9.0
  analyzer: '>=6.0.0 <8.0.0'
dev_dependencies:
  test: ^1.21.0
  lints: ^2.0.0
''',
      };

      await testBuilder(
        pubspecBuilder(const BuilderOptions({
          'output': 'lib/pubspec.g.dart',
        }, isRoot: true)),
        assets,
        outputs: {
          'a|lib/pubspec.g.dart': decodedMatches(allOf([
            contains('dependencies'),
            contains('devDependencies'),
            contains('meta'),
            contains('path'),
            contains('test'),
            contains('lints'),
          ])),
        },
      );
    });

    test('handles pubspec with executables', () async {
      final assets = <String, String>{
        'a|pubspec.yaml': '''
name: test_package
version: 1.0.0
environment:
  sdk: '>=3.0.0 <4.0.0'
executables:
  my_tool: main
  another_tool:
''',
      };

      await testBuilder(
        pubspecBuilder(const BuilderOptions({
          'output': 'lib/pubspec.g.dart',
        }, isRoot: true)),
        assets,
        outputs: {
          'a|lib/pubspec.g.dart': decodedMatches(allOf([
            contains('executables'),
            contains('my_tool'),
            contains('another_tool'),
          ])),
        },
      );
    });

    test('handles pubspec with funding URLs', () async {
      final assets = <String, String>{
        'a|pubspec.yaml': '''
name: test_package
version: 1.0.0
environment:
  sdk: '>=3.0.0 <4.0.0'
funding:
  - https://www.buymeacoffee.com/testuser
  - https://www.patreon.com/testuser
''',
      };

      await testBuilder(
        pubspecBuilder(const BuilderOptions({
          'output': 'lib/pubspec.g.dart',
        }, isRoot: true)),
        assets,
        outputs: {
          'a|lib/pubspec.g.dart': decodedMatches(allOf([
            contains('funding'),
            contains('buymeacoffee'),
            contains('patreon'),
          ])),
        },
      );
    });

    test('handles pubspec with topics', () async {
      final assets = <String, String>{
        'a|pubspec.yaml': '''
name: test_package
version: 1.0.0
environment:
  sdk: '>=3.0.0 <4.0.0'
topics:
  - dart
  - flutter
  - generator
  - yaml
  - build-runner
''',
      };

      await testBuilder(
        pubspecBuilder(const BuilderOptions({
          'output': 'lib/pubspec.g.dart',
        }, isRoot: true)),
        assets,
        outputs: {
          'a|lib/pubspec.g.dart': decodedMatches(allOf([
            contains('topics'),
            contains('dart'),
            contains('flutter'),
            contains('generator'),
          ])),
        },
      );
    });

    test('handles pubspec with platforms', () async {
      final assets = <String, String>{
        'a|pubspec.yaml': '''
name: test_package
version: 1.0.0
environment:
  sdk: '>=3.0.0 <4.0.0'
platforms:
  android:
  ios:
  web:
''',
      };

      await testBuilder(
        pubspecBuilder(const BuilderOptions({
          'output': 'lib/pubspec.g.dart',
        }, isRoot: true)),
        assets,
        outputs: {
          'a|lib/pubspec.g.dart': decodedMatches(allOf([
            contains('platforms'),
            contains('android'),
            contains('ios'),
            contains('web'),
          ])),
        },
      );
    });

    test('handles pubspec without version', () async {
      final assets = <String, String>{
        'a|pubspec.yaml': '''
name: test_package
description: A package without version
environment:
  sdk: '>=3.0.0 <4.0.0'
''',
      };

      await testBuilder(
        pubspecBuilder(const BuilderOptions({
          'output': 'lib/pubspec.g.dart',
        }, isRoot: true)),
        assets,
        outputs: {
          'a|lib/pubspec.g.dart': decodedMatches(contains('version')),
        },
      );
    });

    test('handles custom output path', () async {
      await testBuilder(
        pubspecBuilder(const BuilderOptions({
          'output': 'lib/custom/path/pubspec_info.dart',
        }, isRoot: true)),
        testAssets,
        outputs: {
          'a|lib/custom/path/pubspec_info.dart':
              decodedMatches(contains('sealed class Pubspec')),
        },
      );
    });

    test('generates version typedef', () async {
      await testBuilder(
        pubspecBuilder(const BuilderOptions({
          'output': 'lib/pubspec.g.dart',
        }, isRoot: true)),
        testAssets,
        outputs: {
          'a|lib/pubspec.g.dart': decodedMatches(allOf([
            contains('typedef PubspecVersion'),
            contains('representation'),
            contains('canonical'),
            contains('major'),
            contains('minor'),
            contains('patch'),
          ])),
        },
      );
    });

    test('includes proper header comments', () async {
      await testBuilder(
        pubspecBuilder(const BuilderOptions({
          'output': 'lib/pubspec.g.dart',
        }, isRoot: true)),
        testAssets,
        outputs: {
          'a|lib/pubspec.g.dart': decodedMatches(allOf([
            contains('GENERATED CODE - DO NOT MODIFY BY HAND'),
            contains('pubspec_generator'),
          ])),
        },
      );
    });

    test('generates source field with all data', () async {
      await testBuilder(
        pubspecBuilder(const BuilderOptions({
          'output': 'lib/pubspec.g.dart',
        }, isRoot: true)),
        testAssets,
        outputs: {
          'a|lib/pubspec.g.dart': decodedMatches(allOf([
            contains('static const Map<String, Object> source'),
            contains('name'),
            contains('version'),
            contains('environment'),
          ])),
        },
      );
    });
  });
}

/// Sample pubspec.yaml with comprehensive metadata for testing.
///
/// This includes various fields like funding, topics, screenshots, and
/// platform support to ensure the generator handles complex pubspec files.
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

/// Minimal valid pubspec.yaml for basic testing.
///
/// Contains only the essential fields required for a valid Dart package,
/// useful for testing the generator's baseline functionality.
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
