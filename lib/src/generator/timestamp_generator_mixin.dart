// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'package:pubspec_generator/src/generator/pubspec_generator.dart';

/// {@nodoc}
mixin TimestampGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    final now = DateTime.now();
    final builder = StringBuffer()
      ..writeln('/// Build date')
      ..writeln('static final DateTime timestamp = DateTime(')
      ..writeln('  ${now.year},')
      ..writeln('  ${now.month},')
      ..writeln('  ${now.day},')
      ..writeln('  ${now.hour},')
      ..writeln('  ${now.minute},')
      ..writeln('  ${now.second},')
      ..writeln('  ${now.millisecond},')
      ..writeln('  ${now.microsecond},')
      ..writeln(');');
    yield builder.toString();
    yield* super.generate(pubspec);
  }
}
