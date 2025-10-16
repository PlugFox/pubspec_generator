import 'package:meta/meta.dart';
import 'package:pubspec_generator/src/pubspec_builder_config.dart';

/// Base class for pubspec Dart code generators.
///
/// This abstract class defines the interface for generating Dart code
/// from parsed pubspec.yaml data. Implementations should use mixins to
/// compose different generation capabilities (version, dependencies,
/// etc.).
///
/// The [generate] method produces an iterable of code lines that will
/// be joined together to form the final output file. Each mixin
/// contributes its own section of code by yielding lines and calling
/// super.generate().
@internal
@immutable
// ignore: one_member_abstracts
abstract class PubspecGenerator {
  /// Creates a generator with the specified [config].
  const PubspecGenerator({required this.config});

  /// Configuration for the code generation process.
  ///
  /// Contains settings like output path and whether to include
  /// timestamps.
  final PubspecBuilderConfig config;

  /// Generates Dart code lines from parsed pubspec data.
  ///
  /// This method should be overridden by mixins to generate specific
  /// sections of the output file. Each mixin should yield its own lines
  /// and then call `yield* super.generate(pubspec)` to allow other
  /// mixins to contribute.
  ///
  /// The [pubspec] map contains all data from the pubspec.yaml file
  /// with normalized keys (lowercase, trimmed).
  ///
  /// Returns an iterable of code lines (without trailing newlines) that
  /// will be joined with '\n' to form the complete output.
  ///
  /// Implementations must call super to ensure all mixins contribute
  /// their code.
  @mustCallSuper
  Iterable<String> generate(Map<String, Object> pubspec) sync* {}
}
