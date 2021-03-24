/*
  
  MIT License
  
  Copyright (c) 2021 Plague Fox
  
  Permission is hereby granted, free of charge, to any person obtaining a copy
  of this software and associated documentation files (the "Software"), to deal
  in the Software without restriction, including without limitation the rights
  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
  copies of the Software, and to permit persons to whom the Software is
  furnished to do so, subject to the following conditions:
  
  The above copyright notice and this permission notice shall be included in all
  copies or substantial portions of the Software.
  
  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
  FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
  SOFTWARE.
   
 */

// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: unnecessary_raw_strings
// ignore_for_file: use_raw_strings
// ignore_for_file: avoid_escaping_inner_quotes
// ignore_for_file: prefer_single_quotes

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
