import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/add_new_header/add_new_header.dart';
import 'package:traveller/core/constants/app_header/app_header.dart';
import 'package:traveller/core/constants/poll_option/poll_option.dart';
import 'package:traveller/core/constants/text_area/text_area.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';
import '../../../add_new_topic/presentation/screen/poll_preview.dart';
import '../../../core/constants/add_new_bottom_bar/add_new_bottom_bar.dart';

class AddPoll extends StatefulWidget{
  final String imageUrl;
  final String location;
  final PollData? initialPoll;

  const AddPoll({
    super.key,
    required this.imageUrl,
    required this.location,
    this.initialPoll,
  });

  @override
  State<AddPoll> createState() => _AddPollState();
}

class _AddPollState extends State<AddPoll> {

  final TextEditingController questionController = TextEditingController();
  late List<TextEditingController> optionControllers;

  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_initialized) {
      if (widget.initialPoll != null) {
        questionController.text = widget.initialPoll!.question;

        optionControllers = widget.initialPoll!.options
            .map((option) => TextEditingController(text: option))
            .toList();
      } else {
        optionControllers = List.generate(
          3,
              (index) => TextEditingController(
            text: "${context.l10n.answer} ${index + 1}",
          ),
        );
      }

      _initialized = true;
    }
  }

  @override
  void dispose() {
    questionController.dispose();
    for (final controller in optionControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(title: context.l10n.addTopic),
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

            TextArea(
                hintText: context.l10n.pollQuestion,
                height: 50.h,
                controller: questionController
            ),

            SizedBox(height: 12.h),

            ...List.generate(optionControllers.length, (index){
              return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: PollOption(
                      controller: optionControllers[index],
                      onTap: (){
                        setState(() {
                          if (optionControllers.length > 2) {
                            optionControllers[index].dispose();
                            optionControllers.removeAt(index);
                          }
                        });
                      },
                    ),
              );
            }),

            SizedBox(height: 8.h),

            _DottedBorderButton(
                text: context.l10n.addAnswer,
                onTap: (){
                  setState(() {
                    optionControllers.add(
                      TextEditingController(text: "${context.l10n.answer} ${optionControllers.length + 1}"),
                    );
                  });
                }
            )
          ]
      ),
      ),
      bottomNavigationBar: AddNewBottomBar(
        text: context.l10n.addPoll,
        buttonColor: AppColors.yellow,
        onTap: () {
          final question = questionController.text.trim();

          final options = optionControllers
              .map((c) => c.text.trim())
              .where((text) => text.isNotEmpty)
              .toList();

          if (question.isEmpty || options.length < 2) return;

          final poll = PollData(question: question, options: options);
          Navigator.of(context).pop(poll);
        },
      )

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
