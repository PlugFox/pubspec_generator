// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic
// ignore_for_file: unnecessary_raw_strings

import 'package:meta/meta.dart';
import 'package:pub_semver/pub_semver.dart' as ver;
import 'package:pubspec_generator/src/generator/pubspec_generator.dart';

@internal
@immutable
mixin VersionGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    final versionRaw = pubspec['version']?.toString().trim();
    ver.Version version;
    try {
      version = versionRaw?.isEmpty ?? true
          ? ver.Version.none
          : ver.Version.parse(versionRaw!);
    } on Object {
      version = ver.Version.none;
    }
    final record = _versionRepresentation(versionRaw, version);
    yield _$versionDescription;
    yield 'static const PubspecVersion version = $record;';
    yield '';
    yield* super.generate(pubspec);
  }

  String _versionRepresentation(String? raw, ver.Version version) => '(\n'
      '  /// Non-canonical string representation of the version as provided\n'
      '  /// in the pubspec.yaml file.\n'
      '  representation: r\'${raw ?? ''}\',\n'
      '\n'
      '  /// Returns a \'canonicalized\' representation\n'
      '  /// of the application version.\n'
      '  /// This represents the version string in accordance with\n'
      '  /// Semantic Versioning (SemVer) standards.\n'
      '  canonical: r\'${version.canonicalizedVersion}\',\n'
      '\n'
      '  /// MAJOR version when you make incompatible API changes.\n'
      '  /// The major version number: 1 in "1.2.3".\n'
      '  major: ${version.major},\n'
      '\n'
      '  /// MINOR version when you add functionality\n'
      '  /// in a backward compatible manner.\n'
      '  /// The minor version number: 2 in "1.2.3".\n'
      '  minor: ${version.minor},\n'
      '\n'
      '  /// PATCH version when you make backward compatible bug fixes.\n'
      '  /// The patch version number: 3 in "1.2.3".\n'
      '  patch: ${version.patch},\n'
      '\n'
      '  /// The pre-release identifier: "foo" in "1.2.3-foo".\n'
      '  preRelease: <String>[${_preRelease(version.preRelease)}],\n'
      '\n'
      '  /// The build identifier: "foo" in "1.2.3+foo".\n'
      '  build: <String>[${_build(version.build)}],\n'
      ')';

  String _preRelease(List<Object> preRelease) => preRelease
      .map<String>((e) => e.toString())
      .where((e) => e.isNotEmpty)
      .map<String>(
        (e) => 'r\'$e\'',
      )
      .join(', ');

  String _build(List<Object> build) => build
      .map<String>((e) => e.toString())
      .where((e) => e.isNotEmpty)
      .map<String>(
        (e) => 'r\'$e\'',
      )
      .join(', ');
}

const String _$versionDescription = r'''
/// Version
///
/// Current app [version]
///
/// Every package has a version.
/// A version number is required to host your package on the pub.dev site,
/// but can be omitted for local-only packages.
/// If you omit it, your package is implicitly versioned 0.0.0.
///
/// Versioning is necessary for reusing code while letting it evolve quickly.
/// A version number is three numbers separated by dots, like 0.2.43.
/// It can also optionally have a build ( +1, +2, +hotfix.oopsie)
/// or prerelease (-dev.4, -alpha.12, -beta.7, -rc.5) suffix.
///
/// Each time you publish your package, you publish it at a specific version.
/// Once that’s been done, consider it hermetically sealed:
/// you can’t touch it anymore. To make more changes,
/// you’ll need a new version.
///
/// When you select a version,
/// follow [semantic versioning](https://semver.org/).''';
