import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/features/chat/presentation/components/helper/friend_bar_const.dart';
import 'package:kizu/features/chat/presentation/provider/contact_provider.dart';

class FriendBar extends ConsumerWidget {
  const FriendBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactList = ref.watch(contactProvider).contactList;

    return ListTileTheme(
      contentPadding: const EdgeInsets.all(0),
      dense: true,
      horizontalTitleGap: 0.0,
      minLeadingWidth: 0,
      minVerticalPadding: 10,
      child: ExpansionTile(
        initiallyExpanded: true,
        enableFeedback: false,
        shape: const Border(),
        dense: true,
        visualDensity: const VisualDensity(vertical: -4),
        tilePadding: const EdgeInsets.all(0),
        childrenPadding: const EdgeInsets.all(0),
        title: Text(
          // TODO: Implement This
          "Friends ${contactList?.length ?? "-"}",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
              ),
        ),
        children: [
          // TODO: Implement This
          ...generateFriendItem(contactList ?? []),
          const SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
