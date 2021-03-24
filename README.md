# pubspec_generator  
##### Code generator pubspec.yaml.g.dart from pubspec.yaml  
  
[![Actions Status](https://github.com/PlugFox/pubspec_generator/workflows/pubspec_generator/badge.svg)](https://github.com/PlugFox/pubspec_generator/actions)
[![Pub](https://img.shields.io/pub/v/pubspec_generator.svg)](https://pub.dev/packages/pubspec_generator)
[![Likes](https://img.shields.io/badge/dynamic/json?color=blue&label=likes&query=likes&url=http://www.pubscore.gq/likes?package=pubspec_generator&style=flat-square&cacheSeconds=90000)](https://pub.dev/packages/pubspec_generator)
[![Health](https://img.shields.io/badge/dynamic/json?color=blue&label=health&query=pub_points&url=http://www.pubscore.gq/pub-points?package=pubspec_generator&style=flat-square&cacheSeconds=90000)](https://pub.dev/packages/pubspec_generator/score)
[![Code size](https://img.shields.io/github/languages/code-size/plugfox/pubspec_generator?logo=github&logoColor=white)](https://github.com/plugfox/pubspec_generator)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)
[![effective_dart](https://img.shields.io/badge/style-effective_dart-40c4ff.svg)](https://github.com/tenhobi/effective_dart)
[![GitHub stars](https://img.shields.io/github/stars/plugfox/pubspec_generator?style=social)](https://github.com/plugfox/pubspec_generator/)
<!--
[![Coverage](https://codecov.io/gh/PlugFox/pubspec_generator/branch/master/graph/badge.svg)](https://codecov.io/gh/PlugFox/pubspec_generator)
-->
  
  
## Setup  
  
Add the following lines to the pubspec.yaml:  
```yaml
dev_dependencies:
  build_runner: ^1.12.2
  pubspec_generator: ^3.0.0
```
  
and then execute in the console:  
```bash
dart run build_runner build
```
  
  
## Path of creation  

Create `build.yaml` at project root (near with `pubspec.yaml`).  
And set output path:
```yaml
# Read about `build.yaml` at https://pub.dev/packages/build_config
targets:
  $default:
    sources:
      - $package$
      - lib/**
      - pubspec.yaml
    builders:
      pubspec_generator:
        options:
          output: lib/src/constants/pubspec.yaml.g.dart
```
  
  
## Result example  
  
By default, at project path `lib/src/constants/pubspec.yaml.g.dart`:  
  
```dart
/// Current app version
const String version = r'3.0.0-nullsafety.0';

/// The major version number: "1" in "1.2.3".
const int major = 3;

/// The minor version number: "2" in "1.2.3".
const int minor = 0;

/// The patch version number: "3" in "1.2.3".
const int patch = 0;

/// The pre-release identifier: "foo" in "1.2.3-foo".
const List<String> pre = <String>[r'nullsafety', r'0'];

/// The build identifier: "foo" in "1.2.3+foo".
const List<String> build = <String>[];

/// Build date in Unix Time (in seconds)
const int timestamp = 1616624182;

/// Name [name]
const String name = r'pubspec_generator';

/// Description [description]
const String description = r'Code generator pubspec.yaml.g.dart from pubspec.yaml. Just import `pubspec_generator` and then run `dart run build_runner build`';

/// Repository [repository]
const String repository = r'https://github.com/PlugFox/pubspec_generator/tree/master';

/// Issue tracker [issue_tracker]
const String issueTracker = r'https://github.com/PlugFox/pubspec_generator/issues';

/// Homepage [homepage]
const String homepage = r'https://github.com/PlugFox/pubspec_generator';

/// Documentation [documentation]
const String documentation = r'https://github.com/PlugFox/pubspec_generator/tree/master';

/// Publish to [publish_to]
const String publishTo = r'https://pub.dev/';

/// Environment
const Map<String, String> environment = <String, String>{
  'sdk': '>=2.12.0 <3.0.0',
};

/// Dependencies
const Map<String, Object> dependencies = <String, Object>{
  'build': r'^2.0.0',
  'pub_semver': r'^2.0.0',
  'yaml': r'^3.0.0',
};

/// Developer dependencies
const Map<String, Object> devDependencies = <String, Object>{
  'build_runner': r'^1.12.2',
  'build_runner_core': r'^6.0.0',
  'build_test': r'^2.0.0',
  'test': r'^1.16.6',
};

/// Dependency overrides
const Map<String, Object> dependencyOverrides = <String, Object>{};

/// Executables
const Map<String, Object> executables = <String, Object>{};

/// Source data from pubspec.yaml
const Map<String, Object> source = <String, Object>{
  'name': name,
  'description': description,
  'repository': repository,
  'issue_tracker': issueTracker,
  'homepage': homepage,
  'documentation': documentation,
  'publish_to': publishTo,
  'version': version,
  'environment': environment,
  'dependencies': dependencies,
  'dev_dependencies': devDependencies,
  'dependency_overrides': dependencyOverrides,
};
```
  
  
## Changelog  
  
Refer to the [Changelog](https://github.com/plugfox/pubspec_generator/blob/master/CHANGELOG.md) to get all release notes.  
  
  
## Maintainers  
  
[Plague Fox](https://plugfox.dev)  
  
  
## License  
  
[MIT](https://github.com/plugfox/pubspec_generator/blob/master/LICENSE)  
  
  