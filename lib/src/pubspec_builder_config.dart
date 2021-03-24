import 'package:build/build.dart' show BuilderOptions;

/// Builder config
// @immutable
class PubspecBuilderConfig {
  /// {@nodoc}
  final String output;

  /// {@nodoc}
  PubspecBuilderConfig.fromBuilderOptions(BuilderOptions options)
      : output = (options.config['output'] as String?) ??
            'lib/src/constants/pubspec.yaml.g.dart';

  @override
  String toString() => (StringBuffer()
        ..write('Output path: ')
        ..writeln(output))
      .toString();
}
