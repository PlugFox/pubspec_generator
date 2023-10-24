// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'package:pubspec_generator/src/generator/pubspec_generator.dart';
import 'package:pubspec_generator/src/generator/representation.dart';

/// {@nodoc}
mixin DependenciesGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    final data = pubspec['dependencies'];
    final buffer = StringBuffer()
      ..writeln(_$dependenciesDescription)
      ..write('static const Map<String, Object> dependencies = ');
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

const String _$dependenciesDescription = '''
/// Dependencies
///
/// Current app [dependencies]
///
/// [Dependencies](https://dart.dev/tools/pub/glossary#dependency)
/// are the pubspec’s `raison d’être`.
/// In this section you list each package that
/// your package needs in order to work.
///
/// Dependencies fall into one of two types.
/// Regular dependencies are listed under dependencies:
/// these are packages that anyone using your package will also need.
/// Dependencies that are only needed in
/// the development phase of the package itself
/// are listed under dev_dependencies.
///
/// During the development process,
/// you might need to temporarily override a dependency.
/// You can do so using dependency_overrides.
///
/// For more information,
/// see [Package dependencies](https://dart.dev/tools/pub/dependencies).''';
