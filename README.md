# pubspec_generator

##### Code generator pubspec.yaml.g.dart from pubspec.yaml

[![Pub](https://img.shields.io/pub/v/pubspec_generator.svg)](https://pub.dev/packages/pubspec_generator)
[![Checkout](https://github.com/PlugFox/pubspec_generator/actions/workflows/checkout.yml/badge.svg)](https://github.com/PlugFox/pubspec_generator/actions/workflows/checkout.yml)
[![Coverage](https://codecov.io/gh/PlugFox/pubspec_generator/branch/master/graph/badge.svg)](https://codecov.io/gh/PlugFox/pubspec_generator)
[![Code size](https://img.shields.io/github/languages/code-size/plugfox/pubspec_generator?logo=github&logoColor=white)](https://github.com/plugfox/pubspec_generator)
[![License: MIT](https://img.shields.io/badge/license-MIT-purple.svg)](https://opensource.org/licenses/MIT)
[![Linter](https://img.shields.io/badge/style-linter-40c4ff.svg)](https://pub.dev/packages/linter)
[![GitHub stars](https://img.shields.io/github/stars/plugfox/pubspec_generator?style=social)](https://github.com/plugfox/pubspec_generator/)

Pubspec Generator is a Dart library that auto-generates a class containing the information from `pubspec.yaml` description, dependencies and the current app version for all possible platforms. This is an efficient way to keep the application metadata up-to-date across your entire project.

## Features

- **Automated code generation:** Create a Dart class that includes your `pubspec.yaml` description and current application version automatically.

- **Cross-platform compatibility:** Supports all platforms where Dart is available.

**Continually updated:** The generated class updates as your pubspec.yaml changes, so your application's metadata remains current at all times.

## Command line utility

You can use the command line utility to generate a `pubspec.dart` file from a `pubspec.yaml` file.
This is useful for quickly generating the Dart class without needing to set up a full build environment.

```sh
dart pub global activate pubspec_generator
dart pub global run pubspec_generator:generate --input pubspec.yaml --output lib/src/pubspec.yaml.g.dart
```

## Installation

First, add pubspec_info_codegen to your `pubspec.yaml`:

```dart
dev_dependencies:
  build_runner: <VERSION>
  pubspec_generator: <VERSION>
```

or just run

```bash
$ dart pub add --dev build_runner pubspec_generator
```

Then, run the flutter pub get command to fetch the dependency:

```bash
$ dart pub get
```

## Configuration

Create `build.yaml` at project root (near with `pubspec.yaml`).
And set output path:

```yaml
targets:
  $default:
    sources:
      - $package$
      - lib/**
      - pubspec.yaml
    builders:
      pubspec_generator:
        options:
          output: lib/src/constants/pubspec.yaml.g.dart
```

- Read more about `build.yaml` at [here](https://pub.dev/packages/build_config).

## Usage

To use the library, you need to run the provided script which triggers the code generation. Below is an example command to do so:

```bash
$ dart run build_runner build --delete-conflicting-outputs
```

This command generates a `pubspec.yaml.g.dart` file in your `lib` directory, which contains a class with your `pubspec.yaml` description and the current app version. You can import this file in your Dart code and use the class to access your app's metadata.

## Use Cases

1. **Consistent app metadata across multiple platforms:** This library ensures that the application metadata (description, version) is consistent across all platforms, reducing the chances of discrepancies.

2. **Reduced manual errors:** Automated code generation eliminates the need for manual updates and thereby reduces the potential for errors.

3. **Faster development process:** Less time spent managing app metadata means more time for feature development.

4. **Dynamic display of app information:** You can use the generated class to dynamically display the app's description and version in the UI, which would automatically stay updated with changes in `pubspec.yaml`.

5. **Automated Version Migration:** With the library's functionality, you can also handle automated version migration. If your app has different behavior or functionalities across different versions, you can use the auto-generated class to identify the current version and execute the necessary migration logic. This ensures a smooth and seamless user experience across updates.

6. **Backend Request Headers:** The generated class can also be used to add meta information from `pubspec.yaml` into the headers of your backend requests. This can help your backend service identify the app version that is making the request, which can be useful for debugging, tracking, or version-specific behaviors on the backend.

7. **App Analytics Configuration:** The metadata from `pubspec.yaml` (like app version) can be sent to your analytics tool (such as Firebase Analytics) to track the usage of different app versions. This can provide valuable insights into your user base, helping you understand how different versions of your app are being used, which versions are most popular, and how updates affect user behavior. It can also assist in identifying any issues or crashes specific to a certain version.

## Result

![](version.png)
Generated record for version. A full output example can be found [here](https://pub.dev/packages/pubspec_generator/example).

## Changelog

Refer to the [Changelog](https://github.com/plugfox/pubspec_generator/blob/master/CHANGELOG.md) to get all release notes.

## Maintainers

- Matiunin Mikhail aka [Plague Fox](https://plugfox.dev)

## Funding

If you want to support the development of our library, there are several ways you can do it:

- [Buy me a coffee](https://www.buymeacoffee.com/plugfox)
- [Support on Patreon](https://www.patreon.com/plugfox)
- [Subscribe through Boosty](https://boosty.to/plugfox)

We appreciate any form of support, whether it's a financial donation or just a star on GitHub. It helps us to continue developing and improving our library. Thank you for your support!

## License

The [MIT](https://github.com/plugfox/pubspec_generator/blob/master/LICENSE) License is a permissive free software license originating at the Massachusetts Institute of Technology (MIT). It's a simple license that has minimal restrictions on what end-users can do with the software. Here's a summary of the permissions, conditions, and limitations under the MIT License:

**Permissions:**

- **Commercial Use:** You are free to use the software for commercial purposes.
- **Modification:** You can make changes to the software and distribute your modifications.
- **Distribution:** You can distribute the original or modified (derivative) software.
- **Private Use:** You are free to use the software for private purposes.

**Conditions:**

- **Include Copyright:** You must include the original copyright notice in any copy of the software/source code.
- **Include License:** You must include a copy of the license in any copy of the software/source code.

**Limitations:**

- **No Liability:** The software is provided "as is". The authors or copyright holders cannot be held liable for any damages or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the software or the use or other dealings in the software.
- **No Warranty:** The authors or copyright holders provide no warranty of any kind.

It's important to note that this is a simplified explanation of the MIT License. If you're using MIT-licensed software in a manner that could expose you to legal risk, it's always a good idea to consult with a qualified legal professional.
