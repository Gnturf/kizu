// import 'package:flutter/material.dart';
// import 'package:flutter_nodejs_socketio/components/widgets/navBar/nav_item.dart';

// List<NavItem> bottomNavBarItem(BuildContext context, Function() onTap1, Function() onTap2,) {
//   return <NavItem>[
//       NavItem(
//         icon: Icons.home_rounded,
//         text: "Home",
//         onTap: () {
//           setState(() {
//             pageIndex = 0;
//             pageViewController.animateToPage(
//               pageIndex,
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.ease,
//             );
//           });
//         },
//         isSelected: pageIndex == 0,
//         selectedIconColor: Theme.of(context).colorScheme.onBackground,
//         unselectedIconColor:
//             Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
//         selectedTextColor: Theme.of(context).colorScheme.onBackground,
//         unselectedTextColor:
//             Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
//       ),
//       NavItem(
//         icon: Icons.chat_bubble,
//         text: "Chats",
//         onTap: () {
//           setState(() {
//             pageIndex = 1;
//             pageViewController.animateToPage(
//               pageIndex,
//               duration: const Duration(milliseconds: 500),
//               curve: Curves.easeIn,
//             );
//           });
//         },
//         isSelected: pageIndex == 1,
//         selectedIconColor: Theme.of(context).colorScheme.onBackground,
//         unselectedIconColor:
//             Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
//         selectedTextColor: Theme.of(context).colorScheme.onBackground,
//         unselectedTextColor:
//             Theme.of(context).colorScheme.onBackground.withOpacity(0.4),
//       ),
//     ];
// }

// final bottomNavBarItems = 