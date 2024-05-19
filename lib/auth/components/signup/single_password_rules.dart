import 'package:flutter/material.dart';

class SingelPasswordRules extends StatelessWidget {
  const SingelPasswordRules({
    super.key,
    required this.text,
  });

  final String text;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 6,
          color: Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
              ),
        )
      ],
    );
  }
}
