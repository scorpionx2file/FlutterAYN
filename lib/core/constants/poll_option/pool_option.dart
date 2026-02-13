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
            width: 16.w,
            height: 16.h,
            decoration: BoxDecoration(
              color: AppColors.turnbullBlue,
              borderRadius: BorderRadius.circular(4.r),
            )
          ),

          SizedBox(width: 10.w),

          Expanded(
              child: TextField(
                controller: _controller,
                enabled: _isEditing,
                decoration: InputDecoration(
                  border: InputBorder.none,
                )
              )
          ),

          SizedBox(width: 24.w),

          IconButton(
              onPressed: (){
                setState(() {
                  _isEditing = !_isEditing;
                });
              },
              icon: Icon(
                _isEditing ? Icons.check : Icons.edit,
                color: AppColors.white,
              ),
            color: AppColors.turnbullBlue,
            iconSize: 10.sp,
          ),

          SizedBox(width: 10.w),

          IconButton(
            onPressed: () {
              widget.onTap;
            },
            icon: Icon(
              Icons.delete,
              color: AppColors.white,
            ),
            color: AppColors.lebaneseRed,
            iconSize: 10.sp,
          )
        ]
      ),
    );
  }
}