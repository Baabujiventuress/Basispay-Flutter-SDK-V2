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
      "apiKey": "Your Api Key",
      "secureHash": "Your Secure Hash",
      "orderReference": "Order Reference",
      "customerName": "Customer Name",
      "customerEmail": "Customer Mail",
      "customerMobile": "Customer Mobile",
      "address": "Address",
      "postalCode": "Postal Code",
      "city": "City",
      "region": "Region",
      "country": "IND",
      "returnUrl": "Your Return URL",
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
        // for(var key in value.keys) {
        //   print(key);
        // }
        var referenceNo = value['referenceNo'];
        var success = value['success'];

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
