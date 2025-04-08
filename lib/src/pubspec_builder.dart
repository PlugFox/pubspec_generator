// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:pubspec_generator/src/generator/pubspec_generator.dart';
import 'package:pubspec_generator/src/generator/pubspec_generator_impl.dart';
import 'package:pubspec_generator/src/parser/pubspec_parser.dart';
import 'package:pubspec_generator/src/parser/pubspec_parser_impl.dart';
import 'package:pubspec_generator/src/pubspec_builder_config.dart';
import 'package:pubspec_generator/src/pubspec_builder_impl.dart';

/// Pubspec builder
Builder pubspecBuilder(BuilderOptions options) =>
    PubspecBuilderImpl(PubspecBuilderConfig.fromBuilderOptions(options));

/// Builder
@internal
@immutable
abstract class PubspecBuilder implements Builder {
  /// Pubspec parser
  final PubspecParser pubspecParser;

  /// Pubspec generator
  final PubspecGenerator pubspecGenerator;

  /// User codegen config from 'build.yaml'
  final PubspecBuilderConfig config;

  @override
  final Map<String, List<String>> buildExtensions;

  /// PubspecBuilder constructor with BuilderOptions
  PubspecBuilder(this.config)
      : pubspecParser = const PubspecParserImpl(),
        pubspecGenerator = PubspecGeneratorImpl(config: config),
        buildExtensions = <String, List<String>>{
          'pubspec.yaml': <String>[config.output],
        };
}
