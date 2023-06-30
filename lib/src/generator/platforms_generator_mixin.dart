// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'package:pubspec_generator/src/generator/pubspec_generator.dart';
import 'package:pubspec_generator/src/generator/representation.dart';

/// {@nodoc}
mixin PlatformsGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    final data = pubspec['platforms'];
    final buffer = StringBuffer()
      ..writeln(_$platformsDescription)
      ..write('static const Map<String, Object> platforms = ');
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

const String _$platformsDescription = '''
/// Platforms
///
/// Current app [platforms]
///
/// When you [publish a package](https://dart.dev/tools/pub/publishing),
/// pub.dev automatically detects the platforms that the package supports.
/// If this platform-support list is incorrect,
/// use platforms to explicitly declare which platforms your package supports.
///
/// For example, the following platforms entry causes
/// pub.dev to list the package as supporting
/// Android, iOS, Linux, macOS, Web, and Windows:
///
/// ```yaml
/// # This package supports all platforms listed below.
/// platforms:
///   android:
///   ios:
///   linux:
///   macos:
///   web:
///   windows:
/// ```
///
/// Here is an example of declaring that the package supports only Linux and macOS (and not, for example, Windows):
///
/// ```yaml
/// # This package supports only Linux and macOS.
/// platforms:
///   linux:
///   macos:
/// ```''';
