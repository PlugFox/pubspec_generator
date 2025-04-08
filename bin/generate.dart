// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';
import 'dart:io' as io;

import 'package:args/args.dart';
import 'package:path/path.dart' as path;
import 'package:pubspec_generator/src/generator/pubspec_generator_impl.dart';
import 'package:pubspec_generator/src/parser/pubspec_parser_impl.dart';
import 'package:pubspec_generator/src/pubspec_builder_config.dart';

final $log = io.stdout.writeln; // Log to stdout
final $err = io.stderr.writeln; // Log to stderr

/// Main entry point for the command line tool
/// This tool generates a Dart file from a pubspec.yaml file.
///
/// Example usage:
/// ```sh
/// dart run generate.dart --input pubspec.yaml --output example/example.dart
/// ```
///
/// or
///
/// ```sh
/// dart pub global activate --source path .
/// dart pub global run pubspec_generator:generate --input pubspec.yaml --output example/example.dart
/// ```
///
/// or
///
/// ```sh
/// dart pub global activate pubspec_generator
/// dart pub global run pubspec_generator:generate --input pubspec.yaml --output lib/src/pubspec.yaml.dart
/// ```
void main([List<String> $arguments = const <String>[]]) =>
    runZonedGuarded<void>(
      () async {
        // Get command line arguments
        // If no arguments are provided, use the default values
        final parser = buildArgumentsParser();
        final args = parser.parse($arguments);
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

        // Validate arguments
        if (input == null || output == null) {
          io.stderr.writeln('Error: Missing required arguments.');
          io.stderr.writeln(parser.usage);
          io.exit(1);
        }

        // Validate input file exists
        final inputFile = io.File(input);
        if (!inputFile.existsSync()) {
          $err('Error: Pubspec.yaml file not found: '
              '\'${path.normalize(inputFile.absolute.path)}\'');
          io.exit(1);
        }

        final outputDirectory = io.File(output).parent;
        if (!outputDirectory.existsSync())
          outputDirectory.createSync(recursive: true);

        final generator = PubspecGeneratorImpl(
          config: PubspecBuilderConfig(
            output: output,
            timestamp: timestamp,
          ),
        );

        // Generate the Dart file content from the pubspec.yaml file
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
              'generated.');
        } on Object catch (e) {
          $err('Error: Failed to write to output file: $e');
          io.exit(1);
        }
      },
      (error, stackTrace) {
        $err(error);
        io.exit(1);
      },
    );

/// Parse arguments
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
    help: 'Path to the pubspec.yaml file',
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
    help: 'Include timestamp in generated file',
  );

/// Help message for the command line arguments
const String _help = '''
Pubspec to Dart file generator

This tool generates a Dart file from a pubspec.yaml file.
The generated file contains a class that represents the pubspec.yaml file as a Dart object.
The generated file can be used to read the pubspec.yaml file in a Dart application.
''';
