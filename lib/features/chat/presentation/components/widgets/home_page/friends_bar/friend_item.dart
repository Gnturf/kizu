import 'package:flutter/material.dart';

class FriendItem extends StatelessWidget {
  const FriendItem({
    super.key,
    required this.name,
    required this.desc,
  });

  final String name;
  final String desc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
                  name,
                  style: Theme.of(context).textTheme.titleMedium!,
                ),
                Text(
                  desc,
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
