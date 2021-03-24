// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: avoid_escaping_inner_quotes
// ignore_for_file: avoid_function_literals_in_foreach_calls

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
  factory PubspecYaml.fromString(String yaml) {
    final doc = loadYamlDocument(
      yaml,
      sourceUrl: Uri.file('pubspec.yaml'),
    );
    final content = _contentToMap(doc.contents) as Map<String, dynamic>;
    return PubspecYaml._(
      (content['name'] ?? '') as String,
      (content['description'] ?? '') as String,
      (content['version'] ?? '') as String,
      (content['author'] ?? '') as String,
      (content['homepage'] ?? '') as String,
      (content['repository'] ?? '') as String,
      content,
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
      final map = <String, dynamic>{};
      content.forEach((dynamic key, dynamic value) {
        map[key as String] = _contentToMap(value);
      });
      return map;
    } else if (content is YamlList) {
      final list = <dynamic>[];
      content.forEach((dynamic value) {
        list.add(_contentToMap(value));
      });
      return list;
    }
    return content;
  }

  static String _valueToString(
    dynamic content, [
    int padding = 0,
    bool isRootMap = false,
  ]) {
    final builder = StringBuffer('');
    final clampPadding = padding.clamp(0, 8).toInt();
    if (content is MapEntry<String, dynamic>) {
      builder.write('${' ' * clampPadding}${'\'${content.key}\': '
          ' ${_valueToString(content.value, clampPadding + 2)}\n'}');
    } else if (content is Map<String, dynamic>) {
      builder.writeln('<String, Object>{');
      content.entries.forEach((value) {
        builder.write(_valueToString(value, clampPadding + 2));
      });
      builder.write('${' ' * (clampPadding - 2)}}${isRootMap ? ';' : ','}');
    } else if (content is List<dynamic>) {
      builder.writeln('<Object>[');
      content.forEach((dynamic value) {
        builder.writeln(_valueToString(value, clampPadding + 2));
      });
      builder.write('${' ' * (clampPadding - 2)}],');
    } else if (content is num) {
      return '${content.toString()},';
    } else {
      return 'r\'${content.toString().replaceAll('\n', r'\n')}\',';
    }
    return builder.toString();
  }

  @override
  String toString() => '/// Get pubspec.yaml as Map<String, Object>\n'
      'const Map<String, Object> pubspec = ${_valueToString(source, 0, true)}';
}
