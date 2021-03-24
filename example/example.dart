// ignore_for_file: unnecessary_raw_strings

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

/// Build date in Unix Time
const int date = 1616550079;

/// Get pubspec.yaml as Map<String, Object>
const Map<String, Object> pubspec = <String, Object>{
  'name': r'pubspec_generator',
  'description':
      r'Code generator pubspec.yaml.g.dart from pubspec.yaml Just import `pubspec_generator` and then run `pub run build_runner build`\n',
  'version': r'3.0.0-nullsafety.0',
  'repository': r'https://github.com/PlugFox/pubspec_generator/tree/master',
  'issue_tracker': r'https://github.com/PlugFox/pubspec_generator/issues',
  'homepage': r'https://github.com/PlugFox/pubspec_generator',
  'environment': <String, Object>{
    'sdk': r'>=2.12.0 <3.0.0',
  },
  'dependencies': <String, Object>{
    'build': r'^2.0.0',
    'pub_semver': r'^2.0.0',
    'yaml': r'^3.0.0',
  },
  'dev_dependencies': <String, Object>{
    'build_runner': r'^1.12.2',
    'build_runner_core': r'^6.0.0',
    'build_test': r'^2.0.0',
    'test': r'^1.16.6',
  },
};
