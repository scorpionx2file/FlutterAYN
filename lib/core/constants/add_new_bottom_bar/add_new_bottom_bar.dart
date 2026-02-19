import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/post_types/post_types.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import '../../theme/colors/app_colors.dart';
import '../button/app_button.dart';
import '../option_switch/option_switch.dart';

class AddNewBottomBar extends StatelessWidget{
  final String text;
  final String switchTitle;
  final VoidCallback onTap;
  final bool showSwitch;
  final bool showTypes;
  final List<PostTypeItem>? items;
  final Color buttonColor;
  final Widget? icon;
  final Color textColor;
  final bool switchValue;
  final Function(bool)? onSwitchChanged;

  const AddNewBottomBar({
    super.key,
    required this.text,
    required this.onTap,
    this.showSwitch = false,
    this.showTypes = false,
    this.switchTitle = "",
    this.items,
    this.buttonColor = AppColors.turnbullBlue,
    this.icon,
    this.textColor = AppColors.white,
    this.switchValue = false,
    this.onSwitchChanged,
  });


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          top: 12,
        ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if(showTypes)
            _AddMedia(items: items!),

          SizedBox(height: 16.h),

          if (showSwitch)
            OptionSwitch(
              title: switchTitle,
              value: switchValue,
              onChanged: onSwitchChanged ?? (_) {},
            ),

          SizedBox(height: 16.h),

          AppButton(
            text: text,
            onPressed: onTap,
            backgroundColor: buttonColor,
            icon: icon,
            textStyle: AppTextStyles.button.copyWith(
              color: textColor
            ),
          ),
        ],
      ),
    );
  }
}

class _AddMedia extends StatelessWidget {
  final List<PostTypeItem> items;
  final double spacing;

  const _AddMedia({
    required this.items,
    this.spacing = 15,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(items.length * 2 - 1, (index) {
        if (index.isEven) {
          final itemIndex = index ~/ 2;
          final item = items[itemIndex];
          return PostTypes(
            title: item.title,
            imageUrl: item.imageUrl,
            color: item.color,
            onTap: item.onTap,
          );
        } else {
          return SizedBox(width: spacing);
        }
      }),
    );
  }
}