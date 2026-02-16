import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/payment/presentation/widgets/payment_details_card/credit_card.dart';
import 'package:traveller/payment/presentation/widgets/payment_details_card/paypal_card.dart';
import 'package:traveller/payment/presentation/widgets/payment_methods_card.dart';

import '../../core/constants/button/app_button.dart';
import '../../core/constants/chosen_package_info/chosen_package_info_section.dart';
import '../../core/theme/colors/app_colors.dart';
import '../../core/theme/fonts/app_text_styles.dart';

class PaymentMethodScreen extends StatefulWidget {
  final int packagePrices ;
  final String packageTitle;

  const PaymentMethodScreen({super.key, required this.packagePrices, required this.packageTitle});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {

  int selectedIndex=0;

  final List<String> paymentMethodsImages = [
    "assets/images/Credit.png",
    "assets/images/payPal.png",
    "assets/images/Path.png"
  ];

  final List<Color> paymentMethodsColors = [
    AppColors.turnbullBlue,
    AppColors.verySoftViolet,
    AppColors.lightViolet
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Payment"),
        centerTitle: true,
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.w),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ChosenPackageInfoSection(
                packagePrices: widget.packagePrices,
                packageTitle: widget.packageTitle,

              ),
              SizedBox(height: 10.h),
              AppButton(
                text: "Confirmation and payment",
                textStyle: AppTextStyles.text,
                onPressed: () {
                },
                backgroundColor:AppColors.turnbullBlue,
              ),
            ],
          ),
        ),
      ),

      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 30.h)),

            SliverToBoxAdapter(
              child: Padding(
                padding:
                EdgeInsets.only(left: 16.w),
                child: Text(
                  "Choose the Payment Method",
                  style: AppTextStyles.headingH4,
                ),
              ),
            ),

            SliverToBoxAdapter(child: SizedBox(height: 30.h)),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 60.h,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16), // padding at start & end
                  separatorBuilder: (context, index) => SizedBox(width: 16), // equal spacing
                  scrollDirection: Axis.horizontal,
                  itemCount: paymentMethodsImages.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      child: PaymentMethodsCard(
                        background: paymentMethodsColors[index],
                        image: paymentMethodsImages[index],
                        isSelected: selectedIndex == index,
                      )
                    );
                  },
                ),
              )
            ),
            SliverToBoxAdapter(child: SizedBox(height: 20.h)),
            SliverToBoxAdapter(
               child:
                _selectedPaymentCard()
            )
          ],
        ),
      ),
    );
  }

  Widget _selectedPaymentCard(){
    if(selectedIndex==1){
      return PayPalCard(
        email: "ameerhasan@paypal.me",
        addedDate: "15/02/2017",
      );
    }
   return PaymentVisaCard();
  }
}
