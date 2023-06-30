// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic
// ignore_for_file: unnecessary_raw_strings

import 'package:pubspec_generator/src/generator/pubspec_generator.dart';

/// {@nodoc}
mixin TypedefGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    final builder = StringBuffer()
      ..writeln(_$semanticVersioningDescription)
      ..writeln('typedef PubspecVersion = ({')
      ..writeln('  String representation,')
      ..writeln('  String canonical,')
      ..writeln('  String major,')
      ..writeln('  String minor,')
      ..writeln('  String patch,')
      ..writeln('  List<String> preRelease,')
      ..writeln('  List<String> build')
      ..writeln('});');
    yield builder.toString();
    yield* super.generate(pubspec);
  }
}

const String _$semanticVersioningDescription = r'''
/// Given a version number MAJOR.MINOR.PATCH, increment the:
///
/// 1. MAJOR version when you make incompatible API changes
/// 2. MINOR version when you add functionality in a backward compatible manner
/// 3. PATCH version when you make backward compatible bug fixes
///
/// Additional labels for pre-release and build metadata are available
/// as extensions to the MAJOR.MINOR.PATCH format.''';
