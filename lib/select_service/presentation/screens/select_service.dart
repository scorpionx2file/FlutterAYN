import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/select_service/presentation/screens/widgets/page_indicator.dart';

import '../../../core/constants/button/app_button.dart';
import '../../../core/constants/service_card/service_card.dart';
import '../../../core/theme/colors/app_colors.dart';

class SelectServiceScreen extends StatefulWidget {
  const SelectServiceScreen({super.key});

  @override
  State<SelectServiceScreen> createState() => _SelectServiceScreenState();
}

class _SelectServiceScreenState extends State<SelectServiceScreen> {
  int? selectedIndex; // null = no selection

  final List<Map<String, dynamic>> services = [
    {
      "service": "Trip Organizer",
      "image": "assets/images/tourOperator.png",
      "colors": [AppColors.babyPink, AppColors.orange],
    },
    {
      "service": "Tour Guide",
      "image": "assets/images/guide.png",
      "colors": [AppColors.babyBlue, AppColors.lightViolet],
    },
    {
      "service": "Soon",
      "image": "assets/images/soon.png",
      "colors": [AppColors.veryPaleViolet, AppColors.veryPaleViolet],
    },
    {
      "service": "Car Rental",
      "image": "assets/images/car.png",
      "colors": [AppColors.veryLightPink, AppColors.vividPink],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Service Provider',
          style: AppTextStyles.text.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 15.h),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: Text(
              "Choose the service\n you want to offer",
              style: AppTextStyles.headingH4,
            ),
          ),
          SizedBox(height: 10.h),
          PageIndicator(
            currentIndex: 0,
            total: 3,
          ),
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: GridView.builder(
            shrinkWrap: true,
            itemCount: services.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final service = services[index];
              final isSelected = selectedIndex == index;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [ServiceCard(
                    service: service["service"],
                    image: service["image"],
                    colors: service["colors"],
                    isSelected: isSelected,
                  ),
                    // Checkmark outside the card
                    if (isSelected)
                      Positioned(
                        top: -8.h,
                        left: -8.w,
                        child: Container(
                          width: 24.w,
                          height: 24.w,
                          decoration: BoxDecoration(
                            color: AppColors.turnbullBlue,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2.w,
                            ),
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 16,
                          ),
                        ),
                      ),
                ]
                ),
              );
            },
          ),
          ),
          SizedBox(height: 30.h),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AppButton(
              text: "Next",
              textStyle: AppTextStyles.text,
              onPressed: selectedIndex == null
                  ? null
                  : () {
                // handle next action
              },
              backgroundColor: selectedIndex == null
                  ? Colors.grey
                  : AppColors.turnbullBlue,
            ),
          ),
        ],
      ),
    );
  }
}
