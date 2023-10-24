import 'package:pubspec_generator/src/pubspec_builder_config.dart';

/// {@nodoc}
/// @immutable
// ignore: one_member_abstracts
abstract class PubspecGenerator {
  /// {@nodoc}
  const PubspecGenerator({required this.config});

  /// Configuration for builder
  /// {@nodoc}
  final PubspecBuilderConfig config;

  /// {@nodoc}
  /// @mustCallSuper
  Iterable<String> generate(Map<String, Object> pubspec) sync* {}
}
