import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

class CreateBagDialog extends StatefulWidget {
  const CreateBagDialog({super.key});

  @override
  State<CreateBagDialog> createState() => _CreateBagDialogState();
}

class _CreateBagDialogState extends State<CreateBagDialog> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  void _submit() => Navigator.pop(context, _ctrl.text);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: Text(
        context.l10n.createNewBagTitle,
        style: AppTextStyles.headingH3.copyWith(color: AppColors.black),
      ),
      content: TextField(
        controller: _ctrl,
        autofocus: true,
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => _submit(),
        decoration: InputDecoration(
          hintText: context.l10n.bagNameHint,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            context.l10n.cancel,
            style: AppTextStyles.text.copyWith(color: AppColors.spanishGrey),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.turnbullBlue),
          onPressed: _submit,
          child: Text(
            context.l10n.create,
            style: AppTextStyles.text.copyWith(color: AppColors.white),
          ),
        ),
      ],
    );
  }
}