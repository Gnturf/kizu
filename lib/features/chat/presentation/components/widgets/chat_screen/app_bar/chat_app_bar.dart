import 'package:flutter/material.dart';

AppBar chatScreenAppBar(BuildContext context) {
  return AppBar(
    titleSpacing: 0,
    backgroundColor: Colors.transparent,
    surfaceTintColor: Colors.transparent,
    leading: IconButton(
      onPressed: () {
        Navigator.of(context).pop();
      },
      icon: Icon(
        Icons.chevron_left_rounded,
        color: Theme.of(context).colorScheme.primary,
      ),
    ),
    title: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "GunturF.",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          "Bored",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                color:
                    Theme.of(context).colorScheme.onBackground.withOpacity(0.6),
              ),
        ),
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.call,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      PopupMenuButton<String>(
        elevation: 2,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.zero,
            topRight: Radius.zero,
            bottomRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
          ),
        ),
        padding: const EdgeInsets.all(0),
        color: Theme.of(context).colorScheme.background,
        offset: const Offset(20, 50),
        icon: Icon(
          Icons.more_vert_outlined,
          color: Theme.of(context).colorScheme.onBackground,
        ),
        itemBuilder: (BuildContext context) {
          return [
            PopupMenuItem(
              height: 0,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.volume_up,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Text(
                    "Mute",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              height: 0,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.collections,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Text(
                    "Albums",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
            PopupMenuItem(
              height: 0,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    Icons.color_lens,
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
                  const SizedBox(
                    width: 14,
                  ),
                  Text(
                    "Theme",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ];
        },
      ),
      const SizedBox(
        width: 10,
      ),
    ],
  );
}
