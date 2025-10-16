import 'package:build/build.dart' show BuilderOptions;
import 'package:meta/meta.dart';

/// Configuration for the pubspec builder.
///
/// This class encapsulates all configuration options for the pubspec
/// code generation process. It validates configuration values and
/// provides sensible defaults.
///
/// Configuration can be specified in build.yaml:
/// ```yaml
/// targets:
///   $default:
///     builders:
///       pubspec_generator:
///         options:
///           output: lib/src/pubspec.yaml.g.dart
///           timestamp: true
/// ```
@internal
@immutable
class PubspecBuilderConfig {
  /// Creates a new builder configuration.
  ///
  /// The [output] path must be a non-empty string ending with '.dart'.
  /// The [timestamp] flag determines whether to include build time in
  /// generated code.
  ///
  /// Throws [AssertionError] if validation fails.
  PubspecBuilderConfig({
    required this.output,
    required this.timestamp,
  })  : assert(output.isNotEmpty, 'Output path cannot be empty'),
        assert(output.endsWith('.dart'), 'Output must be a Dart file');

  /// Creates configuration from build_runner [BuilderOptions].
  ///
  /// Extracts and validates configuration from the options map. Provides
  /// default values for missing configuration entries:
  /// - Default output: 'lib/src/constants/pubspec.yaml.g.dart'
  /// - Default timestamp: true
  ///
  /// The timestamp option can be specified using various keys:
  /// 'timestamp', 'time', 'date', 'now', 'ts', or 'datetime'.
  PubspecBuilderConfig.fromBuilderOptions(BuilderOptions options)
      : this(
          output: _validateOutput(options.config['output']?.toString() ??
              'lib/src/constants/pubspec.yaml.g.dart'),
          timestamp: _parseTimestamp(options.config),
        );

  /// Validates the output file path.
  ///
  /// Ensures the path:
  /// - Is not empty
  /// - Ends with '.dart' extension
  /// - Does not contain path traversal sequences (..)
  /// - Does not start with absolute path (/)
  ///
  /// Throws [ArgumentError] if validation fails.
  static String _validateOutput(String output) {
    if (output.isEmpty) {
      throw ArgumentError('Output path cannot be empty');
    }
    if (!output.endsWith('.dart')) {
      throw ArgumentError(
          'Output must be a Dart file (.dart extension required)');
    }
    if (output.contains('..') || output.startsWith('/')) {
      throw ArgumentError('Output path contains invalid characters');
    }
    return output;
  }

  /// Parses the timestamp configuration from build options.
  ///
  /// Accepts multiple key names for flexibility: 'timestamp', 'time', 'date',
  /// 'now', 'ts', or 'datetime'.
  ///
  /// Value interpretation:
  /// - String: false if value is in {'false', 'no', 'n', 'f', '-', '0'}
  /// - Boolean: used directly
  /// - Number: false if <= 0, true otherwise
  /// - null: defaults to true
  /// - Other types: defaults to true
  ///
  /// Returns whether to include timestamp in generated code.
  static bool _parseTimestamp(Map<String, dynamic> config) {
    final value = config['timestamp'] ??
        config['time'] ??
        config['date'] ??
        config['now'] ??
        config['ts'] ??
        config['datetime'];

    return switch (value) {
      String str => !const {'false', 'no', 'n', 'f', '-', '0'}
          .contains(str.trim().toLowerCase()),
      bool boolean => boolean,
      int number => number > 0,
      null => true,
      _ => true,
    };
  }

  /// Whether to include build timestamp in generated code.
  final bool timestamp;

  /// Path where the generated Dart file will be written.
  final String output;

  @override
  String toString() =>
      'PubspecBuilderConfig(output: $output, timestamp: $timestamp)';
}
