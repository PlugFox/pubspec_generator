import 'dart:async';

import 'package:pub_semver/pub_semver.dart' as ver;
import 'package:multiline/multiline.dart';
import 'package:build/build.dart';

import 'model.dart';

/// Builder
class PubspecBuilder implements Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    // Each `buildStep` has a single input.
    final inputId = buildStep.inputId;

    if (inputId.path.trim().toLowerCase() != 'pubspec.yaml') return;

    log.info('Found \'pubspec.yaml\'');

    // Create a new target `AssetId` based on the old one.
    final copy = AssetId(inputId.package, 'lib/src/${inputId.path}.g.dart');
    final content = await buildStep.readAsString(inputId).then(_generate);

    // Write out the new asset.
    await buildStep.writeAsString(copy, content);

    log.fine('File \'lib/src/${inputId.path}.g.dart\' generated.');
  }

  @override
  final Map<String, List<String>> buildExtensions =
      const <String, List<String>>{
    'pubspec.yaml': <String>['lib/src/pubspec.yaml.g.dart']
  };

  String _generate(String content) {
    final _pubspec = PubspecYaml.fromString(content);
    final version = ver.Version.parse(_pubspec.version);
    content = '''
    |/// Current app version
    |const String version = r\'${version.toString()}\';
    |
    |/// The major version number: "1" in "1.2.3".
    |const int major = ${version.major.toString()};
    |
    |/// The minor version number: "2" in "1.2.3".
    |const int minor = ${version.minor.toString()};
    |
    |/// The patch version number: "3" in "1.2.3".
    |const int patch = ${version.patch.toString()};
    |
    |/// The pre-release identifier: "foo" in "1.2.3-foo".
    |const List<String> pre = <String>[${version.preRelease.map((dynamic v) => 'r\'$v\'').join(',')}];
    |
    |/// The build identifier: "foo" in "1.2.3+foo".
    |const List<String> build = <String>[${version.build.map((dynamic v) => 'r\'$v\'').join(',')}];
    |
    |/// Build date in Unix Time
    |const int date = ${DateTime.now().millisecondsSinceEpoch ~/ 1000};
    |
    |
    '''
            .multiline() +
        _pubspec.toString();
    return content;
  }
}
