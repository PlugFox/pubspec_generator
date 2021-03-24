// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'pubspec_generator.dart';

/// {@nodoc}
mixin EnvironmentGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    final buffer = StringBuffer()
      ..writeln('/// Environment')
      ..writeln('const Map<String, String> environment = <String, String>{');
    final data = pubspec['environment'];
    if (data is Map<String, Object>) {
      final sdk = data['sdk'];
      if (sdk is String) {
        buffer
          ..write('  \'sdk\': \'')
          ..write(sdk)
          ..writeln('\',');
      }
      final flutter = data['flutter'];
      if (flutter is String) {
        buffer
          ..write('  \'flutter\': \'')
          ..write(sdk)
          ..writeln('\',');
      }
    }
    buffer.writeln('};');
    yield buffer.toString();
    yield* super.generate(pubspec);
  }
}
