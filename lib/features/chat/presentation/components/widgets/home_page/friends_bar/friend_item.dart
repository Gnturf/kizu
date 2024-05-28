import 'package:flutter/material.dart';
import 'package:kizu/core/entity/user_entity.dart';
import 'package:kizu/features/chat/presentation/components/widgets/profile_dialog/profile_dialog.dart';

class FriendItem extends StatelessWidget {
  final UserEntity contactData;

  const FriendItem({
    super.key,
    required this.contactData,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(contactData.uid);
        showDialog(
          context: context,
          builder: (context) {
            return ProfileDialog(
              user: contactData,
            );
          },
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 25,
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  contactData.displayName,
                  style: Theme.of(context).textTheme.titleMedium!,
                ),
                Text(
                  contactData.statusMessage ?? "-",
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground
                            .withOpacity(0.6),
                      ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
