// ignore_for_file: unnecessary_raw_strings
/// Current app version
const String version = r'1.0.0';

/// The major version number: "1" in "1.2.3".
const int major = 1;

/// The minor version number: "2" in "1.2.3".
const int minor = 0;

/// The patch version number: "3" in "1.2.3".
const int patch = 0;

/// The pre-release identifier: "foo" in "1.2.3-foo".
const List<String> pre = <String>[];

/// The build identifier: "foo" in "1.2.3+foo".
const List<String> build = <String>[];

/// Build date in Unix Time
const int date = 1603133484;

/// Get pubspec.yaml as Map<String, dynamic>
const Map<String, dynamic> pubspec = <String, dynamic>{
  'name': r'pubspec_generator_example',
  'version': r'1.0.0',
  'environment': <String, dynamic>{
    'sdk': r'>=2.6.0 <3.0.0',
  },
  'dev_dependencies': <String, dynamic>{
    'build_runner': r'^1.10.1',
    'pubspec_generator': <String, dynamic>{
      'path': r'../',
    },
  },
};
