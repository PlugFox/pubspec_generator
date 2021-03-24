// ignore_for_file: avoid_escaping_inner_quotes

import 'dart:async';

import 'package:build/build.dart';

import 'pubspec_builder.dart';

/// {@nodoc}
mixin PubspecBuilderMixin on PubspecBuilder {
  @override
  FutureOr<void> build(BuildStep buildStep) async {
    // Each `buildStep` has a single input.
    final inputId = buildStep.inputId;

    // Is this a "pubscpec.yaml" asset?
    if (inputId.path.trim().toLowerCase() != 'pubspec.yaml') {
      const notFoundMessage = 'This asset is not "pubscpec.yaml"';
      log.severe(notFoundMessage);
      throw UnsupportedError(notFoundMessage);
    } else {
      log.info('Found "pubspec.yaml"');
    }

    // Create a new target `AssetId` based on the old one.
    final copy = AssetId(
      inputId.package,
      config.output,
    );

    // Can read asset?
    final canReadAsset = await buildStep.canRead(inputId);
    if (!canReadAsset) {
      final cantReadMessage = 'Can\'t read "${inputId.path}" asset';
      log.severe(cantReadMessage);
      throw UnsupportedError(cantReadMessage);
    }

    try {
      // Read source asset
      final content = await buildStep
          .readAsString(inputId)
          .then<Map<String, Object>>(pubspecParser.parse)
          .then<Iterable<String>>(pubspecGenerator.generate)
          .then<String>((value) => value.join('\r\n'));
      // Write out the new asset.
      await buildStep.writeAsString(copy, content);
    } on PackageNotFoundException {
      log.severe('Package "${inputId.package}" is not found');
      rethrow;
    } on AssetNotFoundException {
      log.severe('Asset "${inputId.path}" is not found');
      rethrow;
    } on InvalidInputException {
      log.severe('The "${inputId.toString()}" is an invalid input');
      rethrow;
    } on InvalidOutputException {
      log.severe('The output was not valid');
      rethrow;
    } on FormatException {
      log.severe('A parsing error has occurred');
      rethrow;
    }

    log.fine('File \'${config.output}\' generated.');
  }
}
