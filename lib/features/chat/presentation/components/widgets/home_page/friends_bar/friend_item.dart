import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kizu/features/chat/business/entity/contact_entity.dart';
import 'package:kizu/features/chat/presentation/components/widgets/profile_dialog/profile_dialog.dart';

class FriendItem extends StatelessWidget {
  final ContactEntity contactData;

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
            return ProfileDialog();
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
