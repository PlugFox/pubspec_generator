// @dart=2.12

/// Pubspec Generator - A code generation tool for pubspec.yaml files.
///
/// This library provides functionality to generate Dart code from
/// pubspec.yaml files, making application metadata accessible at runtime.
/// It includes version information, dependencies, and other pubspec
/// metadata as strongly-typed Dart constants.
///
/// ## Usage
///
/// Add to your pubspec.yaml:
/// ```yaml
/// dev_dependencies:
///   build_runner: ^2.3.3
///   pubspec_generator: ^5.0.0
/// ```
///
/// Then run:
/// ```sh
/// dart run build_runner build
/// ```
///
/// This will generate a `pubspec.yaml.g.dart` file with all your
/// pubspec metadata.
///
/// See also:
/// - [builder.dart] for the build_runner integration
library pubspec_generator;

export 'builder.dart';
