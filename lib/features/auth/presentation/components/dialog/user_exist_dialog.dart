import 'package:flutter/material.dart';

class UserExistDialog extends StatelessWidget {
  const UserExistDialog({
    super.key,
    required this.onProceed,
    required this.onCancel,
  });

  final Function() onProceed;
  final Function() onCancel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      actionsAlignment: MainAxisAlignment.center,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "User With This Email Was Already Exist",
            style: Theme.of(context).textTheme.labelLarge,
          ),
          Text(
            "Do you want to login?",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onProceed,
          child: const Text("Yes"),
        ),
        TextButton(
          onPressed: onCancel,
          child: const Text("No"),
        )
      ],
    );
  }
}
