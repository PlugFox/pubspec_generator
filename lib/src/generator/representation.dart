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
    if (object is Iterable<Object?>) {
      buffer
        ..write('<Object')
        ..write(nullableSymbol)
        ..writeln('>[');
      indent++;
      for (final entry in object) {
        buffer.write(' ' * indent * 2);
        innerRepresent(entry);
        buffer.writeln(',');
      }
      indent--;
      buffer..write(' ' * indent * 2)..write(']');
    } else if (object is Map<String, Object?>) {
      buffer
        ..write('<String, Object')
        ..write(nullableSymbol)
        ..writeln('>{');
      indent++;
      for (final entry in object.entries) {
        buffer
          ..write(' ' * indent * 2)
          ..write('\'')
          ..write(entry.key)
          ..write('\'')
          ..write(': ');
        innerRepresent(entry.value);
        buffer.writeln(',');
      }
      indent--;
      buffer..write(' ' * indent * 2)..write('}');
    } else if (object is String) {
      buffer
        ..write('r\'')
        ..write(object.replaceAll('\r', r'\r').replaceAll('\n', r'\n'))
        ..write('\'');
    } else if (object is num) {
      buffer.write(object.toString());
    } else if (object == null) {
      buffer.write('null');
    } else {
      innerRepresent(object.toString());
    }
  }

  innerRepresent(source);
  return buffer.toString();
}
