// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'pubspec_generator.dart';

/// {@nodoc}
mixin TimestampGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    final builder = StringBuffer()
      ..writeln('/// Build date in Unix Time (in seconds)')
      ..write('const int timestamp = ')
      ..write(DateTime.now().millisecondsSinceEpoch ~/ 1000)
      ..writeln(';');
    yield builder.toString();
    yield* super.generate(pubspec);
  }
}
