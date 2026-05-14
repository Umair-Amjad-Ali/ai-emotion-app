import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Add this to your pubspec.yaml
import '../core/theme/app_colors.dart';

class CustomBottomNavBarFunctional extends StatelessWidget {
  final int selectedIndex;
  final Function(int)? onTap;

  const CustomBottomNavBarFunctional({
    super.key,
    this.selectedIndex = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Hardcoded dynamic list: can accept IconData or String (SVG path)
    final List<dynamic> navIcons = [
      'assets/pngs/menu_ic.png', // Hardcoded SVG path
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
            height: 65,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: AppColors.bgDark.withOpacity(0.85),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: Colors.white.withOpacity(0.15)),
            ),
            child: LayoutBuilder(builder: (context, constraints) {
              double totalWidth = constraints.maxWidth;
              double gapMultiplier = 0.5;
              double iconAlignmentX = -0.4;

              double selectedWidth = totalWidth * gapMultiplier;
              double unselectedWidth = (totalWidth - selectedWidth) / 2;

              return Stack(
                children: List.generate(navIcons.length, (index) {
                  bool isSelected = selectedIndex == index;

                  int displayPos;
                  if (isSelected) {
                    displayPos = 0;
                  } else {
                    int countBefore = 0;
                    for (int i = 0; i < index; i++) {
                      if (i != selectedIndex) countBefore++;
                    }
                    displayPos = countBefore + 1;
                  }

                  double leftOffset = displayPos == 0
                      ? 0
                      : selectedWidth + ((displayPos - 1) * unselectedWidth);

                  return AnimatedPositioned(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOutQuart,
                    left: leftOffset,
                    top: 0,
                    bottom: 0,
                    width: isSelected ? selectedWidth : unselectedWidth,
                    child: GestureDetector(
                      onTap: () {
                        if (onTap != null) onTap!(index);
                      },
                      behavior: HitTestBehavior.opaque,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOutQuart,
                        alignment: isSelected
                            ? Alignment(iconAlignmentX, 0)
                            : Alignment.center,
                        child: _buildIcon(navIcons[index], isSelected),
                      ),
                    ),
                  );
                }),
              );
            }),
          ),
        ),
      ),
    );
  }

  // Helper method to handle dynamic rendering of SVG or IconData
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