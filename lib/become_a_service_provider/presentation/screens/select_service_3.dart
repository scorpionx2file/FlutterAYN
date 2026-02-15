import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/config/routes/app_routes.dart';
import 'package:traveller/core/constants/chosen_package_info/chosen_package_info_section.dart';

import '../../../core/constants/becom_service_indecator/page_indicator.dart';
import '../../../core/constants/button/app_button.dart';
import '../../../core/constants/service_package/package_card.dart';
import '../../../core/theme/colors/app_colors.dart';
import '../../../core/theme/fonts/app_text_styles.dart';

class ServicePaymentScreen extends StatefulWidget {
  const ServicePaymentScreen({super.key});

  @override
  State<ServicePaymentScreen> createState() =>
      _ServicePaymentScreenState();
}

class _ServicePaymentScreenState
    extends State<ServicePaymentScreen> {

  int? selectedIndex;

  final List<int> packagePrices = [650, 150, 4850];
  final List<String> packageTitle = ["Free Trial", "Monthly Package", "Annual Package"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.w),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selectedIndex != null)
                ChosenPackageInfoSection(
                  packagePrices: packagePrices[selectedIndex!],
                  packageTitle: packageTitle[selectedIndex!],
                ),
              AppButton(
                text: "Confirmation and payment",
                textStyle: AppTextStyles.text,
                onPressed: selectedIndex == null
                    ? null
                    : () {
                  context.push(
                    AppRoutes.paymentMethod,
                    extra: {
                      "title": packageTitle[selectedIndex!],
                      "price": packagePrices[selectedIndex!],
                    },
                  );
                },
                backgroundColor: selectedIndex == null
                    ? Colors.grey
                    : AppColors.turnbullBlue,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [

            SliverToBoxAdapter(child: SizedBox(height: 15.h)),

            SliverToBoxAdapter(
              child: Padding(
                padding:
                EdgeInsets.only(left: 12.w),
                child: Text(
                  "Choose the package \nthat suits you",
                  style: AppTextStyles.headingH4,
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 10.h)),

            SliverToBoxAdapter(
               child: PageIndicator(
                currentIndex: 2,
                total: 3,
                           ),
             ),

            /// ========= Packages =========

            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 0;
                  });
                },
                child: PackageCard(
                  title: packageTitle[0],
                  description:
                  "Enjoy a free trial period, then choose the package that suits you best.",
                  price: packagePrices[0].toString(),
                  titleColor:
                  AppColors.moderateBlue,
                  isSelected:
                  selectedIndex == 0,
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 1;
                  });
                },
                child: PackageCard(
                  title: packageTitle[1],
                  description:
                  "Enjoy a free trial period, then choose the package that suits you best.",
                  price: packagePrices[1].toString(),
                  points: "180",
                  titleColor:
                  AppColors.turnbullBlue,
                  isSelected:
                  selectedIndex == 1,
                ),
              ),
            ),

            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = 2;
                  });
                },
                child: PackageCard(
                  title:packageTitle[2],
                  description:
                  "Enjoy a free trial period, then choose the package that suits you best.",
                  price: packagePrices[2].toString(),
                  titleColor:
                  AppColors.vividPink,
                  isSelected:
                  selectedIndex == 2,
                ),
              ),
            ),

            //SliverToBoxAdapter(child: const Spacer()),

            /// ========= TOTAL SECTION =========

            /*if (selectedIndex != null)
              SliverToBoxAdapter(
               child: ChosenPackageInfoSection(
                   packagePrices: packagePrices[selectedIndex!],
                 packageTitle: packageTitle[selectedIndex!],
                 selectedIndex: selectedIndex??0,

               ),
             ),*/

            /// ========= BUTTON =========

           /* SliverToBoxAdapter(
              child: Padding(
                padding:
                EdgeInsets.all(16.w),
                child: AppButton(
                  text:
                  "Confirmation and payment",
                  textStyle:
                  AppTextStyles.text,
                  onPressed:
                  selectedIndex == null
                      ? null
                      : () {
                    context.push(AppRoutes.paymentMethod);
                  },
                  backgroundColor:
                  selectedIndex == null
                      ? Colors.grey
                      : AppColors
                      .turnbullBlue,
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
