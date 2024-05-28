import 'package:flutter/material.dart';

class ChatTile extends StatelessWidget {
  final String name;
  final String lastChat;
  final bool isRead;
  final Function() onTap;

  const ChatTile({
    super.key,
    required this.name,
    required this.lastChat,
    required this.isRead,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
        leading: const CircleAvatar(
          radius: 26,
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                Text(
                  "09:54",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.6),
                      ),
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
            // This Row below
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isRead ? Icons.chat_bubble : Icons.chat_bubble_outline,
                  size: 18,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(
                  width: 8,
                ),
                Expanded(
                  child: Text(
                    lastChat,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.6),
                        ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
