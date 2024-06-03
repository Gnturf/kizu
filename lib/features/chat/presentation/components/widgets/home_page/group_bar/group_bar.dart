import 'package:flutter/material.dart';

class GroupBar extends StatelessWidget {
  const GroupBar({super.key});

  @override
  Widget build(BuildContext context) {
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
          "Groups 0",
          style: Theme.of(context).textTheme.labelLarge!.copyWith(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
              ),
        ),
        children: const [
          // ...generateGroupItem(groupList),
          SizedBox(
            height: 8,
          ),
        ],
      ),
    );
  }
}
