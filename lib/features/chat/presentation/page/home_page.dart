import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/core/provider/google_sign_in_provider.dart';
import 'package:kizu/features/chat/presentation/components/widgets/home_page/friends_bar/friend_bar.dart';
import 'package:kizu/features/chat/presentation/components/widgets/home_page/group_bar/group_bar.dart';
import 'package:kizu/features/chat/presentation/components/widgets/home_page/profile_bar/profile_bar.dart';
import 'package:kizu/features/chat/presentation/components/widgets/home_page/stories_bar/stories_bar.dart';
import 'package:kizu/features/chat/presentation/provider/contact_provider.dart';
import 'package:kizu/features/chat/presentation/provider/user_provider.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        toolbarHeight: 80,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.bookmark,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          const SizedBox(
            width: 2,
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
              Icons.settings,
              color: Theme.of(context).colorScheme.onBackground,
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  height: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  onTap: () async {
                    final token =
                        await FirebaseAuth.instance.currentUser!.getIdToken();

                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: SelectableText(
                            token ?? "",
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        );
                      },
                    );
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Text(
                        "Profile",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  height: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  child: Row(
                    children: [
                      Icon(
                        Icons.credit_card_rounded,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Text(
                        "Account",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
                PopupMenuItem(
                  height: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
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
                PopupMenuItem(
                  height: 0,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                  onTap: () async {
                    ref.read(userProvider).cleanProvider();
                    ref.read(contactProvider).cleanProvider();
                    ref.read(userProvider).cleanCachedUser();

                    await ref.read(googleSignInProvider).disconnect();
                    await FirebaseAuth.instance.signOut();
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Text(
                        "Sign Out",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  ),
                ),
              ];
            },
          ),
          const SizedBox(
            width: 18,
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ProfileBar(),
              const StoriesBar(),
              Container(
                height: 0.2,
                color: Theme.of(context).colorScheme.primary,
              ),
              const GroupBar(),
              Container(
                height: 0.2,
                color: Theme.of(context).colorScheme.primary,
              ),
              const FriendBar(),
            ],
          ),
        ),
      ),
    );
  }
}
