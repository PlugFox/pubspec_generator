// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'package:meta/meta.dart';
import 'package:pubspec_generator/src/generator/pubspec_generator.dart';
import 'package:pubspec_generator/src/generator/representation.dart';

@internal
@immutable
mixin DependencyOverridesGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    final data = pubspec['dependency_overrides'];
    final buffer = StringBuffer()
      ..writeln('/// Dependency overrides')
      ..write('static const Map<String, Object> dependencyOverrides = ');
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
