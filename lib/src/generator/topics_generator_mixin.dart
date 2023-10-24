// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'package:pubspec_generator/src/generator/pubspec_generator.dart';
import 'package:pubspec_generator/src/generator/representation.dart';

/// {@nodoc}
mixin TopicsGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    final data = pubspec['topics'];
    final buffer = StringBuffer()
      ..writeln(_$topicsDescription)
      ..write('static const List<Object> topics = ');
    if (data is Iterable) {
      representation(source: data, stringBuffer: buffer);
      buffer.writeln(';');
    } else {
      buffer.writeln('<Object>[];');
    }
    yield buffer.toString();
    yield* super.generate(pubspec);
  }
}

const String _$topicsDescription = '''
/// Topics
///
/// Current app [topics]
///
/// Package authors can use the topics field to categorize their package.
/// Topics can be used to assist discoverability during search with filters on pub.dev.
/// Pub.dev displays the topics on the package page as well as in the search results.
///
/// The field consists of a list of names. For example:
///
/// ```yaml
/// topics:
///   - network
///   - http
/// ```
///
/// Pub.dev requires topics to follow these specifications:
///
/// - Tag each package with at most 5 topics.
/// - Write the topic name following these requirements:
///   1) Use between 2 and 32 characters.
///   2) Use only lowercase alphanumeric characters or hyphens (a-z, 0-9, -).
///   3) Don’t use two consecutive hyphens (--).
///   4) Start the name with lowercase alphabet characters (a-z).
///   5) End with alphanumeric characters (a-z or 0-9).
///
/// When choosing topics, consider if existing topics are relevant.
/// Tagging with existing topics helps users discover your package.''';
