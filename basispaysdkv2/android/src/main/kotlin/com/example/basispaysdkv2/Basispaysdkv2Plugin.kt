package com.example.basispaysdkv2

import android.app.Activity
import android.content.Intent
import android.widget.Toast
import androidx.annotation.NonNull
import com.basispaypg.BasisPayPGConstants
import com.basispaypg.BasisPayPaymentInitializer
import com.basispaypg.BasisPayPaymentParams

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry
import org.json.JSONObject
import java.lang.Error

/** Basispaysdkv2Plugin */
class Basispaysdkv2Plugin: FlutterPlugin, MethodCallHandler, ActivityAware, PluginRegistry.ActivityResultListener {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel
  private var activity: Activity? = null
  private lateinit var result: Result

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
    channel = MethodChannel(flutterPluginBinding.binaryMessenger, "basispaysdkv2")
    channel.setMethodCallHandler(this)
  }

  override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
    if (call.method == "getPlatformVersion") {
      startTransaction(call)
//      result.success("Android ${android.os.Build.VERSION.RELEASE}")
      this.result = result
    } else {
      result.notImplemented()
    }
  }

  override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }

  private fun startTransaction(call: MethodCall){
    val arg = call.arguments as Map<*, *>?
    if (arg != null) {

      val paymentParams = arg["PayParams"] as Map<*, *>?
      if (paymentParams == null) return showToast("Payment params is missing")
      val apiKey = paymentParams["apiKey"] as String?
      val secureHash = paymentParams["secureHash"] as String?
      val orderReference = paymentParams["orderReference"] as String?
      val customerName = paymentParams["customerName"] as String?
      val customerEmail = paymentParams["customerEmail"] as String?
      val customerMobile = paymentParams["customerMobile"] as String?
      val address = paymentParams["address"] as String?
      val postalCode = paymentParams["postalCode"] as String?
      val city = paymentParams["city"] as String?
      val region = paymentParams["region"] as String?
      val country = paymentParams["country"] as String?
      val deliveryAddress = paymentParams["deliveryAddress"] as String?
      val deliveryCustomerName = paymentParams["deliveryCustomerName"] as String?
      val deliveryCustomerMobile = paymentParams["deliveryCustomerMobile"] as String?
      val deliveryPostalCode = paymentParams["deliveryPostalCode"] as String?
      val deliveryCity = paymentParams["deliveryCity"] as String?
      val deliveryRegion = paymentParams["deliveryRegion"] as String?
      val deliveryCountry = paymentParams["deliveryCountry"] as String?
      val returnUrl = paymentParams["returnUrl"] as String?
      val isPgMode = paymentParams["isPgMode"] as Boolean?

      if (apiKey == null) return showToast("API Key is missing")
      if (secureHash == null) return showToast("SecureHash is missing")
      if (orderReference == null) return showToast("OrderReference is missing")
      if (customerName == null) return showToast("CustomerName is missing")
      if (customerEmail == null) return showToast("CustomerEmail is missing")
      if (customerMobile == null) return showToast("CustomerMobile is missing")
      if (address == null) return showToast("Address is missing")
      if (postalCode == null) return showToast("PostalCode is missing")
      if (city == null) return showToast("city is missing")
      if (region == null) return showToast("Region is missing")
      if (country == null) return showToast("country is missing")
      if (deliveryAddress == null) return showToast("Delivery Address is missing")
      if (deliveryCustomerName == null) return showToast("Delivery CustomerName is missing")
      if (deliveryCustomerMobile == null) return showToast("Delivery CustomerMobile is missing")
      if (deliveryPostalCode == null) return showToast("Delivery PostalCode is missing")
      if (deliveryCity == null) return showToast("Delivery City is missing")
      if (deliveryRegion == null) return showToast("Delivery Region is missing")
      if (deliveryCountry == null) return showToast("Delivery Country Region is missing")
      if (returnUrl == null) return showToast("Return url is missing")

      val pgPaymentParams = BasisPayPaymentParams()
      pgPaymentParams.apiKey = apiKey //required field(*)

      pgPaymentParams.secureHash = secureHash //required field(*)

      pgPaymentParams.orderReference = orderReference //required field(*)

      pgPaymentParams.customerName = customerName //required field(*)

      pgPaymentParams.customerEmail = customerEmail //required field(*)

      pgPaymentParams.customerMobile = customerMobile //required field(*)

      pgPaymentParams.address = address //required field(*)

      pgPaymentParams.postalCode = postalCode //required field(*)

      pgPaymentParams.city = city //required field(*)

      pgPaymentParams.region = region //required field(*)

      pgPaymentParams.country = country //required field(*)

      //// optional parameters
      pgPaymentParams.deliveryAddress = deliveryAddress
      pgPaymentParams.deliveryCustomerName = deliveryCustomerName
      pgPaymentParams.deliveryCustomerMobile = deliveryCustomerMobile
      pgPaymentParams.deliveryPostalCode = deliveryPostalCode
      pgPaymentParams.deliveryCity = deliveryCity
      pgPaymentParams.deliveryRegion = deliveryRegion
      pgPaymentParams.deliveryCountry = deliveryCountry

      val pgPaymentInitializer = BasisPayPaymentInitializer(pgPaymentParams, activity!!,
        returnUrl, isPgMode!!
      )
      pgPaymentInitializer.initiatePaymentProcess()
    }

  }

  private fun showToast(message: String) {
    Toast.makeText(activity!!, message, Toast.LENGTH_LONG).show()
  }

  override fun onDetachedFromActivity() {

  }

  override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {

  }

  override fun onAttachedToActivity(binding: ActivityPluginBinding) {
    activity = binding.activity
    binding.addActivityResultListener(this)
  }

  override fun onDetachedFromActivityForConfigChanges() {

  }
  private fun setResult(message: String?, value: String? = null) {
    result.error("0", message ?: "Unknown error", value)
  }

  private fun setResult(value: HashMap<String, String?>) {
    result.success(value)
  }


  override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {

    if (requestCode == BasisPayPGConstants.REQUEST_CODE) {
      if (resultCode == Activity.RESULT_OK) {
        try {
          val paymentResponse = data?.getStringExtra(BasisPayPGConstants.PAYMENT_RESPONSE)
          if (paymentResponse.equals("null")) {
            println("Transaction Error!")
          } else {
            val response = JSONObject(paymentResponse)
            val result = HashMap<String, String?>()
            for (key: String in response.keys()) {
              result[key] = response.getString(key)
            }
            println("Transaction Completed")
            println("Result $result")
            setResult(result)
          }

        } catch (e: Error) {
          setResult(e.message)
        }

      }
      if (resultCode == Activity.RESULT_CANCELED) {
        setResult("Payment Cancelled")
      }
    }
    return true
  }
}
