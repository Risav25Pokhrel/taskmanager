import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:taskmanager/core/configs/appcolor.dart';

class Meta {
  messanger({required String message, Color color = AppColors.red}) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: AppColors.white,
        fontSize: 16.0);
  }
}
