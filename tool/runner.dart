import 'dart:async';
import 'dart:io' as io;

import 'package:build/build.dart' as build;
import 'package:build_runner/build_runner.dart' as runner;
import 'package:build_runner_core/build_runner_core.dart' as core;
import 'package:pubspec_generator/builder.dart' as generator;

void main(List<String> args) => runZoned(
      () async {
        final result = await runner.run(
          <String>{
            ...args,
            'build',
            '--delete-conflicting-outputs',
          }.toList(growable: false),
          <core.BuilderApplication>[
            core.apply(
              'pubspec_generator:pubspec',
              <build.BuilderFactory>[
                generator.pubspecBuilder,
              ],
              core.toRoot(),
              hideOutput: false,
              defaultDevOptions: const build.BuilderOptions(
                <String, dynamic>{'output': 'example/example.dart'},
                isRoot: true,
              ),
            ),
          ],
        );
        io.exitCode = result;
      },
    ); // ignore: avoid_print
