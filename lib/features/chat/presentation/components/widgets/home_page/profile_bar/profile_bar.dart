import 'package:flutter/material.dart';

class ProfileBar extends StatelessWidget {
  final String displayName;
  final String? statusMessage;

  const ProfileBar({
    super.key,
    required this.displayName,
    required this.statusMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Temp Profile Picture
          const CircleAvatar(
            radius: 35,
          ),
          const SizedBox(
            width: 14,
          ),
          // Profile Name and Status
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                displayName, // Profile Name
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                statusMessage ?? '-', // Profile Status
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground
                          .withOpacity(0.6),
                    ),
              )
            ],
          ),
          const Spacer(),
          // Invite User
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.person_add_alt_1_rounded,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          )
        ],
      ),
    );
  }
}
