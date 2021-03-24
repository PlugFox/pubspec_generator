// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'package:build/build.dart';

import 'generator/pubspec_generator.dart';
import 'generator/pubspec_generator_impl.dart';
import 'parser/pubspec_parser.dart';
import 'parser/pubspec_parser_impl.dart';
import 'pubspec_builder_config.dart';
import 'pubspec_builder_impl.dart';

/// Pubspec builder
Builder pubspecBuilder(BuilderOptions options) =>
    PubspecBuilderImpl(PubspecBuilderConfig.fromBuilderOptions(options));

/// Builder
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
        pubspecGenerator = const PubspecGeneratorImpl(),
        buildExtensions = <String, List<String>>{
          'pubspec.yaml': <String>[config.output],
        };
}
