import 'package:flutter/material.dart';
import 'package:flutter_getx_mvvm_template/constants/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';

class Utils {
  static void fieldFocusChange(
      BuildContext context, FocusNode current, FocusNode nextFocus) {
    current.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  static showLanguageDialog(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (builder) {
          return AlertDialog(
            title: Text('Choose Your Language'.tr),
            content: SizedBox(
              width: GetPlatform.isMobile
                  ? double.maxFinite
                  : MediaQuery.of(context).size.width * 0.1,
              child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Text(appLocales[index]['name']),
                        onTap: () {
                          Get.updateLocale(appLocales[index]['locale']);
                          Navigator.pop(context);
                        },
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      color: Colors.blue,
                    );
                  },
                  itemCount: appLocales.length),
            ),
          );
        });
  }

  static showErrorToast(text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP,
      timeInSecForIosWeb: 2,
      backgroundColor: AppColors.errorContainer,
      textColor: AppColors.error,
      fontSize: 16.0,
    );
  }

  static showInfoToast(text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 2,
      backgroundColor: AppColors.secondaryContainer,
      textColor: AppColors.primary,
      fontSize: 16.0,
    );
  }
}
