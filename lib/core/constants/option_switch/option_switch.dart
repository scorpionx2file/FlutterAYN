import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import '../../theme/colors/app_colors.dart';

class OptionSwitch extends StatefulWidget{
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const OptionSwitch({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  State<OptionSwitch> createState() => _OptionSwitchState();
}
class _OptionSwitchState extends State<OptionSwitch>{

  
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Switch(
            value: widget.value,
            onChanged: widget.onChanged,
            activeThumbColor: AppColors.turnbullBlue,
            activeTrackColor: AppColors.spanishGrey,
        ),
        SizedBox(width: 10.w),
        Text(
            widget.title,
            style: AppTextStyles.titles.copyWith(
              color: AppColors.black
            )
        )
      ]
    );
  }
}