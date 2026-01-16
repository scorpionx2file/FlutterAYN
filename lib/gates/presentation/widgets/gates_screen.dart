import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

import '../../../core/constants/gate/app_gate_card.dart';
import '../../../core/constants/text_feild/app_text_feild.dart';

class GatesData{
  final String image;
  final String title;
  final AppGateBadgeData badge;
  final VoidCallback onTap;
  final Widget? flag;

  const GatesData({
    required this.image,
    required this.title,
    required this.badge,
    required this.onTap,
    this.flag,
  });
}

class GatesScreen extends StatelessWidget{
  final List<GatesData> gates;
  const GatesScreen({super.key, required this.gates});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Container(
      color: AppColors.white,
      child: Column(
        children: [
          SizedBox(height: 24.h),
          const _GatesHeader(),
          SizedBox(height: 12.h),
          Padding(
            padding: const EdgeInsets.all(8),
            child: AppTextFields(
             controller: controller,
             hintText: "Search a gate...",
             icon: Icons.search,
             iconColor: AppColors.black,
            ),
          ),
          SizedBox(height: 12.h),
          Expanded(
            child: _GatesGrid(
              gates: gates
            ),
          )
        ],
      ),
    );
  }
}

class _GatesHeader extends StatelessWidget{
  const _GatesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: (){},
            icon: Icon(
                Icons.arrow_back,
              color: AppColors.spanishGrey,
            )
        ),
        
        Expanded(
            child: Center(
              child: Text(
                "Gates",
                style: AppTextStyles.text.copyWith(
                  fontWeight: FontWeight.bold,
                )
              )
            )
        ),

        SizedBox(width: 48.w)
      ]
    );
  }
}

class _GatesGrid extends StatelessWidget{
  final List<GatesData> gates;

  const _GatesGrid({
    super.key,
    required this.gates
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      itemCount: gates.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 1,
        ),
      itemBuilder: (BuildContext context, int index) {
        return AppGateCard(
          title: gates[index].title,
          image: NetworkImage(gates[index].image),
          onTap: gates[index].onTap,
          flag: gates[index].flag,
          badge: gates[index].badge,
          height: 190.h,
        );
      },
    );
  }
}