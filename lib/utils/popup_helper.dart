import 'package:flutter/material.dart';
import 'package:intern_task/product/constants/app_constants.dart';
import 'package:intern_task/utils/log_helper.dart';

class PopupHelper {
// AppConstants.context

  static Future<void> showErrorPopup(String message, String errorLog) async {
    LogHelper.saveAndPrintLog(errorLog);
    ScaffoldMessenger.of(AppConstants.context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  static Future<void> showSuccessPopup(String message) async {
    ScaffoldMessenger.of(AppConstants.context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
      ),
    );
  }
}
