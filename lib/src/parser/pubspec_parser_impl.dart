import 'package:pubspec_generator/src/parser/pubspec_parser.dart';
import 'package:yaml/yaml.dart';

/// {@nodoc}
class PubspecParserImpl extends PubspecParser {
  /// {@nodoc}
  /// @literal
  const PubspecParserImpl() : super();

  @override
  Map<String, Object> parse(String source) {
    final Object? doc = loadYaml(source);
    if (doc == null || doc is! Map<Object?, Object?>) {
      throw const FormatException('This is not valid pubspec.yaml content');
    }
    return _removeInvalidNodesFromMap(doc);
  }

  Map<String, Object> _removeInvalidNodesFromMap(
          Map<Object?, Object?> source) =>
      <String, Object>{
        for (final node in source.entries)
          node.key.toString().trim().toLowerCase(): _parseValue(node.value)
      };

  List<Object> _removeInvalidElementsFromList(Iterable<Object?> source) =>
      source.map((e) => e ?? '').toList();

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
