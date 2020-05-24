# pubspec_generator  
  
### Code generator pubspec.yaml.g.dart from pubspec.yaml  
  
Add the following lines to the pubspec.yaml:  
```yaml
dev_dependencies:
  build_runner: '>=1.0.0 <2.0.0'
  pubspec_generator: '>=1.0.0 <2.0.0'
```
  
and then execute in the console:  
```bash
pub run build_runner build
```
  
### Result example:  
```dart
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

/// Get pubspec.yaml as Map<String, dynamic>
const Map<String, dynamic> pubspec = <String, dynamic>{
  'name': r'playground',
  'description': r'dart playground',
  'version': r'0.0.1',
  'author': r'Plague Fox <Plugfox@gmail.com>',
  'homepage': r'https://github.com/plugfox/',
  'environment': <String, dynamic>{
      'sdk': r'>=2.6.0 <3.0.0',
  },
  'dependencies': <String, dynamic>{
      'meta': r'>=1.0.0 <2.0.0',
  },
  'dev_dependencies': <String, dynamic>{
      'test': r'any',
      'build_runner': r'>=1.0.0 <2.0.0',
      'pubspec_generator': r'any',
  },
  'dependency_overrides': <String, dynamic>{
      'pubspec_generator': <String, dynamic>{
        'path': r'E:\git\dart\pubspec_generator',
        'version': r'0.0.7',
      },
  },
  'custom_string': r'hello world',
  'custom_num': 0.12345,
};
```
  