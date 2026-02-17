import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/config/routes/app_routes.dart';
import 'package:traveller/core/constants/profile_settings/profile_settings_header.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

import '../../../core/constants/profile_settings/profile_settings_tile.dart';
import '../../../core/constants/profile_settings/profile_settings_tile_segmented_toggle.dart';
import '../widgets/points_welcome_dialog.dart';

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
    final l10n = context.l10n;

    return Scaffold(
      appBar: AppBar(
      centerTitle: true,
      title: Text(
        context.l10n.settings,
        style: AppTextStyles.titles.copyWith(fontWeight: FontWeight.bold),
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            l10n.logout,
            style: AppTextStyles.text.copyWith(
              color: AppColors.lebaneseRed,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(width: 8.w),
      ],
    ),
    body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ProfileSettingsHeader(
                name: "Adham Mohamed",
                username: "adhambiko",
                profileImage: const AssetImage("assets/images/profile.png"),
                isProfileSettings: true,
                isVerified: true,
                onBackPressed: () {},
                onEditPressed: () {},
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 12.h)),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  l10n.profileSettingsSectionAppPerformance,
                  style: AppTextStyles.titles.copyWith(
                    color: AppColors.turnbullBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: ProfileSettingsTile(
                icon: Icon(
                  Icons.place,
                  size: 24.r,
                  color: AppColors.strongGrey,
                ),
                title: l10n.favouriteGates,
                hasPermission: false,
                onTap: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: ProfileSettingsTile(
                icon: Icon(
                  Icons.notifications,
                  size: 24.r,
                  color: AppColors.strongGrey,
                ),
                title: l10n.notifications,
                hasPermission: false,
                onTap: () {
                  context.push(AppRoutes.notifications);
                },
              ),
            ),
            SliverToBoxAdapter(
              child: ProfileSettingsTile(
                icon: Icon(
                  Icons.language,
                  size: 24.r,
                  color: AppColors.strongGrey,
                ),
                title: l10n.language,
                hasPermission: true,
                trailing: ProfileSettingsTileSegmentedToggle(
                  options: [l10n.english, l10n.arabic],
                  selectedIndex: languageIndex,
                  onChanged: (int value) {
                    setState(() => languageIndex = value);
                  },
                ),
                onTap: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: ProfileSettingsTile(
                icon: Icon(
                  Icons.remove_red_eye,
                  size: 24.r,
                  color: AppColors.strongGrey,
                ),
                title: l10n.status,
                hasPermission: true,
                trailing: ProfileSettingsTileSegmentedToggle(
                  options: [l10n.online, l10n.offline],
                  selectedIndex: statusIndex,
                  onChanged: (int value) {
                    setState(() => statusIndex = value);
                  },
                ),
                onTap: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: ProfileSettingsTile(
                icon: Icon(
                  Icons.my_location_sharp,
                  size: 24.r,
                  color: AppColors.strongGrey,
                ),
                title: l10n.location,
                hasPermission: true,
                trailing: ProfileSettingsTileSegmentedToggle(
                  options: [l10n.on, l10n.off],
                  selectedIndex: locationIndex,
                  onChanged: (int value) {
                    setState(() => locationIndex = value);
                  },
                ),
                onTap: () {},
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 12.h)),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  l10n.accountInformation,
                  style: AppTextStyles.titles.copyWith(
                    color: AppColors.turnbullBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: ProfileSettingsTile(
                icon: Icon(
                  Icons.email,
                  size: 24.r,
                  color: AppColors.strongGrey,
                ),
                title: l10n.email,
                hasPermission: false,
                onTap: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: ProfileSettingsTile(
                icon: Image.asset(
                  "assets/images/icons/twitter.png",
                  width: 24.w,
                  height: 24.h,
                  color: AppColors.strongGrey,
                ),
                title: l10n.twitterAccount,
                hasPermission: false,
                onTap: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: ProfileSettingsTile(
                icon: Image.asset(
                  "assets/images/icons/snapchat.png",
                  width: 24.w,
                  height: 24.h,
                  color: AppColors.strongGrey,
                ),
                title: l10n.snapchatAccount,
                hasPermission: false,
                onTap: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: ProfileSettingsTile(
                icon: Icon(
                  Icons.phone_iphone,
                  size: 24.r,
                  color: AppColors.strongGrey,
                ),
                title: l10n.mobileNumber,
                hasPermission: false,
                onTap: () {},
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 12.h)),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  l10n.paymentAndPoints,
                  style: AppTextStyles.titles.copyWith(
                    color: AppColors.turnbullBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: ProfileSettingsTile(
                icon: Icon(Icons.info, size: 24.r, color: AppColors.strongGrey),
                title: l10n.pointsSystem,
                hasPermission: false,
                  onTap: () {
                    PointsWelcomeDialog.show(
                      context,
                      points: 120,
                      onStart: () {},
                    );
                  },
              ),
            ),
            SliverToBoxAdapter(
              child: ProfileSettingsTile(
                icon: Icon(
                  Icons.payment,
                  size: 24.r,
                  color: AppColors.strongGrey,
                ),
                title: l10n.paymentMethods,
                hasPermission: false,
                onTap: () {},
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 12.h)),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Text(
                  l10n.others,
                  style: AppTextStyles.titles.copyWith(
                    color: AppColors.turnbullBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: ProfileSettingsTile(
                icon: Icon(
                  Icons.privacy_tip,
                  size: 24.r,
                  color: AppColors.strongGrey,
                ),
                title: l10n.privacyPolicy,
                hasPermission: false,
                onTap: () {},
              ),
            ),
            SliverToBoxAdapter(
              child: ProfileSettingsTile(
                icon: Icon(
                  Icons.phone,
                  size: 24.r,
                  color: AppColors.strongGrey,
                ),
                title: l10n.contactUs,
                hasPermission: false,
                onTap: () {
                  context.push(AppRoutes.settingsContact);
                },
              ),
            ),
            SliverToBoxAdapter(
              child: ProfileSettingsTile(
                icon: Icon(
                  Icons.question_mark,
                  size: 24.r,
                  color: AppColors.strongGrey,
                ),
                title: l10n.aboutUs,
                hasPermission: false,
                onTap: () {
                  context.push(AppRoutes.termsPrivacy);
                },
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 18.h)),

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
                      l10n.becomeServiceProvider,
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
                icon: Icon(
                  Icons.language,
                  size: 24.r,
                  color: AppColors.strongGrey,
                ),
                title: l10n.services,
                hasPermission: true,
                trailing: ProfileSettingsTileSegmentedToggle(
                  options: [l10n.available, l10n.notAvailable],
                  selectedIndex: servicesIndex,
                  onChanged: (int value) {
                    setState(() => servicesIndex = value);
                  },
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
    );
  }
}
