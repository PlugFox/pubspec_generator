// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:io' as io;

import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'package:pubspec_generator/src/generator/pubspec_generator_impl.dart';
import 'package:pubspec_generator/src/parser/pubspec_parser_impl.dart';
import 'package:pubspec_generator/src/pubspec_builder_config.dart';

/// Standard output logger - writes messages to stdout.
final $log = io.stdout.writeln;

/// Standard error logger - writes error messages to stderr.
final $err = io.stderr.writeln;

/// Command-line tool for generating Dart code from pubspec.yaml files.
///
/// This executable provides a standalone way to generate Dart code without
/// requiring build_runner. It's ideal for CI/CD pipelines, scripts, or
/// quick one-off generations.
///
/// ## Usage Examples
///
/// ### Direct execution:
/// ```sh
/// dart run bin/generate.dart --input pubspec.yaml --output example/example.dart
/// ```
///
/// ### Global activation from local path:
/// ```sh
/// dart pub global activate --source path .
/// dart pub global run pubspec_generator:generate --input pubspec.yaml --output example/example.dart
/// ```
///
/// ### Global activation from pub.dev:
/// ```sh
/// dart pub global activate pubspec_generator
/// dart pub global run pubspec_generator:generate --input pubspec.yaml --output lib/src/pubspec.yaml.g.dart
/// ```
///
/// ## Command-line Options
///
/// - `--input` / `-i`: Path to the input pubspec.yaml file (default: pubspec.yaml)
/// - `--output` / `-o`: Path where generated Dart file will be written (default: lib/pubspec.yaml.g.dart)
/// - `--timestamp` / `-t`: Include build timestamp in generated code (default: true)
/// - `--help` / `-h`: Display usage information
///
/// ## Exit Codes
///
/// - 0: Success
/// - 1: Error (invalid arguments, file not found, generation failure)
/// Main entry point for the pubspec generator CLI.
///
/// Executes the code generation process with proper error handling and
/// user-friendly messages. All errors are caught and reported with
/// appropriate exit codes.
void main([List<String> $arguments = const <String>[]]) =>
    runZonedGuarded<void>(
      () async {
        // Parse and validate command-line arguments
        final parser = buildArgumentsParser();
        final args = parser.parse($arguments);

        // Display help if requested
        if (args['help'] == true) {
          io.stdout
            ..writeln(_help)
            ..writeln()
            ..writeln(parser.usage);
          io.exit(0);
        }

        final input = args.option('input');
        final output = args.option('output');
        final timestamp = args['timestamp'] != false;

        // Validate that required arguments are provided
        if (input == null || output == null) {
          io.stderr.writeln('Error: Missing required arguments.');
          io.stderr.writeln(parser.usage);
          io.exit(1);
        }

        // Check that the input file exists
        final inputFile = io.File(input);
        if (!inputFile.existsSync()) {
          $err('Error: Pubspec.yaml file not found: '
              '\'${path.normalize(inputFile.absolute.path)}\'');
          io.exit(1);
        }

        // Ensure output directory exists, create if necessary
        final outputDirectory = io.File(output).parent;
        if (!outputDirectory.existsSync()) {
          outputDirectory.createSync(recursive: true);
        }

        // Initialize the code generator with configuration
        final generator = PubspecGeneratorImpl(
          config: PubspecBuilderConfig(
            output: output,
            timestamp: timestamp,
          ),
        );

        // Generate Dart code from pubspec.yaml content
        final String content;
        try {
          $log('Parsing pubspec.yaml file...');
          content = await inputFile
              .readAsString()
              .then<Map<String, Object>>(const PubspecParserImpl().parse)
              .then<Iterable<String>>(generator.generate)
              .then<String>((value) => value.join('\n'));
        } on Object catch (e) {
          $err('Error: Failed to parse pubspec.yaml file: $e');
          io.exit(1);
        }

        // Write the generated content to the output file
        final outputFile = io.File(output);
        try {
          await outputFile.writeAsString(content);
          $log('File '
              '\'${path.normalize(outputFile.absolute.path)}\' '
              'generated successfully.');
        } on Object catch (e) {
          $err('Error: Failed to write to output file: $e');
          io.exit(1);
        }
      },
      // Global error handler for uncaught exceptions
      (error, stackTrace) {
        $err('Unexpected error: $error');
        io.exit(1);
      },
    );

/// Builds and configures the argument parser for the CLI.
///
/// Defines all command-line options with their short forms, aliases,
/// defaults, and help text. The parser supports flexible option naming
/// to accommodate different user preferences.
///
/// Returns a configured [ArgParser] ready to parse command-line arguments.
ArgParser buildArgumentsParser() => ArgParser()
  ..addFlag(
    'help',
    abbr: 'h',
    aliases: ['readme', 'usage'],
    negatable: false,
    defaultsTo: false,
    help: 'Print this usage information',
  )
  ..addOption(
    'input',
    abbr: 'i',
    aliases: ['pubspec', 'yaml', 'pubspec.yaml'],
    mandatory: false,
    defaultsTo: 'pubspec.yaml',
    valueHelp: 'path/to/pubspec.yaml',
    help: 'Path to the pubspec.yaml file to read',
  )
  ..addOption(
    'output',
    abbr: 'o',
    aliases: ['dart', 'dartfile', 'pubspec.dart', 'genfile', 'generated'],
    mandatory: false,
    defaultsTo: 'lib/pubspec.yaml.g.dart',
    valueHelp: 'path/to/pubspec.yaml.g.dart',
    help: 'Path where the generated Dart file will be written',
  )
  ..addFlag(
    'timestamp',
    abbr: 't',
    aliases: ['time', 'date', 'now', 'ts', 'datetime'],
    defaultsTo: true,
    help: 'Include build timestamp in the generated file',
  );

/// Help message displayed when user requests usage information.
///
/// Provides a high-level description of what the tool does and how the
/// generated code can be used in applications.
const String _help = '''
Pubspec to Dart Code Generator

This command-line tool generates a Dart file containing strongly-typed constants
from your pubspec.yaml file. The generated class provides compile-time access to
your application's metadata, including:

  • Version information (with semantic versioning support)
  • Package name, description, and documentation URLs
  • Dependencies and dev dependencies
  • Environment constraints
  • Platform support information
  • Custom metadata (topics, screenshots, funding, etc.)

The generated code can be imported and used throughout your Dart application to
access pubspec metadata without parsing YAML at runtime.
''';
