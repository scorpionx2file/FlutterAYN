import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/select_service/presentation/screens/widgets/info_screen_header.dart';
import 'package:traveller/select_service/presentation/screens/widgets/service_date_and_time.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/constants/becom_service_indecator/page_indicator.dart';
import '../../../core/constants/button/app_button.dart';
import '../../../core/constants/profile_settings/profile_settings_header.dart';
import '../../../core/constants/profile_settings/profile_settings_tile.dart';
import '../../../core/theme/colors/app_colors.dart';

class SelectServiceScreen2 extends StatefulWidget {
  const SelectServiceScreen2({super.key});

  @override
  State<SelectServiceScreen2> createState() => _SelectServiceScreen2State();
}

class _SelectServiceScreen2State extends State<SelectServiceScreen2> {
  bool isSelected = false;
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Service Provider Info'), centerTitle: true),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 15.h)),

            SliverToBoxAdapter(child: InfoScreenHeaderSection()),
            SliverToBoxAdapter(child: SizedBox(height: 10.h)),

            SliverToBoxAdapter(child: PageIndicator(currentIndex: 1, total: 3)),
            SliverToBoxAdapter(child: SizedBox(height: 10.h)),

            SliverToBoxAdapter(
              child: ProfileSettingsHeader(
                name: 'Nour Essam',
                username: 'Tour guide',
                profileImage: const AssetImage("assets/images/profile.png"),
                isProfileSettings: true,
                isVerified: true,
                onBackPressed: () {},
                onEditPressed: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Row(
                  children: [
                    Icon(
                      Icons.public,
                      color: AppColors.strongGrey,
                      size: 20.sp,
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Text(
                        "Availability of services",
                        style: AppTextStyles.text.copyWith(
                          color: AppColors.strongGrey,
                        ),
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Switch(
                      value: isSelected,
                      onChanged: (value) {
                        setState(() {
                          isSelected = value;
                        });
                      },
                      activeThumbColor: AppColors.turnbullBlue,
                      inactiveThumbColor: AppColors.black,
                    ),
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(child: ServiceDateAndTimeSection()),
            SliverToBoxAdapter(child: SizedBox(height: 10.h)),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 14.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.white,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.turnbullBlue,
                        size: 24.sp,
                      ),
                      SizedBox(width: 5.w),
                      Text("Service Location", style: AppTextStyles.text),
                    ],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 14.h,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.white,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone_android,
                        color: AppColors.turnbullBlue,
                        size: 24.sp,
                      ),
                      SizedBox(width: 5.w),
                      Text("Phone Number", style: AppTextStyles.text),
                    ],
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 5.h)),

            SliverToBoxAdapter(
              child: ProfileSettingsTile(
                icon: Icon(
                  Icons.public_outlined,
                  size: 24.r,
                  color: AppColors.turnbullBlue,
                ),
                title: "Language",
                hasPermission: false,
                onTap: () {},
                background: AppColors.white,
                backArrowColor: AppColors.moderateBlue,
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 10.h)),

            SliverToBoxAdapter(
              child: ProfileSettingsTile(
                icon: Icon(
                  Icons.door_back_door_outlined,
                  size: 24.r,
                  color: AppColors.turnbullBlue,
                ),
                title: "Choose Gate",
                hasPermission: false,
                onTap: () {},
                background: AppColors.white,
                backArrowColor: AppColors.moderateBlue,
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(6.w),
                child: Container(
                  height: 120.h,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 14.h,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Top Title
                      Text("Your service details", style: AppTextStyles.text),

                      const Spacer(),

                      /// Bottom Row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Add Photos",
                            style: AppTextStyles.text.copyWith(
                              color: AppColors.turnbullBlue,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Icon(
                            Icons.image_outlined,
                            size: 20.sp,
                            color: AppColors.turnbullBlue,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 10.h)),

            SliverToBoxAdapter(
              child: Padding(
                padding:  EdgeInsets.all(4.0.w),
                child: Row(
                  children: [
                    Checkbox(
                    value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: Text(
                        "I acknowledge and accept the information mentioned above.",
                        style: AppTextStyles.description.copyWith(
                          color: AppColors.turnbullBlue,
                        ),
                      ),
                    ),
                  ]
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 10.h)),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppButton(
                  text: "Next",
                  textStyle: AppTextStyles.text,
                  onPressed: isChecked == false
                      ? null
                      : () {
                    context.push(AppRoutes.selectPackage);
                  },
                  backgroundColor: isChecked == false
                      ? Colors.grey
                      : AppColors.turnbullBlue,
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 10.h)),
          ],
        ),
      ),
    );
  }
}
