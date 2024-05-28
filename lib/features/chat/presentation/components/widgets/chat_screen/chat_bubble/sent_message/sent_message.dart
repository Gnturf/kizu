import 'package:flutter/material.dart';
import 'package:kizu/features/chat/presentation/components/widgets/chat_screen/chat_bubble/sent_message/triangle.dart';

class SentMessage extends StatelessWidget {
  final String message;
  final bool isRead;
  final DateTime sendAt;

  const SentMessage({
    super.key,
    required this.message,
    required this.isRead,
    required this.sendAt,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Icon(
          isRead ? Icons.chat_bubble : Icons.chat_bubble_outline,
          size: 16,
          color: Theme.of(context).colorScheme.secondary,
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          "${sendAt.hour}:${sendAt.minute}",
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
              ),
        ),
        const SizedBox(
          width: 5,
        ),
        Material(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
            bottomLeft: Radius.circular(16),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              print("Clicked Inside");
            },
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 300,
              ),
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 10,
              ),
              child: Text(
                message,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSecondary,
                    ),
              ),
            ),
          ),
        ),
        CustomPaint(
          painter: Triangle(Theme.of(context).colorScheme.secondary),
        ),
      ],
    );
  }
}
