// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'package:build/build.dart' show log;
import 'package:meta/meta.dart';
import 'package:pubspec_generator/src/pubspec_builder.dart';
import 'package:pubspec_generator/src/pubspec_builder_config.dart';
import 'package:pubspec_generator/src/pubspec_builder_mixin.dart';

/// Concrete implementation of the pubspec builder.
///
/// This class combines [PubspecBuilder] with [PubspecBuilderMixin] to
/// provide the complete build functionality. It handles the actual build
/// process including validation, content generation, and output writing.
///
/// The implementation logs configuration details during initialization
/// for debugging and monitoring purposes.
@internal
@immutable
class PubspecBuilderImpl extends PubspecBuilder with PubspecBuilderMixin {
  /// Creates a pubspec builder implementation with the given [config].
  ///
  /// Logs the configuration for debugging purposes. The config
  /// determines output file location and whether to include timestamps.
  PubspecBuilderImpl(PubspecBuilderConfig config) : super(config) {
    log.config('PubspecBuilder initialized with config: $config');
  }
}
