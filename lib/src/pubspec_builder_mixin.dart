// ignore_for_file: avoid_escaping_inner_quotes

import 'dart:async';

import 'package:build/build.dart';
import 'package:meta/meta.dart';
import 'package:pubspec_generator/src/pubspec_builder.dart';

/// Pubspec builder mixin
@internal
@immutable
mixin PubspecBuilderMixin on PubspecBuilder {
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

  Future<void> _validateInput(BuildStep buildStep, AssetId inputId) async {
    if (inputId.path.trim().toLowerCase() != 'pubspec.yaml') {
      throw BuildException('Expected pubspec.yaml, got ${inputId.path}');
    }

    if (!await buildStep.canRead(inputId)) {
      throw BuildException('Cannot read ${inputId.path}');
    }

    log.info('Validated input: ${inputId.path}');
  }

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

  Future<void> _writeOutput(BuildStep buildStep, String content) async {
    final outputId = AssetId(buildStep.inputId.package, config.output);
    try {
      await buildStep.writeAsString(outputId, content);
    } catch (error) {
      throw BuildException('Failed to write output file: $error');
    }
  }
}

/// {@template build_exception}
/// Body of the template
/// {@endtemplate}
@internal
@immutable
class BuildException implements Exception {
  /// Creates a [BuildException] with an optional error [message].
  ///
  /// {@macro build_exception}
  const BuildException(this.message);

  /// Error message
  final String message;

  @override
  String toString() => 'BuildException: $message';
}
