import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kizu/core/provider/user_provider.dart';
import 'package:kizu/features/auth/presentation/components/snackbar/custom_snack_bar.dart';
import 'package:kizu/features/chat/presentation/components/widgets/navBar/nav_bar.dart';
import 'package:kizu/features/chat/presentation/components/widgets/navBar/nav_item.dart';
import 'package:kizu/features/chat/presentation/page/chats_page.dart';
import 'package:kizu/features/chat/presentation/page/home_page.dart';
import 'package:kizu/features/chat/presentation/providers/contact_provider.dart';

class NavigationScreen extends ConsumerStatefulWidget {
  const NavigationScreen({super.key});

  @override
  ConsumerState<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends ConsumerState<NavigationScreen> {
  final pageViewController = PageController(initialPage: 0);
  int pageIndex = 0;

  @override
  void initState() {
    _initFetch();
    super.initState();
  }

  Future<void> _initFetch() async {
    print("Init Fetch");
    if (ref.read(userProvider).userEntity == null) {
      final fetchResult = await ref.read(userProvider).fetchUser();
      fetchResult.fold(
        (newFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(context, newFailure.errorMessage, Colors.red),
          );

          print("Failed Fetch User");
          return;
        },
        (_) {
          print("Success Fetch User");
        },
      );
    }

    print("-------------------------------");

    if (ref.read(contactProvider).contactList == null) {
      final fetchContact =
          await ref.read(contactProvider).fetchAllUserContact();
      fetchContact.fold(
        (newFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            customSnackBar(context, newFailure.errorMessage, Colors.red),
          );

          print("Failed Fetch Contact");
        },
        (_) {
          print("Success Fetch Contact");
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavBarItems = <NavItem>[
      NavItem(
        icon: Icons.home_rounded,
        text: "Home",
        onTap: () {
          setState(() {
            pageIndex = 0;
            pageViewController.animateToPage(
              pageIndex,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        },
        isSelected: pageIndex == 0,
        // Style Properties
        selectedIconColor: Theme.of(context).colorScheme.onBackground,
        unselectedIconColor:
            Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
        selectedTextColor: Theme.of(context).colorScheme.onBackground,
        unselectedTextColor:
            Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
      ),
      NavItem(
        icon: Icons.chat_bubble,
        text: "Chats",
        onTap: () {
          setState(() {
            pageIndex = 1;
            pageViewController.animateToPage(
              pageIndex,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        },
        isSelected: pageIndex == 1,
        // Style Properties
        selectedIconColor: Theme.of(context).colorScheme.onBackground,
        unselectedIconColor:
            Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
        selectedTextColor: Theme.of(context).colorScheme.onBackground,
        unselectedTextColor:
            Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
      ),
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      bottomNavigationBar: NavBar(
        items: bottomNavBarItems,
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: PageView(
        controller: pageViewController,
        onPageChanged: (value) {
          setState(() {
            pageIndex = value;
          });
        },
        children: const [
          HomePage(),
          ChatsPage(),
        ],
      ),
    );
  }
}
