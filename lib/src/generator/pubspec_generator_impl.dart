import 'dependencies_generator_mixin.dart';
import 'dependency_overrides_generator_mixin.dart';
import 'dev_dependencies_generator_mixin.dart';
import 'environment_generator_mixin.dart';
import 'executables_generator_mixin.dart';
import 'header_generator_mixin.dart';
import 'ignore_generator_mixin.dart';
import 'properties_generator_mixin.dart';
import 'pubspec_generator.dart';
import 'source_generator_mixin.dart';
import 'timestamp_generator_mixin.dart';
import 'version_generator_mixin.dart';

/// {@nodoc}
class PubspecGeneratorImpl extends PubspecGenerator
    with
        SourceGeneratorMixin,
        ExecutablesGeneratorMixin,
        DependencyOverridesGeneratorMixin,
        DevDependenciesGeneratorMixin,
        DependenciesGeneratorMixin,
        EnvironmentGeneratorMixin,
        PropertiesGeneratorMixin,
        TimestampGeneratorMixin,
        VersionGeneratorMixin,
        IgnoreGeneratorMixin,
        HeaderGeneratorMixin {
  /// {@nodoc}
  /// @literal
  const PubspecGeneratorImpl() : super();
}
