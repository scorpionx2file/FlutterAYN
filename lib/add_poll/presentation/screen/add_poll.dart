import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/add_new_header/add_new_header.dart';
import 'package:traveller/core/constants/app_header/app_header.dart';
import 'package:traveller/core/constants/button/app_button.dart';
import 'package:traveller/core/constants/option_switch/option_switch.dart';
import 'package:traveller/core/constants/poll_option/poll_option.dart';
import 'package:traveller/core/constants/text_area/text_area.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class AddPoll extends StatefulWidget{
  final String imageUrl;
  final String location;

  const AddPoll({
    super.key,
    required this.imageUrl,
    required this.location
  });

  @override
  State<AddPoll> createState() => _AddPollState();
}

class _AddPollState extends State<AddPoll>{
  List<String> options = ["Option 1", "Option 2", "Option 3"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: "Add Topic"),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            AddNewHeader(
                imageUrl: widget.imageUrl,
                location: widget.location,
                isEventPage: false
            ),

            SizedBox(height: 20.h),

            OptionSwitch(
              title: "Add Poll",
              value: true,
              onChanged: (bool value) {  },
            ),

            SizedBox(height: 10.h),

            TextArea(
                hintText: "Poll Question",
                height: 50.h
            ),

            SizedBox(height: 12.h),

            ...List.generate( options.length, (index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PollOption(
                        initialText: "Option ${index+1}",
                        onTap: (){
                          setState(() {
                            options.removeAt(index);
                          });
                        }
                    ),
                  );
            }),

            SizedBox(height: 8.h),

            _DottedBorderButton(
                text: "Add Answer",
                onTap: (){
                  setState(() {
                    options.add("Option ${options.length + 1}");
                  });
                }
            )
          ]
      ),
      ),
      bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom+20,
            top: 12
          ),
        child: AppButton(
          text: "Add Poll",
          backgroundColor: AppColors.yellow,
          textStyle: AppTextStyles.button.copyWith(
            color: AppColors.black,
          ),
          onPressed: (){},
        ),
      ),
    );
  }
}

class _DottedBorderButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _DottedBorderButton({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: _DottedBorderPainter(borderRadius: 12.r),
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Text(
            text,
            style: AppTextStyles.button.copyWith(color: AppColors.strongGrey),
          ),
        ),
      ),
    );
  }
}

class _DottedBorderPainter extends CustomPainter {
  final double borderRadius;

  _DottedBorderPainter({this.borderRadius = 0});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.spanishGrey
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final path = Path()
      ..addRRect(RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          Radius.circular(borderRadius)));

    double dashWidth = 6;
    double dashSpace = 4;

    double distance = 0;
    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      while (distance < metric.length) {
        final extractPath =
        metric.extractPath(distance, distance + dashWidth.clamp(0, metric.length - distance));
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
