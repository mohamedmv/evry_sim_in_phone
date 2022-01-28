
import 'dart:async';

import 'package:flutter/services.dart';

class EvrySimInPhone {
  static const MethodChannel _channel = MethodChannel('evry_sim_in_phone');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
  static Future<String?> get simCard async {
    final String? version = await _channel.invokeMethod('sim_card');
    return version;
  }
  static Future<String?> get sim async {
    final String? version = await _channel.invokeMethod('sim');
    return version;
  }

  Future<List<String>> getAllSims() async {
   String result ='';
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      result =
          await EvrySimInPhone.sim ?? 'Unknown platform version';
    } on PlatformException {
      result = '';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.

    List<String> list = result.split("::");
    return list;
  }

}

