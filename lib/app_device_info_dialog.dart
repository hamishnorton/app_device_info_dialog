library app_device_info_dialog;

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'src/build_info.dart';
import 'src/device_info.dart';

/// Alert dialog with app and device information
class AppDeviceInfoDialog extends StatelessWidget {
  const AppDeviceInfoDialog({
    super.key,
    required this.addtionalValuePairs,
  });

  final Map<String, String> addtionalValuePairs;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'App & Device Info',
        textAlign: TextAlign.center,
      ),
      content: _getContent(),
    );
  }

  Widget _getContent() {
    if (kIsWeb) return _webContent();

    if (Platform.isAndroid) {
      return _androidContent();
    }

    if (Platform.isIOS) {
      return _iOSContent();
    }

    if (Platform.isWindows) {
      return _windowsContent();
    }

    return const Text("You're not on Android, iOS, Web, or Windows");
  }

  Widget _webContent() {
    return FutureBuilder(
      future: DeviceInfo.fetchWeb(),
      builder: (context, AsyncSnapshot<WebBrowserInfo> snapshot) {
        if (!snapshot.hasData) return Container();
        WebBrowserInfo device = snapshot.data!;
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _getPackageInfo(),
              _buildTile('Run mode:', BuildInfo.runMode),
              const Divider(),
              ..._getAdditionalValuePairs(),
              const Divider(),
              ..._screenInfo(context),
              const Divider(),
              _buildTile('Platform:', '${device.platform}'),
              _buildTile('Product:', '${device.productSub}'),
              _buildTile('User Agent:', '${device.userAgent}'),
              _buildTile('Vendor:', '${device.vendorSub}'),
              _buildTile('Language:', '${device.language}'),
            ],
          ),
        );
      },
    );
  }

  Widget _iOSContent() {
    return FutureBuilder(
      future: DeviceInfo.fetchIos(),
      builder: (context, AsyncSnapshot<IosDeviceInfo> snapshot) {
        if (!snapshot.hasData) return Container();
        IosDeviceInfo device = snapshot.data!;
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _getPackageInfo(),
              _buildTile('Run mode:', BuildInfo.runMode),
              const Divider(),
              ..._getAdditionalValuePairs(),
              const Divider(),
              ..._screenInfo(context),
              const Divider(),
              _buildTile('Physical device?:', '${device.isPhysicalDevice}'),
              _buildTile('Device:', device.name),
              _buildTile('Model:', device.model),
              _buildTile('System name:', device.systemName),
              _buildTile('System version:', device.systemVersion),
            ],
          ),
        );
      },
    );
  }

  Widget _androidContent() {
    return FutureBuilder(
        future: DeviceInfo.fetchAndroid(),
        builder: (context, AsyncSnapshot<AndroidDeviceInfo> snapshot) {
          if (!snapshot.hasData) return Container();
          AndroidDeviceInfo device = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _getPackageInfo(),
                _buildTile('Run mode:', BuildInfo.runMode),
                const Divider(),
                ..._getAdditionalValuePairs(),
                const Divider(),
                ..._screenInfo(context),
                const Divider(),
                _buildTile('Android version:', device.version.release),
                _buildTile('Android SDK:', '${device.version.sdkInt}'),
                _buildTile('Physical device?:', '${device.isPhysicalDevice}'),
                _buildTile('Manufacturer:', device.manufacturer),
                _buildTile('Model:', device.model),
              ],
            ),
          );
        });
  }

  Widget _windowsContent() {
    return FutureBuilder(
        future: DeviceInfo.fetchWindows(),
        builder: (context, AsyncSnapshot<WindowsDeviceInfo> snapshot) {
          if (!snapshot.hasData) return Container();

          WindowsDeviceInfo device = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _getPackageInfo(),
                _buildTile('Run mode:', BuildInfo.runMode),
                const Divider(),
                ..._getAdditionalValuePairs(),
                const Divider(),
                ..._screenInfo(context),
                const Divider(),
                _buildTile('Product Name:', device.productName),
                _buildTile('Edition Id:', device.editionId),
                _buildTile('Display Version:', device.displayVersion),
                _buildTile('Build Number:', '${device.buildNumber}'),
                _buildTile('Number Of Cores:', '${device.numberOfCores}'),
                _buildTile('Systme Memory (megabytes):',
                    '${device.systemMemoryInMegabytes}'),
                _buildTile('Computer Name:', device.computerName),
                // _buildTile('Username:', device.userName),
                // _buildTile('Registered Owner:', device.registeredOwner),
                // _buildTile('Install Date:', '${device.installDate}'),
                // _buildTile('Service Pack Major:', '${device.servicePackMajor}'),
                // _buildTile('Service Pack Minor:', '${device.servicePackMinor}'),
                // _buildTile('Platform Id:', '${device.platformId}'),
                // _buildTile('Product Id:', device.productId),
                // _buildTile('Release Id:', device.releaseId),
                // _buildTile('Major Version:', '${device.majorVersion}'),
                // _buildTile('Minor Version:', '${device.minorVersion}'),
                // _buildTile('Build Lab Ex:', device.buildLabEx),
                // _buildTile('Build Lab:', device.buildLab),
                // _buildTile('Csd Version:', device.csdVersion),
                // _buildTile('Device Id:', device.deviceId),
                // _buildTile('Digital Product Id:', '${device.digitalProductId}'),
                // _buildTile('Product Type:', '${device.productType}'),
                // _buildTile('Reserved:', '${device.reserved}'),
                // _buildTile('Suit Mask:', '${device.suitMask}'),
              ],
            ),
          );
        });
  }

  Widget _buildTile(String key, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          key,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Flexible(
          child: Text(value),
        )
      ],
    );
  }

  List<Widget> _screenInfo(BuildContext context) {
    final media = MediaQuery.of(context);
    final size = media.size;
    return [
      _buildTile('Screen width:', size.width.toString()),
      _buildTile('Screen height:', size.height.toString()),
      _buildTile('Device pixel ratio:', media.devicePixelRatio.toString()),
      _buildTile('Text scale factor:', media.textScaler.toString()),
    ];
  }

  List<Widget> _getAdditionalValuePairs() {
    List<Widget> tiles = [];

    addtionalValuePairs.forEach(
      (key, value) {
        tiles.add(_buildTile('$key:', value));
      },
    );

    return tiles;
  }

  Widget _getPackageInfo() {
    return FutureBuilder(
      future: PackageInfo.fromPlatform(),
      builder: (context, AsyncSnapshot<PackageInfo> snapshot) {
        if (!snapshot.hasData) return Container();
        return Column(
          children: [
            _buildTile('App name:', snapshot.data!.appName),
            _buildTile('Package name:', snapshot.data!.packageName),
            _buildTile('Version:', snapshot.data!.version),
            _buildTile('Build number:', snapshot.data!.buildNumber),
          ],
        );
      },
    );
  }
}
