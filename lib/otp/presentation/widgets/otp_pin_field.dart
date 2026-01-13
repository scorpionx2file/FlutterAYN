import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

class OtpPinField extends StatefulWidget {
  const OtpPinField({
    super.key,
    this.length = 4,
    this.spacing = 18,
    this.activeUnderlineColor = AppColors.turnbullBlue,
    this.inactiveUnderlineColor = AppColors.lightSilver,
    this.textColor = AppColors.black,
    this.onChanged,
    this.onCompleted,
  });

  final int length;
  final double spacing;

  final Color activeUnderlineColor;
  final Color inactiveUnderlineColor;
  final Color textColor;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCompleted;

  @override
  State<OtpPinField> createState() => _OtpPinFieldState();
}

class _OtpPinFieldState extends State<OtpPinField> {
  late final List<TextEditingController> _controllers;
  late final List<FocusNode> _nodes;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(widget.length, (_) => TextEditingController());
    _nodes = List.generate(widget.length, (_) => FocusNode());
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  String _collect() => _controllers.map((e) => e.text).join();

  void _notify() {
    final code = _collect();
    widget.onChanged?.call(code);

    final complete = code.length == widget.length && !_controllers.any((c) => c.text.isEmpty);
    if (complete) widget.onCompleted?.call(code);
  }

  void _focusNext(int i) {
    if (i + 1 < widget.length) _nodes[i + 1].requestFocus();
    _notify();
  }

  void _focusPrev(int i) {
    if (i - 1 >= 0) _nodes[i - 1].requestFocus();
    _notify();
  }

  bool _isActiveIndex(int i) {
    final current = _nodes[i].hasFocus;
    final filled = _controllers[i].text.isNotEmpty;
    return current || filled;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.length, (i) {
        final controller = _controllers[i];
        final node = _nodes[i];

        return Padding(
          padding: EdgeInsets.symmetric(horizontal: (widget.spacing / 2).w),
          child: SizedBox(
            width: 34.w,
            child: Focus(
              onKeyEvent: (_, event) {
                if (event is KeyDownEvent &&
                    event.logicalKey == LogicalKeyboardKey.backspace) {
                  if (controller.text.isEmpty) {
                    _focusPrev(i);
                    return KeyEventResult.handled;
                  }
                }
                return KeyEventResult.ignored;
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller,
                    focusNode: node,
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.headingH3.copyWith(
                      color: widget.textColor,
                      height: 1.0,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(1),
                    ],
                    onChanged: (v) {
                      if (v.isNotEmpty) {
                        _focusNext(i);
                      } else {
                        _notify();
                      }
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 10.h),
                    ),
                  ),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    height: 3.h,
                    width: 26.w,
                    decoration: BoxDecoration(
                      color: _isActiveIndex(i)
                          ? widget.activeUnderlineColor
                          : widget.inactiveUnderlineColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
