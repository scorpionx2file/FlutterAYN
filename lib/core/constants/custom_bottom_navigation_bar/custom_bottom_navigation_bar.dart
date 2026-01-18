import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import '../../../config/routes/app_routes.dart';
import '../../theme/colors/app_colors.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  State<CustomBottomNavigationBar> createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int selectedIndex = 0;

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
                bottomNavigationItem(0, Icons.home, "Home"),
                bottomNavigationItem(1, Icons.public, "Map"),
                SizedBox(width: 40.w),
                bottomNavigationItem(2, Icons.storefront, "Gates"),
                bottomNavigationItem(3, Icons.person, "Profile"),
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
                  "Add",
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

  Widget bottomNavigationItem(int index, IconData icon, String title) {
    final bool isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
        switch(index){
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
      child: SizedBox(
        width: 40.w, // fixed width to align indicator
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
}



