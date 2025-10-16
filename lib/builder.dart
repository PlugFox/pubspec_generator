// @dart=2.12

/// Build integration for pubspec_generator.
///
/// This library provides the builder function that integrates with the
/// build_runner package. It uses conditional imports to provide a stub
/// implementation for web environments where dart:io is not available.
///
/// The builder is configured in build.yaml and generates Dart code from
/// pubspec.yaml files during the build process.
library pubspec_generator.build;

export 'src/stub_pubspec_builder.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'src/pubspec_builder.dart';
