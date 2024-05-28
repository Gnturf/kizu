import 'package:flutter/material.dart';

class FriendTile extends StatelessWidget {
  final String name;
  final String desc;

  const FriendTile({
    super.key,
    required this.name,
    required this.desc,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 8,
      ),
      child: ListTile(
        onTap: () {},
        leading: const CircleAvatar(
          radius: 26,
        ),
        title: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              desc,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color:
                      Theme.of(context).colorScheme.primary.withOpacity(0.6)),
            )
          ],
        ),
      ),
    );
  }
}
