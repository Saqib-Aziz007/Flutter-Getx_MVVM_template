import 'package:flutter_getx_mvvm_template/modules/fee_screen/fee_screen_controller.dart';
import 'package:flutter_getx_mvvm_template/services/stripe_services/stripe_service.dart';
import 'package:get/get.dart';

import '../../services/logger_service/basic_logger_service.dart';
import '../../services/logger_service/logger_service.dart';

class FeeScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FeeScreenController());
    Get.lazyPut<LoggerService>(() => BasicLoggerService());
    Get.lazyPut(() => StripeService());
  }
}
