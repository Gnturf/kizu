import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NavItem extends StatelessWidget {
  final Function() onTap;
  final IconData icon;
  final String? text;
  final bool isSelected;
  final Color? selectedTextColor;
  final Color? unselectedTextColor;
  final Color? selectedIconColor;
  final Color? unselectedIconColor;

  const NavItem({
    super.key,
    required this.onTap,
    required this.icon,
    this.text,
    required this.isSelected,
    this.selectedTextColor = Colors.white,
    this.unselectedTextColor = Colors.white38,
    this.selectedIconColor = Colors.white,
    this.unselectedIconColor = Colors.white38,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(100),
      onTap: onTap,
      child: SizedBox(
        height: 54,
        width: 54,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isSelected ? selectedIconColor : unselectedIconColor,
              size: 26,
            ),
            text != null
                ? const SizedBox(
                    height: 2,
                  )
                : Container(),
            text != null
                ? Text(
                    text!,
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: GoogleFonts.roboto(
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                      ).fontFamily,
                      color:
                          isSelected ? selectedTextColor : unselectedTextColor,
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
