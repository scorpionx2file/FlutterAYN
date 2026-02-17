import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/bag/sheet_container.dart';
import 'package:traveller/core/constants/bag/sheet_handle.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

import '../../theme/colors/app_colors.dart';
import '../../theme/fonts/app_text_styles.dart';
import '../button/app_button.dart';
import 'bag_list.dart';
import 'create_bag_dialog.dart';
import 'create_new_bag_row.dart';

class SaveToBagBottomSheet extends StatefulWidget {
  const SaveToBagBottomSheet({super.key});

  @override
  State<SaveToBagBottomSheet> createState() => _SaveToBagBottomSheetState();
}

class _SaveToBagBottomSheetState extends State<SaveToBagBottomSheet> {
  int selectedIndex = 0;

  final List<String> _bags = const ["My Bag"].toList();

  @override
  void initState() {
    super.initState();
    selectedIndex = 0;
  }

  void _onSelect(int i) => setState(() => selectedIndex = i);

  Future<void> _onCreateNew() async {
    final name = await showDialog<String?>(
      context: context,
      barrierDismissible: true,
      builder: (_) => const CreateBagDialog(),
    );

    final trimmed = name?.trim() ?? "";
    if (trimmed.isEmpty) return;

    setState(() {
      _bags.add(trimmed);
      selectedIndex = _bags.length - 1;
    });
  }

  void _onAdd() => Navigator.pop(context);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: SheetContainer(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SheetHandle(),
            Text(
              context.l10n.saveToBagsTitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.headingH3.copyWith(color: AppColors.black),
            ),
            SizedBox(height: 14.h),

            BagList(
              items: _bags,
              selectedIndex: selectedIndex,
              onSelect: _onSelect,
            ),

            SizedBox(height: 8.h),

            CreateNewBagRow(
              text: context.l10n.createNewBag,
              onTap: _onCreateNew,
            ),

            SizedBox(height: 12.h),

            AppButton(
              text: context.l10n.add,
              onPressed: _onAdd,
              height: 44,
              borderRadius: 12,
              backgroundColor: AppColors.turnbullBlue,
              foregroundColor: AppColors.white,
              textStyle: AppTextStyles.text.copyWith(
                fontWeight: FontWeight.bold,
              ),
              width: double.infinity,
            ),

            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
