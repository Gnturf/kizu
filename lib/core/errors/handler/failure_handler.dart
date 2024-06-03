import 'package:flutter/material.dart';
import 'package:kizu/core/errors/failure.dart';
import 'package:kizu/features/auth/presentation/components/snackbar/custom_snack_bar.dart';

void handleFailure(BuildContext context, Failure failure) {
  ScaffoldMessenger.of(context).showSnackBar(
    customSnackBar(context, failure.errorMessage, Colors.red),
  );
}
