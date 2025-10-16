import 'package:meta/meta.dart';

/// Abstract interface for pubspec.yaml parsers.
///
/// Defines the contract for parsing pubspec.yaml file content into structured
/// Dart objects. Implementations should handle YAML parsing and normalize the
/// data structure for consumption by code generators.
///
/// The parser must convert YAML content into a Map with string keys and
/// non-null object values, making it safe for code generation.
@internal
@immutable
// ignore: one_member_abstracts
abstract class PubspecParser {
  /// Creates a constant parser instance.
  const PubspecParser();

  /// Parses pubspec.yaml file content into a structured Map.
  ///
  /// The [source] parameter should contain valid YAML content from a
  /// pubspec.yaml file.
  ///
  /// Returns a Map with normalized string keys and non-null object values
  /// that can be safely processed by code generators.
  ///
  /// Throws [FormatException] if the source is not valid YAML or doesn't
  /// represent a Map structure.
  Map<String, Object> parse(String source);
}
