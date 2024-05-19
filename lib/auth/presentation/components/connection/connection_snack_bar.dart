import 'package:flutter/material.dart';

SnackBar connectionSnackBar(BuildContext context) {
  return SnackBar(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    backgroundColor: Colors.red,
    dismissDirection: DismissDirection.horizontal,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(20),
    content: const Text(
      "No Internet Connection",
    ),
    action: SnackBarAction(
        label: "Dismiss",
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        }),
  );
}
