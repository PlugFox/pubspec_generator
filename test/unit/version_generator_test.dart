import 'package:pubspec_generator/src/generator/pubspec_generator.dart';
import 'package:pubspec_generator/src/generator/version_generator_mixin.dart';
import 'package:pubspec_generator/src/pubspec_builder_config.dart';
import 'package:test/test.dart';

/// Mock generator for testing version generation.
class MockVersionGenerator extends PubspecGenerator with VersionGeneratorMixin {
  MockVersionGenerator(PubspecBuilderConfig config) : super(config: config);
}

/// Tests for VersionGeneratorMixin.
///
/// Validates version parsing, formatting, and code generation.
void main() {
  group('VersionGeneratorMixin', () {
    late MockVersionGenerator generator;

    setUp(() {
      generator = MockVersionGenerator(
        PubspecBuilderConfig(
          output: 'lib/test.dart',
          timestamp: false,
        ),
      );
    });

    test('generates version from simple version string', () {
      final pubspec = <String, Object>{
        'version': '1.2.3',
      };

      final lines = generator.generate(pubspec).toList();
      final output = lines.join('\n');

      expect(output, contains('representation: r\'1.2.3\''));
      expect(output, contains('canonical: r\'1.2.3\''));
      expect(output, contains('major: 1'));
      expect(output, contains('minor: 2'));
      expect(output, contains('patch: 3'));
      expect(output, contains('preRelease: <String>[]'));
      expect(output, contains('build: <String>[]'));
    });

    test('generates version with pre-release identifier', () {
      final pubspec = <String, Object>{
        'version': '2.0.0-beta.1',
      };

      final lines = generator.generate(pubspec).toList();
      final output = lines.join('\n');

      expect(output, contains('representation: r\'2.0.0-beta.1\''));
      expect(output, contains('major: 2'));
      expect(output, contains('minor: 0'));
      expect(output, contains('patch: 0'));
      expect(output, contains('preRelease: <String>[r\'beta\', r\'1\']'));
    });

    test('generates version with build identifier', () {
      final pubspec = <String, Object>{
        'version': '1.0.0+build.42',
      };

      final lines = generator.generate(pubspec).toList();
      final output = lines.join('\n');

      expect(output, contains('representation: r\'1.0.0+build.42\''));
      expect(output, contains('build: <String>[r\'build\', r\'42\']'));
    });

    test('generates version with both pre-release and build', () {
      final pubspec = <String, Object>{
        'version': '3.1.4-alpha.2+exp.sha.5114f85',
      };

      final lines = generator.generate(pubspec).toList();
      final output = lines.join('\n');

      expect(output, contains('3.1.4-alpha.2+exp.sha.5114f85'));
      expect(output, contains('major: 3'));
      expect(output, contains('minor: 1'));
      expect(output, contains('patch: 4'));
      expect(
        output,
        contains('preRelease: <String>[r\'alpha\', r\'2\']'),
      );
      expect(
        output,
        contains('build: <String>[r\'exp\', r\'sha\', r\'5114f85\']'),
      );
    });

    test('handles missing version', () {
      final pubspec = <String, Object>{
        'name': 'test_package',
      };

      final lines = generator.generate(pubspec).toList();
      final output = lines.join('\n');

      // Should generate Version.none (0.0.0)
      expect(output, contains('major: 0'));
      expect(output, contains('minor: 0'));
      expect(output, contains('patch: 0'));
    });

    test('handles empty version string', () {
      final pubspec = <String, Object>{
        'version': '',
      };

      final lines = generator.generate(pubspec).toList();
      final output = lines.join('\n');

      // Should generate Version.none (0.0.0)
      expect(output, contains('major: 0'));
      expect(output, contains('minor: 0'));
      expect(output, contains('patch: 0'));
    });

    test('handles version with only whitespace', () {
      final pubspec = <String, Object>{
        'version': '   ',
      };

      final lines = generator.generate(pubspec).toList();
      final output = lines.join('\n');

      // Should generate Version.none (0.0.0)
      expect(output, contains('major: 0'));
      expect(output, contains('minor: 0'));
      expect(output, contains('patch: 0'));
    });

    test('handles invalid version format', () {
      final pubspec = <String, Object>{
        'version': 'invalid.version.string',
      };

      final lines = generator.generate(pubspec).toList();
      final output = lines.join('\n');

      // Should fallback to Version.none (0.0.0)
      expect(output, contains('major: 0'));
      expect(output, contains('minor: 0'));
      expect(output, contains('patch: 0'));
    });

    test('generates version documentation', () {
      final pubspec = <String, Object>{
        'version': '1.0.0',
      };

      final lines = generator.generate(pubspec).toList();
      final output = lines.join('\n');

      expect(output, contains('/// Version'));
      expect(output, contains('/// Current app [version]'));
      expect(output, contains('semantic versioning'));
    });

    test('generates PubspecVersion constant', () {
      final pubspec = <String, Object>{
        'version': '1.0.0',
      };

      final lines = generator.generate(pubspec).toList();
      final output = lines.join('\n');

      expect(output, contains('static const PubspecVersion version'));
    });

    test('handles version with multiple pre-release parts', () {
      final pubspec = <String, Object>{
        'version': '1.0.0-rc.1.2.3',
      };

      final lines = generator.generate(pubspec).toList();
      final output = lines.join('\n');

      expect(
        output,
        contains('preRelease: <String>[r\'rc\', r\'1\', r\'2\', r\'3\']'),
      );
    });

    test('handles version with multiple build parts', () {
      final pubspec = <String, Object>{
        'version': '1.0.0+build.123.abc',
      };

      final lines = generator.generate(pubspec).toList();
      final output = lines.join('\n');

      expect(
        output,
        contains('build: <String>[r\'build\', r\'123\', r\'abc\']'),
      );
    });

    test('preserves original version representation', () {
      final pubspec = <String, Object>{
        'version': '  1.2.3-beta+build  ',
      };

      final lines = generator.generate(pubspec).toList();
      final output = lines.join('\n');

      // Should trim whitespace but preserve the version string
      expect(output, contains('1.2.3-beta+build'));
    });

    test('generates canonical version for complex versions', () {
      final pubspec = <String, Object>{
        'version': '1.2.3-alpha.1+build.456',
      };

      final lines = generator.generate(pubspec).toList();
      final output = lines.join('\n');

      expect(output, contains('canonical: r\'1.2.3-alpha.1+build.456\''));
    });

    test('handles zero major version', () {
      final pubspec = <String, Object>{
        'version': '0.1.0',
      };

      final lines = generator.generate(pubspec).toList();
      final output = lines.join('\n');

      expect(output, contains('major: 0'));
      expect(output, contains('minor: 1'));
      expect(output, contains('patch: 0'));
    });

    test('handles large version numbers', () {
      final pubspec = <String, Object>{
        'version': '999.888.777',
      };

      final lines = generator.generate(pubspec).toList();
      final output = lines.join('\n');

      expect(output, contains('major: 999'));
      expect(output, contains('minor: 888'));
      expect(output, contains('patch: 777'));
    });

    test('generates inline documentation for version fields', () {
      final pubspec = <String, Object>{
        'version': '1.0.0',
      };

      final lines = generator.generate(pubspec).toList();
      final output = lines.join('\n');

      expect(
        output,
        contains('/// Non-canonical string representation'),
      );
      expect(output, contains('/// MAJOR version'));
      expect(output, contains('/// MINOR version'));
      expect(output, contains('/// PATCH version'));
      expect(output, contains('/// The pre-release identifier'));
      expect(output, contains('/// The build identifier'));
    });

    test('formats output as a record', () {
      final pubspec = <String, Object>{
        'version': '1.0.0',
      };

      final lines = generator.generate(pubspec).toList();
      final output = lines.join('\n');

      // Check for record syntax
      expect(output, contains('= ('));
      expect(output, contains('representation:'));
      expect(output, contains('canonical:'));
      expect(output, contains('major:'));
      expect(output, contains('minor:'));
      expect(output, contains('patch:'));
      expect(output, contains('preRelease:'));
      expect(output, contains('build:'));
      expect(output, contains(')'));
    });
  });
}
