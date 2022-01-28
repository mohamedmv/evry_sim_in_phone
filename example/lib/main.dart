import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:evry_sim_in_phone/evry_sim_in_phone.dart';
import 'package:permission_handler/permission_handler.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();        
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<int> initPlatformState() async {
    String platformVersion = '';
    PermissionStatus state = await Permission.phone.status;
    if (!state.isGranted) {
      bool isGranted = await Permission.phone.request().isGranted;
      if (!isGranted) return 0;
    }
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await EvrySimInPhone.sim ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return 0;

    setState(() {
      _platformVersion = platformVersion;
    });

    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: FutureBuilder(
          future: initPlatformState(),
          builder: (context,i) {
            if(i.hasData){
            return Center(
              child: Text('Running on: $_platformVersion\n'),
            );}
            else{
              return Center(child:  CircularProgressIndicator(),);
            }
          }
        ),
      ),
    );
  }
}
