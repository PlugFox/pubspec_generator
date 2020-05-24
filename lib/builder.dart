library pubspec_generator.build;

import 'package:build/build.dart' show Builder, BuilderOptions;

import 'src/pubspec.dart';

/// pubspec builder
Builder pubspecBuilder(BuilderOptions options) => PubspecBuilder();
