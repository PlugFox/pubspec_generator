import 'package:meta/meta.dart';

@internal
@immutable
// ignore: one_member_abstracts
abstract class PubspecParser {
  const PubspecParser();

  Map<String, Object> parse(String source);
}
