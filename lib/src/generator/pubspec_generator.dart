import 'package:meta/meta.dart';
import 'package:pubspec_generator/src/pubspec_builder_config.dart';

@internal
@immutable
// ignore: one_member_abstracts
abstract class PubspecGenerator {
  const PubspecGenerator({required this.config});

  /// Configuration for builder
  final PubspecBuilderConfig config;

  /// @mustCallSuper
  Iterable<String> generate(Map<String, Object> pubspec) sync* {}
}
