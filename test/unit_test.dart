import 'package:test/test.dart';

import 'unit/config_test.dart' as config_test;
import 'unit/parser_test.dart' as parser_test;
import 'unit/pubspec_generator_test.dart' as pubspec_generator_test;
import 'unit/version_generator_test.dart' as version_generator_test;

/// Entry point for all unit tests.
/// Runs tests for configuration, parsing, and code generation.
///
/// To run the tests, use:
/// ```sh
/// dart test test/unit_test.dart
/// ```
void main() => group('unit', () {
      config_test.main();
      pubspec_generator_test.main();
      parser_test.main();
      version_generator_test.main();
    });
