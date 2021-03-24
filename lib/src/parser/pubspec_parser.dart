/// {@nodoc}
/// @immutable
// ignore: one_member_abstracts
abstract class PubspecParser {
  /// {@nodoc}
  const PubspecParser();

  /// {@nodoc}
  Map<String, Object> parse(String source);
}
