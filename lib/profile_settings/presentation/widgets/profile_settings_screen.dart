import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/profile_settings/profile_settings_header.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

import '../../../core/constants/profile_settings/profile_settings_tile.dart';
import '../../../core/constants/profile_settings/profile_settings_tile_segmented_toggle.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  int languageIndex = 0;
  int statusIndex = 0;
  int locationIndex = 0;
  int servicesIndex = 0;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [

        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Align(
              alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {},
                    child: Text("Logout",style: AppTextStyles.text.copyWith(color: AppColors.lebaneseRed,fontWeight: FontWeight.bold),)
                ),
              ),
          ),
        ),

        SliverToBoxAdapter(
          child: ProfileSettingsHeader(
            name: "Adham Mohamed",
            username: "adhambiko",
            profileImage: AssetImage("assets/images/profile.png"),
            isProfileSettings: true,
            isVerified: true,
            onBackPressed: () {},
            onEditPressed: () {},
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 12.h,),),

        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              "Application Performance",
              style: AppTextStyles.titles.copyWith(
                color: AppColors.turnbullBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: ProfileSettingsTile(
            icon: Icon(Icons.place,size: 24.r,color: AppColors.strongGrey,),
            title: "Favourite Gates",
            hasPermission: false,
            onTap: () {},
          ),
        ),
        SliverToBoxAdapter(
          child: ProfileSettingsTile(
            icon: Icon(Icons.notifications,size: 24.r,color: AppColors.strongGrey,),
            title: "Notifications",
            hasPermission: false,
            onTap: () {},
          ),
        ),
        SliverToBoxAdapter(
          child: ProfileSettingsTile(
            icon: Icon(Icons.language,size: 24.r,color: AppColors.strongGrey,),
            title: "Language",
            hasPermission: true,
            trailing: ProfileSettingsTileSegmentedToggle(
              options: ["English","العربيه"],
              selectedIndex: languageIndex,
              onChanged: (int value) {
                setState(() {
                  languageIndex = value;
                });
              },
            ),
            onTap: () {},
          ),
        ),
        SliverToBoxAdapter(
          child: ProfileSettingsTile(
            icon: Icon(Icons.remove_red_eye,size: 24.r,color: AppColors.strongGrey,),
            title: "Status",
            hasPermission: true,
            trailing: ProfileSettingsTileSegmentedToggle(
              options: ["Online","Offline"],
              selectedIndex: statusIndex,
              onChanged: (int value) {
                setState(() {
                  statusIndex = value;
                });
              },
            ),
            onTap: () {},
          ),
        ),
        SliverToBoxAdapter(
          child: ProfileSettingsTile(
            icon: Icon(Icons.my_location_sharp,size: 24.r,color: AppColors.strongGrey,),
            title: "Location",
            hasPermission: true,
            trailing: ProfileSettingsTileSegmentedToggle(
              options: ["ON","OFF"],
              selectedIndex: locationIndex,
              onChanged: (int value) {
                setState(() {
                  locationIndex = value;
                });
              },
            ),
            onTap: () {},
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 12.h,),),

        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              "Account Information",
              style: AppTextStyles.titles.copyWith(
                color: AppColors.turnbullBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: ProfileSettingsTile(
            icon: Icon(Icons.email,size: 24.r,color: AppColors.strongGrey,),
            title: "E-mail",
            hasPermission: false,
            onTap: () {},
          ),
        ),
        SliverToBoxAdapter(
          child: ProfileSettingsTile(
            icon: Image.asset("assets/images/icons/twitter.png",width: 24.w,height: 24.h,color: AppColors.strongGrey,),
            title: "Twitter Account",
            hasPermission: false,
            onTap: () {},
          ),
        ),
        SliverToBoxAdapter(
          child: ProfileSettingsTile(
            icon: Image.asset("assets/images/icons/snapchat.png",width: 24.w,height: 24.h,color: AppColors.strongGrey,),
            title: "Snapchat Account",
            hasPermission: false,
            onTap: () {},
          ),
        ),
        SliverToBoxAdapter(
          child: ProfileSettingsTile(
            icon: Icon(Icons.phone_iphone,size: 24.r,color: AppColors.strongGrey,),
            title: "Mobile Number",
            hasPermission: false,
            onTap: () {},
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 12.h,),),

        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              "Payment & Points",
              style: AppTextStyles.titles.copyWith(
                color: AppColors.turnbullBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: ProfileSettingsTile(
            icon: Icon(Icons.info,size: 24.r,color: AppColors.strongGrey,),
            title: "Points System",
            hasPermission: false,
            onTap: () {},
          ),
        ),
        SliverToBoxAdapter(
          child: ProfileSettingsTile(
            icon: Icon(Icons.payment,size: 24.r,color: AppColors.strongGrey,),
            title: "Payment Methods",
            hasPermission: false,
            onTap: () {},
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 12.h,),),

        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              "Others",
              style: AppTextStyles.titles.copyWith(
                color: AppColors.turnbullBlue,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),

        SliverToBoxAdapter(
          child: ProfileSettingsTile(
            icon: Icon(Icons.privacy_tip,size: 24.r,color: AppColors.strongGrey,),
            title: "Privacy & Policy",
            hasPermission: false,
            onTap: () {},
          ),
        ),
        SliverToBoxAdapter(
          child: ProfileSettingsTile(
            icon: Icon(Icons.phone,size: 24.r,color: AppColors.strongGrey,),
            title: "Contact Us",
            hasPermission: false,
            onTap: () {},
          ),
        ),
        SliverToBoxAdapter(
          child: ProfileSettingsTile(
            icon: Icon(Icons.question_mark,size: 24.r,color: AppColors.strongGrey,),
            title: "About Us",
            hasPermission: false,
            onTap: () {},
          ),
        ),

        SliverToBoxAdapter(child: SizedBox(height: 18.h,),),

        SliverToBoxAdapter(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                width: 220.w,
                height: 40.h,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.lebaneseRed,
                  borderRadius: BorderRadius.circular(30.r),
                ),
                child: Text(
                  "Become A Service Provider",
                  style: AppTextStyles.text.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: ProfileSettingsTile(
            icon: Icon(Icons.language,size: 24.r,color: AppColors.strongGrey,),
            title: "Services",
            hasPermission: true,
            trailing: ProfileSettingsTileSegmentedToggle(
              options: ["Available","Not Available"],
              selectedIndex: servicesIndex,
              onChanged: (int value) {
                setState(() {
                  servicesIndex = value;
                });
              },
            ),
            onTap: () {},
          ),
        ),
      ],
    );
  }
}
