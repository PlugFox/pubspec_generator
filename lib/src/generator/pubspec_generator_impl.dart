import 'package:pubspec_generator/src/generator/class_generator_mixin.dart';
import 'package:pubspec_generator/src/generator/dependencies_generator_mixin.dart';
import 'package:pubspec_generator/src/generator/dependency_overrides_generator_mixin.dart';
import 'package:pubspec_generator/src/generator/dev_dependencies_generator_mixin.dart';
import 'package:pubspec_generator/src/generator/environment_generator_mixin.dart';
import 'package:pubspec_generator/src/generator/executables_generator_mixin.dart';
import 'package:pubspec_generator/src/generator/false_secrets_generator_mixin.dart';
import 'package:pubspec_generator/src/generator/funding_generator_mixin.dart';
import 'package:pubspec_generator/src/generator/header_generator_mixin.dart';
import 'package:pubspec_generator/src/generator/ignore_generator_mixin.dart';
import 'package:pubspec_generator/src/generator/platforms_generator_mixin.dart';
import 'package:pubspec_generator/src/generator/properties_generator_mixin.dart';
import 'package:pubspec_generator/src/generator/pubspec_generator.dart';
import 'package:pubspec_generator/src/generator/screenshots_generator_mixin.dart';
import 'package:pubspec_generator/src/generator/source_generator_mixin.dart';
import 'package:pubspec_generator/src/generator/timestamp_generator_mixin.dart';
import 'package:pubspec_generator/src/generator/topics_generator_mixin.dart';
import 'package:pubspec_generator/src/generator/typedef_generator_mixin.dart';
import 'package:pubspec_generator/src/generator/version_generator_mixin.dart';

/// {@nodoc}
class PubspecGeneratorImpl extends PubspecGenerator
    with
        SourceGeneratorMixin,
        ExecutablesGeneratorMixin,
        DependencyOverridesGeneratorMixin,
        DevDependenciesGeneratorMixin,
        DependenciesGeneratorMixin,
        PlatformsGeneratorMixin,
        EnvironmentGeneratorMixin,
        TopicsGeneratorMixin,
        ScreenshotsGeneratorMixin,
        FalseSecretsGeneratorMixin,
        FundingGeneratorMixin,
        PropertiesGeneratorMixin,
        TimestampGeneratorMixin,
        VersionGeneratorMixin,
        ClassGeneratorMixin,
        TypedefGeneratorMixin,
        HeaderGeneratorMixin,
        IgnoreGeneratorMixin {
  /// {@nodoc}
  /// @literal
  const PubspecGeneratorImpl() : super();
}
