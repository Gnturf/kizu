import 'package:flutter/material.dart';

class GroupOverflow extends StatelessWidget {
  const GroupOverflow({
    super.key,
    required this.overflowDesc,
  });

  final String overflowDesc;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(100),
              ),
            ),
            const SizedBox(width: 14),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View More',
                  style: Theme.of(context).textTheme.titleMedium!,
                ),
                Text(
                  overflowDesc,
                  overflow: TextOverflow.ellipsis,
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
