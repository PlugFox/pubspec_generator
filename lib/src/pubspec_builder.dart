// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:pubspec_generator/src/generator/pubspec_generator.dart';
import 'package:pubspec_generator/src/generator/pubspec_generator_impl.dart';
import 'package:pubspec_generator/src/parser/pubspec_parser.dart';
import 'package:pubspec_generator/src/parser/pubspec_parser_impl.dart';
import 'package:pubspec_generator/src/pubspec_builder_config.dart';
import 'package:pubspec_generator/src/pubspec_builder_impl.dart';

/// Creates a pubspec builder for code generation.
///
/// This is the main entry point for the build_runner integration.
/// It creates a [Builder] instance that generates Dart code from
/// pubspec.yaml files.
///
/// The [options] parameter contains configuration from build.yaml,
/// including:
/// - `output`: Path where the generated Dart file will be written
/// - `timestamp`: Whether to include build timestamp in generated code
///
/// Returns a configured [PubspecBuilderImpl] instance ready to process
/// pubspec.yaml.
Builder pubspecBuilder(BuilderOptions options) =>
    PubspecBuilderImpl(PubspecBuilderConfig.fromBuilderOptions(options));

/// Abstract base class for pubspec code generation builders.
///
/// This class orchestrates the parsing and code generation process for
/// pubspec.yaml files. It implements the [Builder] interface from the
/// build package and provides the core infrastructure for generating
/// Dart code from YAML configuration.
///
/// The builder process follows these steps:
/// 1. Parse pubspec.yaml using [pubspecParser]
/// 2. Generate Dart code using [pubspecGenerator]
/// 3. Write output to the file specified in [config]
@internal
@immutable
abstract class PubspecBuilder implements Builder {
  /// Parser for pubspec.yaml files.
  ///
  /// Converts YAML content into a structured Map representation that can
  /// be processed by the generator. Uses caching to avoid re-parsing
  /// identical content.
  final PubspecParser pubspecParser;

  /// Generator for Dart code output.
  ///
  /// Transforms the parsed pubspec data into Dart code with constants,
  /// typedefs, and documentation. Applies various mixins to generate
  /// different sections.
  final PubspecGenerator pubspecGenerator;

  /// User-defined configuration from 'build.yaml'.
  ///
  /// Contains settings such as output file path and whether to include
  /// timestamps. Validated during construction to ensure valid
  /// configuration.
  final PubspecBuilderConfig config;

  /// Defines the input-output file mapping for this builder.
  ///
  /// Maps 'pubspec.yaml' as input to the configured output file path.
  /// Used by build_runner to determine which files this builder
  /// processes.
  @override
  final Map<String, List<String>> buildExtensions;

  /// Creates a new pubspec builder with the given [config].
  ///
  /// Initializes the parser, generator, and build extensions based on
  /// the provided configuration. The output path from config is used to
  /// set up the build extensions mapping.
  PubspecBuilder(this.config)
      : pubspecParser = const PubspecParserImpl(),
        pubspecGenerator = PubspecGeneratorImpl(config: config),
        buildExtensions = <String, List<String>>{
          'pubspec.yaml': <String>[config.output],
        };
}
