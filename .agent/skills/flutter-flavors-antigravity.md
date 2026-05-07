---
name: flutter-flavors-antigravity
description: >
  Guide for setting up Flutter app flavors (development and production)
  in an Android project, including configuring build.gradle.kts, launching
  with flavor flags, accessing flavors in Dart code, and customizing per-flavor
  assets/icons/names. Use this skill whenever the user mentions Flutter flavors,
  product flavors, app environments (development/production), build variants, or wants
  to differentiate app behavior by environment in a Flutter/Antigravity project.
  Also triggers for requests like "set up development and production builds", "separate
  API endpoints per environment", or "different app icons per build type".
---

# Flutter Flavors in Antigravity

A complete guide for adding Android product flavors to a Flutter app using Antigravity.

---

## What Are Flavors?

A Flutter flavor (called a **product flavor** in Android) lets you create distinct
versions of your app with different icons, app names, API keys, feature flags, and
more — all from a single codebase. When combined with build types (`debug`, `release`),
you get **build variants** like `developmentDebug`, `productionRelease`, etc.

---

## Step 1: Create the Flutter Project

If starting fresh:

```bash
flutter create --android-language kotlin my_app
```

---

## Step 2: Configure Product Flavors in build.gradle.kts

Navigate to `android/app/build.gradle.kts` and add inside the `android {}` block:

```kotlin
android {
    // ... existing buildTypes block ...
    buildTypes {
        getByName("debug") { ... }
        getByName("release") { ... }
    }

    flavorDimensions += "default"
    productFlavors {
        create("development") {
            dimension = "default"
            applicationIdSuffix = ".development"
        }
        create("production") {
            dimension = "default"
            // no suffix for production
        }
    }
}
```

> You can rename `development` to anything that fits your workflow (e.g. `dev`).

---

## Step 3: Launch a Flavor

```bash
# Run in debug mode
flutter run --flavor development

# Build APK
flutter build apk --flavor development

# Build App Bundle
flutter build appbundle --flavor production
```

---

## Step 4: Access the Current Flavor in Dart

```dart
import 'package:flutter/services.dart';

void main() {
  if (appFlavor == 'production') {
    Config.apiUrl = 'https://api.example.com';
  } else if (appFlavor == 'development') {
    Config.apiUrl = 'https://dev.api.example.com';
  }

  runApp(const MyApp());
}
```

> `appFlavor` returns `null` if no flavor is specified at build time.

---

## Step 5: Customizations

### Distinct App Display Name

In `build.gradle.kts`, add `resValue` to each flavor:

```kotlin
create("development") {
    dimension = "default"
    resValue(type = "string", name = "app_name", value = "MyApp Dev")
    applicationIdSuffix = ".development"
}
create("production") {
    dimension = "default"
    resValue(type = "string", name = "app_name", value = "MyApp")
}
```

In `android/app/src/main/AndroidManifest.xml`, set:

```xml
<application android:label="@string/app_name" ... />
```

### Distinct Icons

1. Create `android/app/src/development/res/` and `android/app/src/production/res/` directories.
2. Inside each, create `mipmap-mdpi/`, `mipmap-hdpi/`, `mipmap-xhdpi/`, `mipmap-xxhdpi/`, `mipmap-xxxhdpi/`.
3. Place `ic_launcher.png` in each at the correct size (48, 72, 96, 144, 192 px).
4. Verify `AndroidManifest.xml` still references `@mipmap/ic_launcher`.

> Use [App Icon Generator](https://www.appicon.co/) to generate all sizes at once.

### Bundle Flavor-Specific Assets

In `pubspec.yaml`, use the `flavors` subfield under `assets`:

```yaml
flutter:
  assets:
    - path: assets/config.json
      flavors:
        - development
    - path: assets/config_prod.json
      flavors:
        - production
```

### Set a Default Flavor

In `pubspec.yaml`:

```yaml
flutter:
  default-flavor: development
```

---

## Using Antigravity for This Task

When working in Antigravity (Google's agentic coding IDE):

1. Open the **Agent** panel (`Cmd/Ctrl + L`).
2. Ask Antigravity to make the changes — for example:
   - *"Add development and production product flavors to my Flutter Android app"*
   - *"Update build.gradle.kts to add a development flavor with applicationIdSuffix .development"*
3. In **Review-driven development** mode, Antigravity will ask you to approve each file change before applying it.
4. After approval, run `flutter run --flavor development` from the terminal inside Antigravity.

---

## Common Pitfalls

- **Missing `flavorDimensions`**: Every flavor must declare a `dimension`; the dimension name must also appear in `flavorDimensions += "..."`.
- **abiFilters in product flavors**: Avoid setting `abiFilters` in flavors; set them in build types instead. If you must, add `-Pdisable-abi-filtering` to your `flutter build`/`flutter run` command.
- **`appFlavor` is null**: This happens when you run `flutter run` without `--flavor`. Set a `default-flavor` in pubspec.yaml to avoid this.
- **Wrong icon path**: Flavor-specific resource directories must follow the exact structure `src/<flavorName>/res/mipmap-<density>/ic_launcher.png`.

---

## References

- [Flutter flavors for Android (official docs)](https://docs.flutter.dev/deployment/flavors)
- [Flutter flavors for iOS/macOS](https://docs.flutter.dev/deployment/flavors-ios)
- [Flutter pubspec options](https://docs.flutter.dev/tools/pubspec)
- [Google Antigravity](https://antigravity.google/)
- [Build flavors with Firebase (article)](https://medium.com/@animeshjain/build-flavors-in-flutter-android-and-ios-with-different-firebase-projects-per-flavor-27c5c5dac10b)
