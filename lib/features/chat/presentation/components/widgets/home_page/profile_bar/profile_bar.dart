import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/features/chat/presentation/provider/user_provider.dart';

class ProfileBar extends ConsumerWidget {
  const ProfileBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).user;

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
                user?.displayName ?? "", // Profile Name
                style: Theme.of(context).textTheme.displaySmall,
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                user?.statusMessage ?? "-", // Profile Status
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
