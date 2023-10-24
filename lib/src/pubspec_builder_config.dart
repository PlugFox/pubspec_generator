import 'package:build/build.dart' show BuilderOptions;

/// Builder config
/// @immutable
/// @internal
/// {@nodoc}
class PubspecBuilderConfig {
  /// Generate timestamp in output file
  /// {@nodoc}
  final bool timestamp;

  /// Output path for generated file
  /// {@nodoc}
  final String output;

  /// {@nodoc}
  PubspecBuilderConfig.fromBuilderOptions(BuilderOptions options)
      : output = options.config['output']?.toString() ??
            'lib/src/constants/pubspec.yaml.g.dart',
        timestamp = switch (options.config['timestamp']) {
          String value => switch (value.trim().toLowerCase()) {
              'false' || 'no' || 'n' || 'f' || '-' || '0' => false,
              _ => true,
            },
          bool value => value,
          int value => value > 0,
          _ => true,
        };

  @override
  String toString() => (StringBuffer()
        ..write('Output path: ')
        ..writeln(output)
        ..write('Timestamp: ')
        ..writeln(timestamp ? 'enabled' : 'disabled'))
      .toString();
}
