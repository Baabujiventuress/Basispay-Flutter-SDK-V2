
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:basispaysdkv2/basispaysdkv2.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    // initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // try {
    //   platformVersion = await Basispaysdkv2.platformVersion;
    // } on PlatformException {
    //   platformVersion = 'Failed to get platform version.';
    // }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    // if (!mounted) return;

    // setState(() {
    //   _platformVersion = platformVersion;
    // });

    Map<String, dynamic> paymentRequestParams = {
      //Required Params
      "apiKey": "ac2d6957-f765-4b3d-99e3-b2926b1d7b3c",
      "secureHash": "61261EB0899CEBFE71583D23A4399F1685F9CDC416A338B017C09E2D37E2113752DAFCB3334C00AD90DDE55537B837C3CB47A8DB70BDC5E23E676ABBCF95DADD",
      "orderReference": "bpQGrKHvLyocqcGauJKdfA==",
      "customerName": "mathan",
      "customerEmail": "Testing223@gmail.com",
      "customerMobile": "88543221100",
      "address": "5/223 choolaimedu,chennai-01",
      "postalCode": "641017",
      "city": "chennai",
      "region": "Tamil Nadu",
      "country": "IND",
      "returnUrl": "http://157.245.105.135:9057/cinchcollect/pg/merchant",
      "isPgMode": false, //isPgMode false=TEST or true=LIVE
      //Optional Params
      "deliveryAddress": "",
      "deliveryCustomerName": "",
      "deliveryCustomerMobile": "",
      "deliveryPostalCode": "",
      "deliveryCity": "",
      "deliveryRegion": "",
      "deliveryCountry": "IND",
    };

    try {
      var response = Basispaysdkv2.startTransaction(paymentRequestParams);
      response.then((value) {
        print(value);
        for(var key in value.keys) {
          print(key);
        }
        var referenceNo = value['referenceNo'];
        var success = value['success'];
        print("==Ref=="+ referenceNo);
        print("==Success=="+ success);

      }).catchError((onError) {
        if (onError is PlatformException) {
          setState(() {
            print(onError.message!+ " \n  " + onError.details.toString());
          });
        } else {
          setState(() {
            print(onError.toString());
          });
        }
      });
    } catch (err) {
      print(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('BasispaySdkv2'),
        ),
        /*body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),*/
        body: Center(
          child: Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      initPlatformState();
                    });
                  },
                  child: Text("Make Payment"))
            ],
          ),
        ),
      ),
    );
  }
}
