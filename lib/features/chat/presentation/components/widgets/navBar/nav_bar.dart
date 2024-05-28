import 'package:flutter/material.dart';
import 'package:kizu/features/chat/presentation/components/widgets/navBar/nav_item.dart';

class NavBar extends StatelessWidget {
  final List<NavItem> items;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;

  const NavBar({
    super.key,
    required this.items,
    this.backgroundColor = Colors.blue,
    this.padding = const EdgeInsets.symmetric(
      vertical: 12,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.4),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: BottomAppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 1,
        color: backgroundColor,
        padding: padding,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: items,
        ),
      ),
    );
  }
}
