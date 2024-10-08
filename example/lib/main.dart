// import 'package:app_device_info_dialog/app_device_info_dialog.dart';
import 'package:app_device_info_dialog/app_device_info_dialog.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const appTitle = 'App Device Info Dialog Demo';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(title: appTitle),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _showAppAndDeviceInfoDialog,
          child: const Text(
            'Show Device Info Dialog',
          ),
        ),
      ),
    );
  }

  Future<void> _showAppAndDeviceInfoDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        // return const Placeholder();
        return const AppDeviceInfoDialog(
          addtionalValuePairs: {
            'Flavor': 'Test',
            'Environment': 'Dev',
            'API end point': 'https://my.end.point/that/is/way/way/over/there',
          },
        );
      },
    );
  }
}
