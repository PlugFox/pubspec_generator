// ignore_for_file: unnecessary_raw_strings

import 'package:pubspec_generator/src/generator/pubspec_generator.dart';

/// {@nodoc}
mixin ClassGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    yield _$classDescription;
    yield 'sealed class Pubspec {';
    yield* super.generate(pubspec).map<String>(_padding);
    yield '}';
  }

  String _padding(String text) => text
      .split('\n')
      .map<String>((line) => line.isEmpty ? '' : '  $line')
      .join('\n');
}

const String _$classDescription = r'''
/// # The pubspec file
///
/// Code generated pubspec.yaml.g.dart from pubspec.yaml
/// This class is generated from pubspec.yaml, do not edit directly.
///
/// Every pub package needs some metadata so it can specify its dependencies.
/// Pub packages that are shared with others also need to provide some other
/// information so users can discover them. All of this metadata goes
/// in the package’s pubspec:
/// a file named pubspec.yaml that’s written in the YAML language.
///
/// Read more:
/// - https://pub.dev/packages/pubspec_generator
/// - https://dart.dev/tools/pub/pubspec''';
