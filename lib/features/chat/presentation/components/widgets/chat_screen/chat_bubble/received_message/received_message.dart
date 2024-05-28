import 'package:flutter/material.dart';
import 'package:kizu/features/chat/presentation/components/widgets/chat_screen/chat_bubble/received_message/reversed_triangle.dart';

class ReceivedMessage extends StatelessWidget {
  final String message;

  const ReceivedMessage({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CustomPaint(
          painter:
              ReversedTriangle(Theme.of(context).colorScheme.primaryContainer),
        ),
        Container(
          constraints: const BoxConstraints(
            maxWidth: 300,
          ),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            color: Theme.of(context).colorScheme.primaryContainer,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 10,
          ),
          child: Text(
            message,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          "09:54",
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
              ),
        ),
      ],
    );
  }
}
