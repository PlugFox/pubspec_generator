# pubspec_generator

Add the following lines to the pubspec.yaml:
```yaml
dev_dependencies:
  build_runner: '>=1.0.0 <2.0.0'
  pubspec_generator: any

dependency_overrides:
  pubspec_generator:
    git:
      url: 'https://github.com/PlugFox/pubspec_generator'
      ref: 'master'
```
  
and then execute in the console:
```bash
pub run build_runner build
```