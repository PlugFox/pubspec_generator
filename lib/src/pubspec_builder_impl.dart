// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'package:build/build.dart' show log;

import 'package:pubspec_generator/src/pubspec_builder.dart';
import 'package:pubspec_generator/src/pubspec_builder_config.dart';
import 'package:pubspec_generator/src/pubspec_builder_mixin.dart';

/// Builder
class PubspecBuilderImpl extends PubspecBuilder with PubspecBuilderMixin {
  /// PubspecBuilder constructor with BuilderOptions
  PubspecBuilderImpl(PubspecBuilderConfig config) : super(config) {
    log.config('Config: $config');
  }
}
