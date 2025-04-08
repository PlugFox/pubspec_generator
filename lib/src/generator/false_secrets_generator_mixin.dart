// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'package:meta/meta.dart';
import 'package:pubspec_generator/src/generator/pubspec_generator.dart';
import 'package:pubspec_generator/src/generator/representation.dart';

@internal
@immutable
mixin FalseSecretsGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    final data = pubspec['false_secrets'];
    final buffer = StringBuffer()
      ..writeln(_$falseSecretsDescription)
      ..write('static const List<Object> falseSecrets = ');
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

const String _$falseSecretsDescription = '''
/// False_secrets
///
/// Current app [falseSecrets]
///
/// When you try to publish a package,
/// pub conducts a search for potential leaks of secret credentials,
/// API keys, or cryptographic keys.
/// If pub detects a potential leak in a file that would be published,
/// then pub warns you and refuses to publish the package.
///
/// Leak detection isn’t perfect. To avoid false positives,
/// you can tell pub not to search for leaks in certain files,
/// by creating an allowlist using gitignore
/// patterns under false_secrets in the pubspec.
///
/// For example, the following entry causes pub not to look
/// for leaks in the file lib/src/hardcoded_api_key.dart
/// and in all .pem files in the test/localhost_certificates/ directory:
///
/// ```yaml
/// false_secrets:
///  - /lib/src/hardcoded_api_key.dart
///  - /test/localhost_certificates/*.pem
/// ```
///
/// Starting a gitignore pattern with slash (/) ensures
/// that the pattern is considered relative to the package’s root directory.''';
