import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm_template/constants/app_colors.dart';
import 'package:flutter_getx_mvvm_template/constants/url_constants.dart';
import 'package:flutter_getx_mvvm_template/services/network_servces/network_api_services.dart';
import 'package:flutter_getx_mvvm_template/utils/utils.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;

class StripeService {
  final NetworkClassServices _networkClassServices = NetworkClassServices();

  Future<Map<String, dynamic>?> makePayment({
    required String amount,
    required String currency,
  }) async {
    try {
      final paymentIntentData =
          await createPaymentIntent(amount: amount, currency: currency);
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          // TODO activate apple pay you need to enable apple pay on your stripe account then un-comment the following line and give it a try
          // applePay: const PaymentSheetApplePay(merchantCountryCode: 'US'),
          // TODO PLACE YOU merchantDisplayName HERE
          merchantDisplayName: 'Saqib',
          googlePay: const PaymentSheetGooglePay(merchantCountryCode: 'US'),
          style: ThemeMode.light,
          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              primary: AppColors.primary,
              primaryText: AppColors.primary,
            ),
          ),
        ),
      );
      await displayPaymentSheet(paymentIntentData);
      return paymentIntentData;
    } catch (e) {
      debugPrint('Error while making payment : $e');
    }
  }

  displayPaymentSheet(paymentIntentData) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      Utils.showInfoToast('Payment Successfully done!!!');
    } on StripeException catch (e) {
      debugPrint('Error while displaying payment sheet : $e');
    }
  }

  createPaymentIntent({
    required String amount,
    required String currency,
  }) async {
    Map<String, dynamic> body = {
      "amount": calculateAmount(amount),
      "currency": currency,
    };
    final response = await http.post(
      Uri.parse('https://api.stripe.com/v1/payment_intents'),
      body: body,
      headers: {
        "Authorization": "Bearer ${URLConstants.stripeSecretKey}",
        "Content-Type": "application/x-www-form-urlencoded",
      },
    );

    final decodedBody = jsonDecode(response.body.toString());

    return decodedBody;
  }

  String calculateAmount(amount) {
    final price = int.parse(amount) * 100;
    return price.toString();
  }
}
