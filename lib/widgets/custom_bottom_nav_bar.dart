import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../core/theme/app_colors.dart';
import '../screen/layout/layout.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onTap;

  const CustomBottomNavBar({
    super.key,
    this.selectedIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Hardcoded dynamic list to match custom_bottom_bar_fun
    final List<dynamic> navIcons = [
      'assets/pngs/menu_ic.png',
      Icons.settings_outlined,
      Icons.person_outline,
    ];

    return Container(
      margin: const EdgeInsets.only(bottom: 20, left: 24, right: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
          child: Container(
            height: 65, // Match height from fun version
            decoration: BoxDecoration(
              color: AppColors.bgDark.withOpacity(0.85),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withOpacity(0.15)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(navIcons.length, (index) {
                bool isSelected = selectedIndex == index;
                return Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // 1. First trigger the UI state update
                      onTap?.call(index);

                      // 2. Custom function calls based on the specific tab clicked
                      switch (index) {
                        case 0:
                          debugPrint("🏠 Home Tab Selected - Trigger Refresh");
                          Navigator.pushAndRemoveUntil( context, MaterialPageRoute( builder: (context) => const AppLayout(initialIndex: 0,), ), (route) => false, );
                          // Add your Home specific function here
                          break;
                        case 1:
                          debugPrint("⚙️ Settings Tab Selected - Log Analytics");
                          Navigator.pushAndRemoveUntil( context, MaterialPageRoute( builder: (context) => const AppLayout(initialIndex: 1,), ), (route) => false, );
                          // Add your Settings specific function here
                          break;
                        case 2:
                          debugPrint("👤 Profile Tab Selected - Check Auth State");
                          Navigator.pushAndRemoveUntil( context, MaterialPageRoute( builder: (context) => const AppLayout(initialIndex: 2,), ), (route) => false, );
                          // Add your Profile specific function here
                          break;
                      }
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Center(
                      child: _buildIcon(navIcons[index], isSelected),
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(dynamic item, bool isSelected) {
    final Color color = isSelected ? Colors.white : Colors.white.withOpacity(0.4);
    final double size = isSelected ? 28 : 24;

    if (item is IconData) {
      return Icon(
        item,
        color: color,
        size: size,
      );
    } else if (item is String) {
      return Image.asset(
        item,
        width: size-5,
        height: size-5,
        //colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
        color: color,
      );
    }
    return const SizedBox.shrink();
  }
}