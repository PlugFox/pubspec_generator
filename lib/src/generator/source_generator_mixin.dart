// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'pubspec_generator.dart';
import 'representation.dart';

/// {@nodoc}
mixin SourceGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> data) sync* {
    /// TODO: формировать хэштаблицу ссылаясь на уже сгенерированные константы
    /// для типовых полей, вместо того, чтоб генерировать с нуля
    final buffer = StringBuffer()
      ..writeln('/// Source data from pubspec.yaml')
      ..writeln('const Map<String, Object> source = <String, Object>{');

    void refToValue(String key, String value) {
      data.remove(key);
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
    refToValue('environment', 'environment');
    refToValue('dependencies', 'dependencies');
    refToValue('dev_dependencies', 'devDependencies');
    refToValue('dependency_overrides', 'dependencyOverrides');
    if (data.isNotEmpty) {
      for (final entry in data.entries) {
        buffer..write('  \'')..write(entry.key)..write('\': ');
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
    yield* super.generate(data);
  }
}
