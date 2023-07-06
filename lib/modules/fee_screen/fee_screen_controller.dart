import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../constants/constants.dart';
import '../../services/stripe_services/stripe_service.dart';

class FeeScreenController extends GetxController {
  final _stripeService = Get.put(StripeService());

  final loading = false.obs;

  @override
  void onInit() {
    // Initialization
    super.onInit();
  }

  @override
  void onClose() {
    // Called when closed
    super.onClose();
  }

  payFee(Map<String, dynamic> feeDetails) async {
    try {
      loading.value = true;
      final response = await _stripeService.makePayment(
          amount: feeDetails['fee_amount'].toString(), currency: 'USD');
      if (kDebugMode) {
        print(response.toString());
      }
      dummyFeeDetailsList
          .firstWhere((element) => element['id'] == feeDetails['id'])
          .update('status', (value) => 'paid')
          .update(
            'payment_date',
            (value) => DateTime.now(),
          );
    } catch (e) {
      debugPrint('**** ERROR WHILE PAYING FEE ****');
    } finally {
      loading.value = false;
    }
  }
}
