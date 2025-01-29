import 'package:flutter/material.dart';

void Sign_up_warning(String message, BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => AlertDialog(
            title: Text("message"),
          ));
}
