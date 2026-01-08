import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

import '../../theme/fonts/app_text_styles.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final int trimLines;

  const ExpandableText({
    super.key,
    required this.text,
    this.trimLines = 3,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textSpan = TextSpan(
          text: widget.text,
          style: AppTextStyles.description.copyWith(
            color: AppColors.spanishGrey
          ),
        );

        final textPainter = TextPainter(
          text: textSpan,
          maxLines: widget.trimLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: constraints.maxWidth);

        final isOverflowing = textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.text,
              maxLines: _isExpanded ? null : widget.trimLines,
              overflow:
              _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              style: AppTextStyles.description.copyWith(
                  color: AppColors.spanishGrey
              ),
            ),

            if (isOverflowing)
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                child: Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    _isExpanded ? "less" : "read more",
                    style: AppTextStyles.button.copyWith(
                        color: AppColors.turnbullBlue
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}