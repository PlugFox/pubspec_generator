// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'dart:async';

import 'package:pub_semver/pub_semver.dart' as ver;
import 'package:build/build.dart';

import 'model.dart';

/// Pubspec builder
Builder pubspecBuilder(BuilderOptions options) => PubspecBuilder();

/// Builder
class PubspecBuilder implements Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    // Each `buildStep` has a single input.
    final inputId = buildStep.inputId;

    if (inputId.path.trim().toLowerCase() != 'pubspec.yaml') return;

    log.info('Found \'pubspec.yaml\'');

    // Create a new target `AssetId` based on the old one.
    final copy =
        AssetId(inputId.package, 'lib/src/constants/${inputId.path}.g.dart');
    final content = await buildStep.readAsString(inputId).then(_generate);

    // Write out the new asset.
    await buildStep.writeAsString(copy, content);

    log.fine('File \'lib/src/constants/${inputId.path}.g.dart\' generated.');
  }

  @override
  final Map<String, List<String>> buildExtensions =
      const <String, List<String>>{
    'pubspec.yaml': <String>['lib/src/constants/pubspec.yaml.g.dart']
  };

  String _generate(String content) {
    final pubspec = PubspecYaml.fromString(content);
    final version = ver.Version.parse(pubspec.version);
    final builder = StringBuffer('// ignore_for_file: unnecessary_raw_strings')
      ..writeln()
      ..writeln('/// Current app version')
      ..writeln('const String version = r\'${version.toString()}\'')
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
      ..write(version.preRelease.map((dynamic v) => 'r\'$v\'').join(','))
      ..writeln('];')
      ..writeln()
      ..writeln('/// The build identifier: "foo" in "1.2.3+foo".')
      ..write('const List<String> build = <String>[')
      ..write(version.build.map((dynamic v) => 'r\'$v\'').join(','))
      ..writeln('];')
      ..writeln()
      ..writeln('/// Build date in Unix Time')
      ..write('const int date = ')
      ..write(DateTime.now().millisecondsSinceEpoch ~/ 1000)
      ..writeln(';')
      ..writeln()
      ..writeln(pubspec);
    return builder.toString();
  }
}
