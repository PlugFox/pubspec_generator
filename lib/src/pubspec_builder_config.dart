import 'package:build/build.dart' show BuilderOptions;
import 'package:meta/meta.dart';

/// Builder config
@internal
@immutable
class PubspecBuilderConfig {
  PubspecBuilderConfig({
    required this.output,
    required this.timestamp,
  })  : assert(output.isNotEmpty, 'Output path cannot be empty'),
        assert(output.endsWith('.dart'), 'Output must be a Dart file');

  /// Constructor from [BuilderOptions]
  PubspecBuilderConfig.fromBuilderOptions(BuilderOptions options)
      : this(
          output: _validateOutput(options.config['output']?.toString() ??
              'lib/src/constants/pubspec.yaml.g.dart'),
          timestamp: _parseTimestamp(options.config),
        );

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

  final bool timestamp;
  final String output;

  @override
  String toString() =>
      'PubspecBuilderConfig(output: $output, timestamp: $timestamp)';
}
