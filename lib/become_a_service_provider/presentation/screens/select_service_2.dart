import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/constants/add_new_post_option_tile/add_new_post_option_tile.dart';
import '../../../core/constants/becom_service_indecator/page_indicator.dart';
import '../../../core/constants/button/app_button.dart';
import '../../../core/constants/profile_settings/profile_settings_header.dart';
import '../../../core/theme/colors/app_colors.dart';
import '../../../core/utils/helper/location.dart';
import '../widgets/info_screen_header.dart';
import '../widgets/service_date_and_time.dart';

class SelectServiceScreen2 extends StatefulWidget {
  const SelectServiceScreen2({super.key});

  @override
  State<SelectServiceScreen2> createState() => _SelectServiceScreen2State();
}

class _SelectServiceScreen2State extends State<SelectServiceScreen2> {
  bool isSelected = false;
  bool isChecked = false;
  String? selectedLocation;
  final TextEditingController _textController = TextEditingController();

  String selectedLanguage = "Language"; // default language

  final ImagePicker _picker = ImagePicker();
  final List<XFile> _images = [];

  Future<void> _pickImages() async {
    final List<XFile>? pickedFiles = await _picker.pickMultiImage();
    if (pickedFiles != null) {
      setState(() {
        _images.addAll(pickedFiles);
      });
    }
  }

  void _openLanguagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        String tempSelection = selectedLanguage; // temp variable for bottom sheet

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              padding: EdgeInsets.all(16.0.w),
              height: 200.h,
              width: double.infinity,
              color: AppColors.white,
              child: Column(
                children: [
                  SizedBox(height: 10.h),
                  Text("Select Language", style: AppTextStyles.text),
                  SizedBox(height: 10.h),
                  RadioListTile<String>(
                    title: Text("English", style: AppTextStyles.text),
                    value: "English",
                    groupValue: tempSelection,
                    onChanged: (value) {
                      setModalState(() {
                        tempSelection = value!;
                      });
                    },
                  ),
                  RadioListTile<String>(
                    title: Text("Arabic", style: AppTextStyles.text),
                    value: "Arabic",
                    groupValue: tempSelection,
                    onChanged: (value) {
                      setModalState(() {
                        tempSelection = value!;
                      });
                    },
                  ),
                  AppButton(
                    text: "Done",
                    onPressed: () {
                      setState(() {
                        selectedLanguage = tempSelection; // save selection to main screen
                      });
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Service Provider Info'), centerTitle: true),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AppButton(
          text: "Next",
          textStyle: AppTextStyles.text,
          onPressed: isChecked == false
              ? null
              : () {
                  context.push(AppRoutes.payment);
                },
          backgroundColor: isChecked == false
              ? Colors.grey
              : AppColors.turnbullBlue,
        ),
      ),
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
                child: GestureDetector(
                  onTap: () {
                    openLocationPicker(context, (locationUrl) {
                      setState(() {
                        selectedLocation = locationUrl;
                      });
                    });
                  },
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
                        Expanded(
                          child: Text(
                            selectedLocation ?? "Service Location",
                            style: AppTextStyles.text,
                            maxLines: 3,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.white,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      counterText: "",
                      hintText: "Phone Number",
                      hintStyle: AppTextStyles.titles,
                      border: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.phone_android,
                        color: AppColors.turnbullBlue,
                        size: 22.sp,
                      ),
                    ),
                    keyboardType: TextInputType.phone,
                    maxLength: 11,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 5.h)),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: AddNewPostOptionTile(
                  icon: Icon(
                    Icons.public_outlined,
                    size: 24.r,
                    color: AppColors.turnbullBlue,
                  ),
                  title: selectedLanguage, // show current selection
                  onTap: _openLanguagePicker,
                  showDivider: false,
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 10.h)),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0.w),
                child: AddNewPostOptionTile(
                  icon: Icon(
                    Icons.door_back_door_outlined,
                    size: 24.r,
                    color: AppColors.turnbullBlue,
                  ),
                  title: 'Choose Gate',
                  onTap: () {},
                  showDivider: false,
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 8.w),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min, // <-- important
                    children: [
                      /// Top Title
                      /// Text Input
                      TextField(
                        controller: _textController, // your TextEditingController
                        maxLines: null, // allows multiple lines
                        decoration: InputDecoration(
                          hintText: "Write your service details...",
                          border: InputBorder.none,
                        ),
                        style: AppTextStyles.text,
                      ),

                      SizedBox(height: 8.h),

                      /// Images Preview Row
                      if (_images.isNotEmpty)
                        SizedBox(
                          height: 70.h,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: _images.length,
                            separatorBuilder: (_, __) => SizedBox(width: 8.w),
                            itemBuilder: (_, index) => ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.file(
                                File(_images[index].path),
                                width: 70.w,
                                height: 70.h,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),

                      SizedBox(height: 12.h),

                      /// Bottom Row
                      GestureDetector(
                        onTap: _pickImages,
                        child: Row(
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
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 10.h)),

            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.all(4.0.w),
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
                  ],
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 10.h)),

            /*SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppButton(
                  text: "Next",
                  textStyle: AppTextStyles.text,
                  onPressed: isChecked == false
                      ? null
                      : () {
                    context.push(AppRoutes.payment);
                  },
                  backgroundColor: isChecked == false
                      ? Colors.grey
                      : AppColors.turnbullBlue,
                ),
              ),
            ),
            SliverToBoxAdapter(child: SizedBox(height: 10.h)),*/
          ],
        ),
      ),
    );
  }
}
