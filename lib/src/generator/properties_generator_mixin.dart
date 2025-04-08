// ignore_for_file: avoid_escaping_inner_quotes
// ignore_for_file: avoid_annotating_with_dynamic
// ignore_for_file: use_raw_strings
// ignore_for_file: unnecessary_raw_strings

import 'package:meta/meta.dart';
import 'package:pubspec_generator/src/generator/pubspec_generator.dart';

@internal
@immutable
mixin PropertiesGeneratorMixin on PubspecGenerator {
  @override
  Iterable<String> generate(Map<String, Object> pubspec) sync* {
    final builder = StringBuffer()
      ..writeln(_$nameDescription)
      ..write('static const String name = r\'')
      ..write(_format(pubspec['name']?.toString() ?? ''))
      ..writeln('\';')
      ..writeln()
      ..writeln(_$descriptionDescription)
      ..write('static const String description = r\'')
      ..write(_format(pubspec['description']?.toString() ?? ''))
      ..writeln('\';')
      ..writeln()
      ..writeln(_$homepageDescription)
      ..write('static const String homepage = r\'')
      ..write(_format(pubspec['homepage']?.toString() ?? ''))
      ..writeln('\';')
      ..writeln()
      ..writeln(_$repositoryDescription)
      ..write('static const String repository = r\'')
      ..write(_format(pubspec['repository']?.toString() ?? ''))
      ..writeln('\';')
      ..writeln()
      ..writeln(_$issueTrackerDescription)
      ..write('static const String issueTracker = r\'')
      ..write(_format(pubspec['issue_tracker']?.toString() ?? ''))
      ..writeln('\';')
      ..writeln()
      ..writeln(_$documentationDescription)
      ..write('static const String documentation = r\'')
      ..write(_format(pubspec['documentation']?.toString() ?? ''))
      ..writeln('\';')
      ..writeln()
      ..writeln(_$publishToDescription)
      ..write('static const String publishTo = r\'')
      ..write(_format(pubspec['publish_to']?.toString() ?? 'https://pub.dev/'))
      ..writeln('\';');
    yield builder.toString();
    yield* super.generate(pubspec);
  }

  String _format(String text) => text
      .trim()
      .replaceAll('\r', r'')
      .replaceAll('\n', r' ')
      .replaceAll('\'', r'"');
}

const String _$nameDescription = r'''
/// Name
///
/// Current app [name]
///
/// Every package needs a name.
/// It’s how other packages refer to yours, and how it appears to the world,
/// should you publish it.
///
/// The name should be all lowercase, with underscores to separate words,
/// just_like_this. Use only basic Latin letters and Arabic digits:
/// [a-z0-9_]. Also, make sure the name is a valid Dart identifier—that
/// it doesn’t start with digits
/// and isn’t a [reserved word](https://dart.dev/language/keywords).
///
/// Try to pick a name that is clear, terse, and not already in use.
/// A quick search of packages on the [pub.dev site](https://pub.dev/packages)
/// to make sure that nothing else is using your name is recommended.''';

const String _$descriptionDescription = r'''
/// Description
///
/// Current app [description]
///
/// This is optional for your own personal packages,
/// but if you intend to publish your package you must provide a description,
/// which should be in English.
/// The description should be relatively short, from 60 to 180 characters
/// and tell a casual reader what they might want to know about your package.
///
/// Think of the description as the sales pitch for your package.
/// Users see it when they [browse for packages](https://pub.dev/packages).
/// The description is plain text: no markdown or HTML.''';

const String _$homepageDescription = r'''
/// Homepage
///
/// Current app [homepage]
///
/// This should be a URL pointing to the website for your package.
/// For [hosted packages](https://dart.dev/tools/pub/dependencies#hosted-packages),
/// this URL is linked from the package’s page.
/// While providing a homepage is optional,
/// please provide it or repository (or both).
/// It helps users understand where your package is coming from.''';

const String _$repositoryDescription = r'''
/// Repository
///
/// Current app [repository]
///
/// Repository
/// The optional repository field should contain the URL for your package’s
/// source code repository—for example,
/// https://github.com/user/repository
/// If you publish your package to the pub.dev site,
/// then your package’s page displays the repository URL.
/// While providing a repository is optional,
/// please provide it or homepage (or both).
/// It helps users understand where your package is coming from.''';

const String _$issueTrackerDescription = r'''
/// Issue tracker
///
/// Current app [issueTracker]
///
/// The optional issue_tracker field should contain a URL for the package’s
/// issue tracker, where existing bugs can be viewed and new bugs can be filed.
/// The pub.dev site attempts to display a link
/// to each package’s issue tracker, using the value of this field.
/// If issue_tracker is missing but repository is present and points to GitHub,
/// then the pub.dev site uses the default issue tracker
/// https://github.com/user/repository/issues''';

const String _$documentationDescription = r'''
/// Documentation
///
/// Current app [documentation]
///
/// Some packages have a site that hosts documentation,
/// separate from the main homepage and from the Pub-generated API reference.
/// If your package has additional documentation, add a documentation:
/// field with that URL; pub shows a link to this documentation
/// on your package’s page.''';

const String _$publishToDescription = r'''
/// Publish_to
///
/// Current app [publishTo]
///
/// The default uses the [pub.dev](https://pub.dev/) site.
/// Specify none to prevent a package from being published.
/// This setting can be used to specify a custom pub package server to publish.
///
/// ```yaml
/// publish_to: none
/// ```''';
