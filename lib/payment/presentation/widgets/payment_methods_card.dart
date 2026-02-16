import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

class PaymentMethodsCard extends StatefulWidget {
  final Color background;
  final String image;
  final bool isSelected;

  const PaymentMethodsCard({super.key, required this.background, required this.image, required this.isSelected});

  @override
  State<PaymentMethodsCard> createState() => _PaymentMethodsCardState();
}

class _PaymentMethodsCardState extends State<PaymentMethodsCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      decoration: BoxDecoration(
        color: widget.isSelected?widget.background:AppColors.veryLightGray,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Image.asset(widget.image),
    );
  }
}
