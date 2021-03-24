// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'pubspec_generator.dart';
import 'representation.dart';

/// {@nodoc}
mixin DevDependenciesGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    final data = pubspec['dev_dependencies'];
    final buffer = StringBuffer()
      ..writeln('/// Developer dependencies')
      ..write('const Map<String, Object> devDependencies = ');
    if (data is Map<String, Object>) {
      representation(source: data, stringBuffer: buffer);
      buffer.writeln(';');
    } else {
      buffer.writeln('<String, Object>{};');
    }
    yield buffer.toString();
    yield* super.generate(pubspec);
  }
}
