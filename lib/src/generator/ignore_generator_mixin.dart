// ignore_for_file: unnecessary_raw_strings

import 'package:pubspec_generator/src/generator/pubspec_generator.dart';

/// {@nodoc}
mixin IgnoreGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    yield _$ignoreForFile;
    yield* super.generate(pubspec);
  }
}

const String _$ignoreForFile = r'''
// ignore_for_file: lines_longer_than_80_chars, unnecessary_raw_strings
// ignore_for_file: use_raw_strings, avoid_classes_with_only_static_members
// ignore_for_file: avoid_escaping_inner_quotes, prefer_single_quotes''';
