// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'package:meta/meta.dart';
import 'package:pubspec_generator/src/generator/pubspec_generator.dart';
import 'package:pubspec_generator/src/generator/representation.dart';

@internal
@immutable
mixin SourceGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    final buffer = StringBuffer()
      ..writeln('/// Source data from pubspec.yaml')
      ..writeln('static const Map<String, Object> source = <String, Object>{');

    void refToValue(String key, String value) {
      pubspec.remove(key);
      buffer
        ..write('  \'')
        ..write(key)
        ..write('\': ')
        ..write(value)
        ..writeln(',');
    }

    refToValue('name', 'name');
    refToValue('description', 'description');
    refToValue('repository', 'repository');
    refToValue('issue_tracker', 'issueTracker');
    refToValue('homepage', 'homepage');
    refToValue('documentation', 'documentation');
    refToValue('publish_to', 'publishTo');
    refToValue('version', 'version');
    refToValue('funding', 'funding');
    refToValue('false_secrets', 'falseSecrets');
    refToValue('screenshots', 'screenshots');
    refToValue('topics', 'topics');
    refToValue('platforms', 'platforms');
    refToValue('environment', 'environment');
    refToValue('dependencies', 'dependencies');
    refToValue('dev_dependencies', 'devDependencies');
    refToValue('dependency_overrides', 'dependencyOverrides');
    if (pubspec.isNotEmpty) {
      for (final entry in pubspec.entries) {
        buffer
          ..write('  \'')
          ..write(entry.key)
          ..write('\': ');
        representation(
          source: entry.value,
          stringBuffer: buffer,
          initialIndent: 1,
        );
        buffer.writeln(',');
      }
    }
    buffer.writeln('};');
    yield buffer.toString();
    yield* super.generate(pubspec);
  }
}
