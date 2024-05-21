import 'package:flutter/material.dart';

SnackBar customSnackBar(BuildContext context, String contentText, Color color) {
  return SnackBar(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    backgroundColor: color,
    dismissDirection: DismissDirection.horizontal,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(20),
    content: Text(
      contentText,
    ),
    action: SnackBarAction(
        label: "Dismiss",
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }),
  );
}
