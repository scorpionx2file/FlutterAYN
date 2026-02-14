import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';
import '../../../config/routes/app_routes.dart';
import '../../theme/colors/app_colors.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  bool isFabOpen = false;

  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );
  }

  void toggleFab() {
    setState(() {
      isFabOpen = !isFabOpen;
      isFabOpen ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 1.sh,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [

          /// 🔴 Overlay
          if (isFabOpen)
            Positioned.fill(
              child:  Container(
                  color: AppColors.white.withOpacity(0.85),
                ),
              ),

          /// 🟢 FAB MENU
          buildFabMenu(),

          /// 🔵 Bottom Navigation Bar
          if (!isFabOpen)  // <-- only show when FAB is closed
            buildBottomBar(context),
        ],
      ),
    );
  }

/*
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 60.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                bottomNavigationItem(0, Icons.home, context.l10n.home),
                bottomNavigationItem(1, Icons.public, context.l10n.map),
                SizedBox(width: 60.w),
                bottomNavigationItem(2, Icons.storefront, context.l10n.gates),
                bottomNavigationItem(3, Icons.person, context.l10n.profile),
              ],
            ),
          ),

          Positioned(
            bottom: 10.h,
            child: Column(
              children: [
                Container(
                  width: 36.w,
                  height: 36.h,
                  decoration: BoxDecoration(
                    color: AppColors.turnbullBlue,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(Icons.add, color: Colors.white, size: 26.r),
                ),
                Text(
                  context.l10n.add,
                  style: AppTextStyles.smallText.copyWith(
                    color: AppColors.turnbullBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
*/

  Widget buildBottomBar(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 60.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                bottomNavigationItem(0, Icons.home, context.l10n.home),
                bottomNavigationItem(1, Icons.public, context.l10n.map),
                SizedBox(width: 60.w),
                bottomNavigationItem(2, Icons.storefront, context.l10n.gates),
                bottomNavigationItem(3, Icons.person, context.l10n.profile),
              ],
            ),
          ),

          /// FAB BUTTON
          Positioned(
            bottom: 10.h,
            child: GestureDetector(
              onTap: toggleFab,
              child: AnimatedRotation(
                turns: isFabOpen ? 0.125 : 0,
                duration: const Duration(milliseconds: 250),
                child: Column(
                  children: [
                    Container(
                      width: 36.w,
                      height: 36.h,
                      decoration: BoxDecoration(
                        color: AppColors.turnbullBlue,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 26.r),
                    ),
                    Text(
                      context.l10n.add,
                      style: AppTextStyles.smallText.copyWith(
                        color: AppColors.turnbullBlue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomNavigationItem(int index, IconData icon, String title) {
    final bool isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index;
          });
          switch (index) {
            case 0:
              context.go(AppRoutes.home);
              break;
            case 1:
              context.go(AppRoutes.map);
              break;
            case 2:
              context.go(AppRoutes.gates);
              break;
            case 3:
              context.go(AppRoutes.profile);
              break;
          }
        },
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Top border indicator
            Positioned(
              top: 0,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 20.w,
                height: 3.h,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.turnbullBlue
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),

            // Icon + Text
            Positioned.fill(
              top: 10.h,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    icon,
                    size: 22.r,
                    color: isSelected
                        ? AppColors.turnbullBlue
                        : AppColors.spanishGrey,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.smallText.copyWith(
                      color: isSelected
                          ? AppColors.turnbullBlue
                          : AppColors.spanishGrey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFabMenu() {
    return Positioned(
      bottom: 20.h,
      child: ScaleTransition(
        scale: _animation,
        child: Column(
          children: [

            // Post: text above icon
            fabAction(
              icon: Icons.menu_book,
              label: "Post",
              color: AppColors.turnbullBlue,
              direction: FabLabelDirection.above,
              onTap: () {
                toggleFab();
                context.push(AppRoutes.addNewPost);
              },
            ),

            SizedBox(height: 12.h),

            Row(
              children: [
                // Event: text to the right of icon
                fabAction(
                  icon: Icons.calendar_month,
                  label: "Event",
                  color: AppColors.yellow,
                  direction: FabLabelDirection.left,
                  onTap: () {
                  },
                ),
                SizedBox(width: 12.w),
                // Close FAB at the top of the menu
                GestureDetector(
                  onTap: toggleFab,
                  child: Container(
                    width: 60.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.black.withOpacity(0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Icon(Icons.close, color: AppColors.black, size: 30.r),
                  ),
                ),
                SizedBox(width: 12.w),
                // Video: text to the left of icon
                fabAction(
                  icon: Icons.videocam,
                  label: "Video",
                  color: AppColors.lebaneseRed,
                  direction: FabLabelDirection.right,
                  onTap: () {
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget fabAction({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
    FabLabelDirection direction = FabLabelDirection.right,
  }) {
    BoxDecoration decoration = BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      boxShadow: [
        BoxShadow(
          color: color.withOpacity(0.5), // same color, semi-transparent
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
    switch (direction) {
      case FabLabelDirection.above:
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTextStyles.description.copyWith(color: color,fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 6.h),
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: 60.w,
                height: 60.h,
                decoration:decoration,
                child: Icon(icon, color: AppColors.white,size: 30.r,),
              ),
            ),
          ],
        );

      case FabLabelDirection.left:
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTextStyles.description.copyWith(color: color,fontWeight: FontWeight.bold),
            ),
            SizedBox(width: 6.w),
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: 60.w,
                height: 60.h,
                decoration: decoration,
                child: Icon(icon, color: AppColors.white,size: 30.r,),
              ),
            ),
          ],
        );

      case FabLabelDirection.right:
      return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: onTap,
              child: Container(
                width: 60.w,
                height: 60.h,
                decoration:decoration,
                child: Icon(icon, color: AppColors.white,size: 30.r,),
              ),
            ),
            SizedBox(width: 6.w),
            Text(
              label,
              style: AppTextStyles.description.copyWith(color: color,fontWeight: FontWeight.bold),
            ),
          ],
        );
    }
  }
}

enum FabLabelDirection { above, left, right }