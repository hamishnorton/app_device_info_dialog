<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

Provides an Application and Device Information Dialog to assist identifying the specific version and device being used.

## Features

Shows:

1. App name, package, version, and build.
2. Run mode, and flavor
3. Screen size, pixel ratio and text scale factor
4. Device details for: Android, iOS, Windows, and Web

## Getting started

Add to your `pubspec.yaml`

```yaml
dependencies:
	app_device_info_dialog:
    	git:
			url: https://github.com/hamishnorton/app_device_info_dialog.git
```

## Usage

Create a `showDialog()` method in a stateful widget

```dart
Future<void> _showDeviceInfoDialog() async {
	return showDialog<void>(
		context: context,
		barrierDismissible: true, // user must tap button!
		builder: (BuildContext context) {
			return const AppDeviceInfoDialog(
				flavor: 'Test',
			);
		},
	);
}
```

And call it from the likes of a button `onPressed`.

```dart
ElevatedButton(
	onPressed: _showDeviceInfoDialog,
	child: const Text(
		'Show Device Info Dialog',
	),
),
```
