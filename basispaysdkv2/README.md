# BasisPay-Flutter-PG-SDKV2-KIT
A Flutter plugin to use the BasisPay Payment gateway kit for accepting online payments in Flutter app.


## INTRODUCTION
This document describes the steps for integrating Basispay online payment gateway Flutter SDK kit.This payment gateway performs the online payment transactions with less user effort. It receives the payment details as input and handles the payment flow. Finally returns the payment response to the user. User has to import the framework manually into their project for using it

## Requirements
o Android min SDK - 21

## First of all get Credentials from BasisPay
Plugin will only work with API Keys 

##ANDROID
STEP 1:
Go to your android folder in your app and go into build.gradle file
```
  allprojects {
          repositories {
              ...
              maven { url 'https://jitpack.io' }
          }
      }
  ``` 
## Start Payment
```
  Future<void> initPlatformState() async {
      Map<String, dynamic> paymentRequestParams = {
      //Required Params
      "apiKey": "YOUR_PG_API_KEY",
      "secureHash": "xxxx",
      "orderReference": "xxxx",
      "customerName": "xxxx",
      "customerEmail": "xxxx",
      "customerMobile": "xxxxxxxxxx",
      "address": "xxxx",
      "postalCode": "xxxx",
      "city": "xxxx",
      "region": "xxxx",
      "country": "xxx", //ISO 3 Code Ex. IND
      "returnUrl": "xxxx",
      "isPgMode": false, //If pg mode LIVE set true or mode TEST set false
      //Optional Params
      "deliveryAddress": "xxxx",
      "deliveryCustomerName": "xxxx",
      "deliveryCustomerMobile": "xxxxxxxxxx",
      "deliveryPostalCode": "xxxx",
      "deliveryCity": "xxxx",
      "deliveryRegion": "xxxx",
      "deliveryCountry": "xxx",//ISO 3 Code Ex. IND
    };

    try {
      var response = Basispaysdkv2.startTransaction(paymentRequestParams);
      response.then((value) {
        print(value);
        var referenceNo = value['referenceNo'];
        var success = value['success'];
      }).catchError((onError) {
        if (onError is PlatformException) {
          setState(() {
            print(onError.message + " \n  " + onError.details.toString());
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
  
  ``` 

## Author

BasisPay, basispay@gmail.com

## License

BasisPay is available under the MIT license. See the LICENSE file for more info.


