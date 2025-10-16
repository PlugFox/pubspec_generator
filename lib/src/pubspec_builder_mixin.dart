// ignore_for_file: avoid_escaping_inner_quotes

import 'dart:async';

import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:pubspec_generator/src/pubspec_builder.dart';

/// Mixin providing build execution logic for pubspec builders.
///
/// This mixin implements the core build process, including:
/// - Input validation
/// - Content generation from pubspec.yaml
/// - Output file writing
/// - Error handling and logging
///
/// The build process is divided into discrete steps for
/// maintainability and testability. Each step logs its progress and
/// handles errors appropriately.
@internal
@immutable
mixin PubspecBuilderMixin on PubspecBuilder {
  /// Executes the build process for a single pubspec.yaml file.
  ///
  /// This method orchestrates the entire code generation pipeline:
  /// 1. Validates the input file (must be pubspec.yaml)
  /// 2. Parses YAML and generates Dart code
  /// 3. Writes output to the configured location
  ///
  /// Throws [BuildException] if any step fails. Logs progress at various
  /// levels (info, fine, severe) for debugging and monitoring.
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    final inputId = buildStep.inputId;

    try {
      await _validateInput(buildStep, inputId);
      final content = await _generateContent(buildStep, inputId);
      await _writeOutput(buildStep, content);
      log.fine('File \'${config.output}\' generated successfully.');
    } on BuildException {
      rethrow;
    } catch (error, stackTrace) {
      log.severe('Unexpected error during build: $error', error, stackTrace);
      throw BuildException('Failed to generate pubspec file: $error');
    }
  }

  /// Validates the input file before processing.
  ///
  /// Ensures that:
  /// - The input file is named 'pubspec.yaml' (case-insensitive)
  /// - The file is readable by the build system
  ///
  /// Throws [BuildException] if validation fails.
  Future<void> _validateInput(BuildStep buildStep, AssetId inputId) async {
    if (inputId.path.trim().toLowerCase() != 'pubspec.yaml') {
      throw BuildException('Expected pubspec.yaml, got ${inputId.path}');
    }

    if (!await buildStep.canRead(inputId)) {
      throw BuildException('Cannot read ${inputId.path}');
    }

    log.info('Validated input: ${inputId.path}');
  }

  /// Generates Dart code content from the pubspec.yaml file.
  ///
  /// This method:
  /// 1. Reads the YAML file as a string
  /// 2. Parses it into a structured Map using [pubspecParser]
  /// 3. Generates Dart code lines using [pubspecGenerator]
  /// 4. Joins the lines into a single string
  ///
  /// Returns the complete generated Dart file content.
  /// Throws [BuildException] if generation fails at any step.
  Future<String> _generateContent(BuildStep buildStep, AssetId inputId) async {
    try {
      return await buildStep
          .readAsString(inputId)
          .then<Map<String, Object>>(pubspecParser.parse)
          .then<Iterable<String>>(pubspecGenerator.generate)
          .then<String>((lines) => lines.join('\n'));
    } catch (error) {
      throw BuildException('Failed to generate content: $error');
    }
  }

  /// Writes the generated content to the output file.
  ///
  /// Creates an [AssetId] for the output file based on the current package
  /// and configured output path, then writes the content as a string.
  ///
  /// Throws [BuildException] if writing fails.
  Future<void> _writeOutput(BuildStep buildStep, String content) async {
    final outputId = AssetId(buildStep.inputId.package, config.output);
    try {
      await buildStep.writeAsString(outputId, content);
    } catch (error) {
      throw BuildException('Failed to write output file: $error');
    }
  }
}

/// Exception thrown when the build process encounters an error.
///
/// This exception is used to signal failures during pubspec code generation,
/// such as:
/// - Invalid input files
/// - Parsing errors in YAML content
/// - Code generation failures
/// - File write errors
///
/// The exception includes a descriptive message explaining what went wrong.
@internal
@immutable
class BuildException implements Exception {
  /// Creates a [BuildException] with a descriptive error [message].
  ///
  /// The message should clearly explain what went wrong during the build
  /// process to help with debugging.
  const BuildException(this.message);

  /// Descriptive error message explaining the build failure.
  final String message;

  @override
  String toString() => 'BuildException: $message';
}
