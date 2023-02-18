import 'package:app_device_info_dialog/app_device_info_dialog.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

const appTitle = 'Device Info Dialog Demo';

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
  const MyHomePage({super.key, required this.title});

  final String title;

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
          onPressed: _showDeviceInfoDialog,
          child: const Text(
            'Show Device Info Dialog',
            // style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }

  Future<void> _showDeviceInfoDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return const AppDeviceInfoDialog();
      },
    );
  }
}
