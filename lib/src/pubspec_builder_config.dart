import 'package:build/build.dart' show BuilderOptions;
import 'package:meta/meta.dart';

/// Builder config
@internal
@immutable
class PubspecBuilderConfig {
  const PubspecBuilderConfig({
    required this.output,
    required this.timestamp,
  });

  /// Constructor from [BuilderOptions]
  PubspecBuilderConfig.fromBuilderOptions(BuilderOptions options)
      : output = options.config['output']?.toString() ??
            'lib/src/constants/pubspec.yaml.g.dart',
        timestamp = switch (options.config['timestamp'] ??
            options.config['time'] ??
            options.config['date'] ??
            options.config['now'] ??
            options.config['ts'] ??
            options.config['datetime']) {
          String value => switch (value.trim().toLowerCase()) {
              'false' || 'no' || 'n' || 'f' || '-' || '0' => false,
              _ => true,
            },
          bool value => value,
          int value => value > 0,
          null => true,
          _ => true,
        };

  /// Generate timestamp in output file
  final bool timestamp;

  /// Output path for generated file
  final String output;

  @override
  String toString() => (StringBuffer()
        ..write('Output path: ')
        ..writeln(output)
        ..write('Timestamp: ')
        ..writeln(timestamp ? 'enabled' : 'disabled'))
      .toString();
}
