library pubspec_generator.build;

export 'src/stub_pubspec_builder.dart'
    // ignore: uri_does_not_exist
    if (dart.library.io) 'src/pubspec_builder.dart';
