// ignore_for_file: avoid_escaping_inner_quotes
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: use_raw_strings
// ignore_for_file: unnecessary_raw_strings

import 'pubspec_generator.dart';

/// {@nodoc}
mixin PropertiesGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    final builder = StringBuffer()
      ..writeln('/// Name [name]')
      ..write('const String name = r\'')
      ..write(_format(pubspec['name'] as String? ?? ''))
      ..writeln('\';')
      ..writeln()
      ..writeln('/// Description [description]')
      ..write('const String description = r\'')
      ..write(_format(pubspec['description'] as String? ?? ''))
      ..writeln('\';')
      ..writeln()
      ..writeln('/// Repository [repository]')
      ..write('const String repository = r\'')
      ..write(_format(pubspec['repository'] as String? ?? ''))
      ..writeln('\';')
      ..writeln()
      ..writeln('/// Issue tracker [issueTracker]')
      ..write('const String issueTracker = r\'')
      ..write(_format(pubspec['issue_tracker'] as String? ?? ''))
      ..writeln('\';')
      ..writeln()
      ..writeln('/// Homepage [homepage]')
      ..write('const String homepage = r\'')
      ..write(_format(pubspec['homepage'] as String? ?? ''))
      ..writeln('\';')
      ..writeln()
      ..writeln('/// Documentation [documentation]')
      ..write('const String documentation = r\'')
      ..write(_format(pubspec['documentation'] as String? ?? ''))
      ..writeln('\';')
      ..writeln()
      ..writeln('/// Publish to [publishTo]')
      ..write('const String publishTo = r\'')
      ..write(_format(pubspec['publish_to'] as String? ?? 'https://pub.dev/'))
      ..writeln('\';');
    yield builder.toString();
    yield* super.generate(pubspec);
  }

  String _format(String text) => text
      .trim()
      .replaceAll('\r', r'')
      .replaceAll('\n', r' ')
      .replaceAll('\'', r'"');
}
