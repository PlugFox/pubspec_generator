// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'package:pub_semver/pub_semver.dart' as ver;

import 'pubspec_generator.dart';

/// {@nodoc}
mixin VersionGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    ver.Version version;
    try {
      version = ver.Version.parse(pubspec['version'].toString());
    } on Object {
      version = ver.Version(0, 0, 0);
    }
    final builder = StringBuffer()
      ..writeln('/// Current app version')
      ..writeln('const String version = r\'${version.toString()}\';')
      ..writeln()
      ..writeln('/// The major version number: "1" in "1.2.3".')
      ..writeln('const int major = ${version.major.toString()};')
      ..writeln()
      ..writeln('/// The minor version number: "2" in "1.2.3".')
      ..writeln('const int minor = ${version.minor.toString()};')
      ..writeln()
      ..writeln('/// The patch version number: "3" in "1.2.3".')
      ..writeln('const int patch = ${version.patch.toString()};')
      ..writeln()
      ..writeln('/// The pre-release identifier: "foo" in "1.2.3-foo".')
      ..write('const List<String> pre = <String>[')
      ..write(version.preRelease
          .where((dynamic element) => element != null)
          .cast<Object>()
          .map<String>((v) => 'r\'$v\'')
          .join(', '))
      ..writeln('];')
      ..writeln()
      ..writeln('/// The build identifier: "foo" in "1.2.3+foo".')
      ..write('const List<String> build = <String>[')
      ..write(version.build
          .where((dynamic element) => element != null)
          .cast<Object>()
          .map<String>((v) => 'r\'$v\'')
          .join(', '))
      ..writeln('];');
    yield builder.toString();
    yield* super.generate(pubspec);
  }
}
