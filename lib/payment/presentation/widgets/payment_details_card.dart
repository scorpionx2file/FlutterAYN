import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

import '../../../core/theme/colors/app_colors.dart';
import '../../../core/utils/helper/custom_number_formatter.dart';

class PaymentVisaCard extends StatefulWidget {
  const PaymentVisaCard({super.key});

  @override
  State<PaymentVisaCard> createState() => _PaymentVisaCardState();
}

class _PaymentVisaCardState extends State<PaymentVisaCard> {

  final nameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryDateController = TextEditingController();
  final cvvController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    cardNumberController.dispose();
    cvvController.dispose();
    expiryDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0.w),
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Container(
          padding:  EdgeInsets.symmetric(horizontal: 14.w,vertical: 28.h),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Name on Card",style: AppTextStyles.text,),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  hintText: "Name",
                  hintStyle: AppTextStyles.text.copyWith(color: AppColors.spanishGrey),

                ),
              ),
              SizedBox(height: 25.h),
              Text("Card Number",style: AppTextStyles.text,),
              TextField(
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(16),
                  CustomNumberFormatter(),
                ],
                controller: cardNumberController,
                decoration: InputDecoration(
                  hintText: "XXXX XXXX XXXX XXXX",
                  hintStyle: AppTextStyles.text.copyWith(color: AppColors.spanishGrey),
                  suffixIcon: Image.asset("assets/images/IconCard.png"),
                ),
              ),
              SizedBox(height: 25.h),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Expiry Date",style: AppTextStyles.text,),
                        TextField(
                          controller: expiryDateController,
                          decoration: InputDecoration(
                            hintText: "MM/YY",
                            hintStyle: AppTextStyles.text.copyWith(color: AppColors.spanishGrey),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 25.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("CVV",style: AppTextStyles.text,),
                        TextField(
                          controller: cvvController,
                          decoration: InputDecoration(
                            hintText: "***",
                            hintStyle: AppTextStyles.text.copyWith(color: AppColors.spanishGrey),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ]
          ),
        ),
      ),
    );
  }
}
