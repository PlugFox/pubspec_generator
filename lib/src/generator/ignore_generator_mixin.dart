import 'pubspec_generator.dart';

/// {@nodoc}
mixin IgnoreGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    yield (StringBuffer()
          ..writeln('// ignore_for_file: lines_longer_than_80_chars')
          ..writeln('// ignore_for_file: unnecessary_raw_strings')
          ..writeln('// ignore_for_file: use_raw_strings')
          ..writeln('// ignore_for_file: avoid_escaping_inner_quotes')
          ..writeln('// ignore_for_file: prefer_single_quotes'))
        .toString();
    yield* super.generate(pubspec);
  }
}
