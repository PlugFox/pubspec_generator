// ignore_for_file: avoid_escaping_inner_quotes, avoid_annotating_with_dynamic

import 'package:meta/meta.dart';
import 'package:pubspec_generator/src/generator/pubspec_generator.dart';
import 'package:pubspec_generator/src/generator/representation.dart';

@internal
@immutable
mixin ScreenshotsGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    final data = pubspec['screenshots'];
    final buffer = StringBuffer()
      ..writeln(_$screenshotsDescription)
      ..write('static const List<Object> screenshots = ');
    if (data is Iterable) {
      representation(source: data, stringBuffer: buffer);
      buffer.writeln(';');
    } else {
      buffer.writeln('<Object>[];');
    }
    yield buffer.toString();
    yield* super.generate(pubspec);
  }
}

const String _$screenshotsDescription = '''
/// Screenshots
///
/// Current app [screenshots]
///
/// Packages can showcase their widgets or other visual elements
/// using screenshots displayed on their pub.dev page.
/// To specify screenshots for the package to display,
/// use the screenshots field.
///
/// A package can list up to 10 screenshots under the screenshots field.
/// Don’t include logos or other branding imagery in this section.
/// Each screenshot includes one description and one path.
/// The description explains what the screenshot depicts
/// in no more than 160 characters. For example:
///
/// ```yaml
/// screenshots:
///   - description: 'This screenshot shows the transformation of a number of bytes
///   to a human-readable expression.'
///     path: path/to/image/in/package/500x500.webp
///   - description: 'This screenshot shows a stack trace returning a human-readable
///   representation.'
///     path: path/to/image/in/package.png
/// ```
///
/// Pub.dev limits screenshots to the following specifications:
///
/// - File size: max 4 MB per image.
/// - File types: png, jpg, gif, or webp.
/// - Static and animated images are both allowed.
///
/// Keep screenshot files small. Each download of the package
/// includes all screenshot files.
///
/// Pub.dev generates the package’s thumbnail image from the first screenshot.
/// If this screenshot uses animation, pub.dev uses its first frame.''';
