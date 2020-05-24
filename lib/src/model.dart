import 'package:yaml/yaml.dart';

/// Pubspec model
class PubspecYaml {

  /// name
  final String name;

  /// description
  final String description;

  /// version
  final String version;

  /// author
  final String author;

  /// homepage
  final String homepage;

  /// repository
  final String repository;

  /// source
  final Map<String, dynamic> source;

  /// Factory
  factory PubspecYaml.fromString(String yaml) 
  {
    final YamlDocument doc = loadYamlDocument(yaml, sourceUrl: 'pubspec.yaml');
    final Map<String, dynamic> content = _contentToMap(doc.contents) as Map<String, dynamic>;
    return PubspecYaml._(
      (content['name'] ?? '') as String,
      (content['description'] ?? '') as String,
      (content['version'] ?? '') as String,
      (content['author'] ?? '') as String,
      (content['homepage'] ?? '') as String,
      (content['repository'] ?? '') as String,
      content ?? <String, dynamic>{},
    );
  }

  const PubspecYaml._(
    this.name,
    this.description,
    this.version,
    this.author,
    this.homepage,
    this.repository,
    this.source,
  );

  static dynamic _contentToMap(dynamic content) {
    if (content is YamlMap) {
      final Map<String, dynamic> map = <String, dynamic>{};
      content.forEach((dynamic key, dynamic value) {
        map[key as String] = _contentToMap(value);
      });
      return map;
    } else if (content is YamlList) {
      final List<dynamic> list = <dynamic>[];
      content.forEach((dynamic value) {
        list.add(_contentToMap(value));
      });
      return list;
    }
    return content;
  }

  static String _valueToString(dynamic content, [int padding = 0, bool isRootMap = false]) {
    String s = '';
    padding = padding.clamp(0, 4).toInt();
    if (content is MapEntry<String, dynamic>) {
      s += ' ' * padding + '\'${content.key}\': ${_valueToString(content.value, padding + 2)}\n';
    } else if (content is Map<String, dynamic>) {
      s += '<String, dynamic>{\n';  
      content.entries.forEach((value) {
        s += _valueToString(value, padding + 2);
      });
      s += (' ' * (padding - 2)) + '}' + (isRootMap ? ';' : ',');
    } else if (content is List<dynamic>) {
      s += '<dynamic>[\n';
      content.forEach((dynamic value) {
        s += _valueToString(value, padding + 2) + ',\n';
      });
      s += (' ' * (padding - 2)) + '],';
    } else {
      return '\'${content.toString().replaceAll('\n', '\\n')}\',';
    }
    return s;
  }

  @override
  String toString() => 
  '/// Pubspec.yaml as Map<String, dynamic>\n'
  'const Map<String, dynamic> pubspec = ${_valueToString(source, 0, true)}';
}