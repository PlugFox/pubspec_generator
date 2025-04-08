// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'package:meta/meta.dart';
import 'package:pubspec_generator/src/generator/pubspec_generator.dart';
import 'package:pubspec_generator/src/generator/representation.dart';

@internal
@immutable
mixin ExecutablesGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    final data = pubspec['executables'];
    final buffer = StringBuffer()
      ..writeln(_$executablesDescription)
      ..write('static const Map<String, Object> executables = ');
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

const String _$executablesDescription = '''
/// Executables
///
/// Current app [executables]
///
/// A package may expose one or more of its scripts as executables
/// that can be run directly from the command line.
/// To make a script publicly available,
/// list it under the executables field.
/// Entries are listed as key/value pairs:
///
/// ```yaml
/// <name-of-executable>: <Dart-script-from-bin>
/// ```
///
/// For example, the following pubspec entry lists two scripts:
///
/// ```yaml
/// executables:
///   slidy: main
///   fvm:
/// ```
///
/// Once the package is activated using pub global activate,
/// typing `slidy` executes `bin/main.dart`.
/// Typing `fvm` executes `bin/fvm.dart`.
/// If you don’t specify the value, it is inferred from the key.
///
/// For more information, see pub global.''';
