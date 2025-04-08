// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'package:meta/meta.dart';
import 'package:pubspec_generator/src/generator/pubspec_generator.dart';
import 'package:pubspec_generator/src/generator/representation.dart';

@internal
@immutable
mixin FundingGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    final data = pubspec['funding'];
    final buffer = StringBuffer()
      ..writeln(_$fundingDescription)
      ..write('static const List<Object> funding = ');
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

const String _$fundingDescription = '''
/// Funding
///
/// Current app [funding]
///
/// Package authors can use the funding property to specify
/// a list of URLs that provide information on how users
/// can help fund the development of the package. For example:
///
/// ```yaml
/// funding:
///  - https://www.buymeacoffee.com/example_user
///  - https://www.patreon.com/some-account
/// ```
///
/// If published to [pub.dev](https://pub.dev/) the links are displayed on the package page.
/// This aims to help users fund the development of their dependencies.''';
