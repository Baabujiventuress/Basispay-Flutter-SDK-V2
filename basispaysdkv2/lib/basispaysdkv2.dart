import 'dart:async';

import 'package:flutter/services.dart';

class Basispaysdkv2 {
  static const MethodChannel _channel = const MethodChannel('basispaysdkv2');

  /*static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }*/
  static Future<Map<dynamic, dynamic>> startTransaction(
      Map<String, dynamic> paymentRequestParams) async {
    var sendMap = <String, dynamic>{
      "PayParams": paymentRequestParams,
    };
    print(sendMap.toString());
    Map<dynamic, dynamic> version =
        await _channel.invokeMethod('getPlatformVersion', sendMap);

    return version;
  }
}
