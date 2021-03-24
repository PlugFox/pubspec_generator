/// {@nodoc}
/// @immutable
// ignore: one_member_abstracts
abstract class PubspecGenerator {
  /// {@nodoc}
  const PubspecGenerator();

  /// {@nodoc}
  /// @mustCallSuper
  Iterable<String> generate(Map<String, Object> pubspec) sync* {}
}
