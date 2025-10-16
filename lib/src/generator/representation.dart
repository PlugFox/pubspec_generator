// ignore_for_file: avoid_function_literals_in_foreach_calls
// ignore_for_file: avoid_escaping_inner_quotes

/// Representation of objects
String representation({
  required Object? source,
  bool nullable = false,
  StringBuffer? stringBuffer,
  int initialIndent = 0,
}) {
  var indent = initialIndent;
  final buffer = stringBuffer ??= StringBuffer();
  final nullableSymbol = nullable ? '?' : '';

  void innerRepresent(Object? object) {
    switch (object) {
      case Iterable<Object?> iterable:
        buffer
          ..write('<Object')
          ..write(nullableSymbol)
          ..writeln('>[');
        indent++;
        for (final entry in iterable) {
          buffer.write('  ' * indent);
          innerRepresent(entry);
          buffer.writeln(',');
        }
        indent--;
        buffer
          ..write('  ' * indent)
          ..write(']');

      case Map<String, Object?> map:
        buffer
          ..write('<String, Object')
          ..write(nullableSymbol)
          ..writeln('>{');
        indent++;
        for (final entry in map.entries) {
          buffer
            ..write('  ' * indent)
            ..write('\'')
            ..write(_escapeString(entry.key))
            ..write('\': ');
          innerRepresent(entry.value);
          buffer.writeln(',');
        }
        indent--;
        buffer
          ..write('  ' * indent)
          ..write('}');

      case String str:
        buffer
          ..write('r\'')
          ..write(_escapeString(str))
          ..write('\'');

      case num number:
        buffer.write(number.toString());

      case bool boolean:
        buffer.write(boolean.toString());

      case null:
        buffer.write('null');

      default:
        innerRepresent(object.toString());
    }
  }

  innerRepresent(source);
  return buffer.toString();
}

String _escapeString(String input) => input
    .replaceAll(r'\', r'\\')
    .replaceAll('\'', '\\\'')
    .replaceAll('\r', r'\r')
    .replaceAll('\n', r'\n')
    .replaceAll('\t', r'\t');
