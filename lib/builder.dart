// ignore_for_file: prefer_const_constructors, avoid_annotating_with_dynamic
library pubspec_generator.build;

import 'src/stub_pubspec_builder.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'src/pubspec_builder.dart';

/// pubspec builder
dynamic pubspecBuilder([dynamic options]) => PubspecBuilder();
