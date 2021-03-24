import 'package:yaml/yaml.dart';

import 'pubspec_parser.dart';

/// {@nodoc}
class PubspecParserImpl extends PubspecParser {
  /// {@nodoc}
  /// @literal
  const PubspecParserImpl() : super();

  @override
  Map<String, Object> parse(String source) {
    final dynamic doc = loadYaml(
      source,
    );
    if (doc == null || doc is! Map) {
      throw const FormatException('This is not valid pubspec.yaml content');
    }
    return _removeInvalidNodesFromMap(doc);
  }

  Map<String, Object> _removeInvalidNodesFromMap(Map source) {
    final result = <String, Object>{};
    for (final node in source.entries) {
      if (node.key is! String || node.value is! Object) {
        continue;
      }
      result[(node.key as String).trim().toLowerCase()] =
          _parseValue(node.value as Object);
    }
    return result;
  }

  List<Object> _removeInvalidElementsFromList(List source) {
    final result = <Object>[];
    for (final element in source) {
      if (element is! Object) {
        continue;
      }
      result.add(_parseValue(element));
    }
    return result;
  }

  Object _parseValue(Object value) {
    if (value is Map) {
      return _removeInvalidNodesFromMap(value);
    } else if (value is List) {
      return _removeInvalidElementsFromList(value);
    } else if (value is num || value is String) {
      return value;
    } else {
      throw FormatException(
          'Unknown type "${value.runtimeType}" as value in "pubspec.yaml"');
    }
  }
}
