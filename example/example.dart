// ignore_for_file: unnecessary_raw_strings

/// Current app version
const String version = r'0.0.1';

/// The major version number: "1" in "1.2.3".
const int major = 0;

/// The minor version number: "2" in "1.2.3".
const int minor = 0;

/// The patch version number: "3" in "1.2.3".
const int patch = 1;

/// The pre-release identifier: "foo" in "1.2.3-foo".
const List<String> pre = <String>[];

/// The build identifier: "foo" in "1.2.3+foo".
const List<String> build = <String>[];

/// Build date in Unix Time
const int date = 1590350655;

/// Get pubspec.yaml as Map<String, dynamic>
const Map<String, dynamic> pubspec = <String, dynamic>{
  'name': r'playground',
  'description': r'dart playground',
  'version': r'0.0.1',
  'author': r'Plague Fox <Plugfox@gmail.com>',
  'homepage': r'https://github.com/plugfox/',
  'publish_to': r'none',
  'environment': <String, dynamic>{
    'sdk': r'>=2.6.0 <3.0.0',
  },
  'dependencies': <String, dynamic>{
    'meta': r'>=1.0.0 <2.0.0',
  },
  'dev_dependencies': <String, dynamic>{
    'test': r'any',
    'build_runner': r'>=1.0.0 <2.0.0',
    'build_web_compilers': r'>=2.6.1 <3.0.0',
    'pubspec_generator': r'>=1.0.0 <2.0.0',
  },
};
