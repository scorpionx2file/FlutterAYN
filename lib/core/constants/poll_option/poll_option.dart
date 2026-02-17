import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

class PollOption extends StatefulWidget{
  final String initialText;
  final VoidCallback onTap;


  const PollOption({
    super.key,
    required this.initialText,
    required this.onTap,
  });

  @override
  State<PollOption> createState() => _PollOptionState();
}

class _PollOptionState extends State<PollOption>{
  late TextEditingController _controller;
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialText);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.spanishGrey,
          width: 1.w
        )
      ),
      child: Row(
        children: [
          Container(
            width: 5.w,
            height: 40.h,
            decoration: BoxDecoration(
              color: AppColors.turnbullBlue,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                bottomLeft: Radius.circular(12.r),
              ),
            ),
          ),

          SizedBox(width: 10.w),

          Flexible(
              child: SizedBox(
                width: 200.w,
                child: TextField(
                  controller: _controller,
                  enabled: _isEditing,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                ),
              )
          ),

          SizedBox(width: 40.w),

          _IconButtons(
              icon:  _isEditing ? Icons.check : Icons.edit,
              color: AppColors.turnbullBlue,
              onTap: (){
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
          ),

          SizedBox(width: 10.w),

          _IconButtons(
              icon: Icons.delete,
              color: AppColors.lebaneseRed, onTap:  () {
            widget.onTap();
          },
          )
        ]
      ),
    );
  }
}

class _IconButtons extends StatelessWidget{
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _IconButtons({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
          width: 25.w,
          height: 25.w,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(15.r),
          ),
          child: Icon(
            icon,
            color: AppColors.white,
            size: 15.sp,
          ),
        )
    );
  }
}