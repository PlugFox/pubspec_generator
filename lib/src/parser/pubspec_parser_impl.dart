import 'package:meta/meta.dart';
import 'package:pubspec_generator/src/parser/pubspec_parser.dart';
import 'package:yaml/yaml.dart';

/// Implementation of pubspec.yaml parser with caching.
///
/// This parser converts YAML content from pubspec.yaml files into
/// structured Dart Map objects. It normalizes keys (lowercase, trimmed)
/// and handles various YAML data types safely.
///
/// Features:
/// - Caching based on content hash to avoid re-parsing identical files
/// - Null-safe value handling with sensible defaults
/// - Recursive processing of nested maps and lists
/// - Type preservation for numbers, strings, and booleans
@internal
@immutable
class PubspecParserImpl extends PubspecParser {
  /// Creates a constant parser instance.
  @literal
  const PubspecParserImpl() : super();

  /// Cache of parsed pubspec data keyed by content hash.
  ///
  /// This prevents redundant parsing of identical pubspec.yaml content,
  /// improving performance during repeated builds. The cache is shared
  /// across all parser instances.
  static final Map<String, Map<String, Object>> _cache =
      <String, Map<String, Object>>{};

  /// Parses a pubspec.yaml file content string.
  ///
  /// The [source] string should contain valid YAML content from a
  /// pubspec.yaml file.
  ///
  /// Returns a normalized Map with:
  /// - Lowercase, trimmed keys
  /// - Recursively processed nested structures
  /// - Non-null values (nulls converted to empty strings)
  ///
  /// Uses caching to avoid re-parsing identical content. Returns a copy
  /// of the cached data to prevent external modifications.
  ///
  /// Throws [FormatException] if the content is not valid YAML or is
  /// not a Map structure.
  @override
  Map<String, Object> parse(String source) {
    final hash = source.hashCode.toString();

    // Return cached result if available (as a copy to prevent mutation)
    if (_cache[hash] case Map<String, Object> fromCache) {
      return Map<String, Object>.from(fromCache);
    }

    final Object? doc = loadYaml(source);
    if (doc == null || doc is! Map<Object?, Object?>) {
      throw const FormatException('This is not valid pubspec.yaml content');
    }

    return _cache[hash] = _removeInvalidNodesFromMap(doc);
  }

  /// Recursively processes a YAML map, normalizing keys and values.
  ///
  /// Converts all keys to lowercase trimmed strings and recursively
  /// processes nested values using [_parseValue].
  Map<String, Object> _removeInvalidNodesFromMap(
          Map<Object?, Object?> source) =>
      <String, Object>{
        for (final node in source.entries)
          node.key.toString().trim().toLowerCase(): _parseValue(node.value)
      };

  /// Processes a YAML list, converting null elements to empty strings.
  ///
  /// Ensures all list elements are non-null by replacing null values
  /// with empty strings.
  List<Object> _removeInvalidElementsFromList(Iterable<Object?> source) =>
      source.map((e) => e ?? '').toList();

  /// Recursively processes YAML values into appropriate Dart types.
  ///
  /// Handles different YAML value types:
  /// - Maps: recursively processed
  /// - Lists: elements normalized
  /// - Numbers: preserved as-is
  /// - Strings: preserved as-is
  /// - Booleans: preserved as-is
  /// - Other objects: converted to strings
  /// - null: converted to empty string
  ///
  /// Returns a non-null Object suitable for code generation.
  Object _parseValue(Object? value) => switch (value) {
        Map<Object?, Object?> v => _removeInvalidNodesFromMap(v),
        Iterable<Object?> v => _removeInvalidElementsFromList(v),
        num v => v,
        String v => v,
        bool v => v,
        Object v => v.toString(),
        _ => '',
      };
}
