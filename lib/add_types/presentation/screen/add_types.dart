import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/core/constants/add_new_bottom_bar/add_new_bottom_bar.dart';
import 'package:traveller/core/constants/text_feild/app_text_feild.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';
import '../../../core/constants/add_new_header/add_new_header.dart';
import '../../../core/constants/app_header/app_header.dart';
import '../../../core/theme/colors/app_colors.dart';
import '../../../core/utils/map_keys/map_keys.dart';

class AddTypesArgs{
  final String title;
  final bool isEvent;
  final int selectedIndex;

  const AddTypesArgs({
    required this.title,
    required this.isEvent,
    required this.selectedIndex
  });
}

class AddTypes extends StatefulWidget{
  final String title;
  final String imageUrl;
  final String location;
  final bool isEvent;
  final int? selectedIndex;

  const AddTypes({
    super.key,
    required this.title,
    required this.imageUrl,
    required this.location,
    required this.isEvent,
    this.selectedIndex,
  });

  @override
  State<AddTypes> createState() => _AddTypesState();
}

class _AddTypesState extends State<AddTypes> {
  final Set<int> selectedIndexes = {};
  List<String> filteredTypes = [];
  int selectedIndex = 0;
  final controller = TextEditingController();
  final types = [
    "Tourism",
    "Mountain climbing",
    "Services",
    "Events",
    "Pharos Civilization",
    "Tourist Information",
    "Model",
    "Travel Information"
  ];

  void _filterTypes(String query) {
    final lowerQuery = query.toLowerCase();

    setState(() {
      filteredTypes = types.where((type) {
        return type.toLowerCase().contains(lowerQuery);
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex ?? 0;
    filteredTypes = types;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        title: widget.title,
        showBack: true,
        onBack: () {
          final selectedTypes = selectedIndexes
              .map((index) => types[index])
              .toList();

          context.pop({
            MapKeys.types: selectedTypes,
            MapKeys.selectedIndex: selectedIndex,
          });
        },
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            AddNewHeader(
              imageUrl: widget.imageUrl,
              location: widget.location,
              isEventPage: widget.isEvent,
              selectedIndex: selectedIndex,
              onToggleChanged: (value) {
                setState(() {
                  selectedIndex = value;
                });
              },
            ),
            SizedBox(height: 20.h),

            AppTextFields(
              controller: controller,
              icon: Icons.search,
              hintText: context.l10n.searchForType,
              onChanged: _filterTypes,
            ),

            SizedBox(height: 40.h),

            Wrap(
              spacing: 10.w,
              children: List.generate(filteredTypes.length, (index) {
                final originalIndex = types.indexOf(filteredTypes[index]);
                final isSelected = selectedIndexes.contains(originalIndex);

                return ChoiceChip(
                  label: Text(filteredTypes[index]),
                  selected: isSelected,
                  onSelected: (value) {
                    setState(() {
                      if (value) {
                        selectedIndexes.add(originalIndex);
                      } else {
                        selectedIndexes.remove(originalIndex);
                      }
                    });
                  },
                  selectedColor: AppColors.lebaneseRed,
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r),
                      side: BorderSide(
                          color: AppColors.white,
                          width: 1.w
                      )
                  ),
                  labelStyle: TextStyle(
                    color: isSelected
                        ? AppColors.white
                        : AppColors.strongGrey,
                  ),
                  showCheckmark: false,
                );
              }),
            ),
            if (filteredTypes.isEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  context.l10n.noTypesFound,
                  style: TextStyle(color: AppColors.strongGrey),
                ),
              ),
          ]
        )
      ),

      bottomNavigationBar: AddNewBottomBar(
        text: context.l10n.save,
        onTap: () {
          final selectedTypes =
          selectedIndexes.map((index) => types[index]).toList();

          if (widget.isEvent) {
            context.pop({
              MapKeys.types: selectedTypes,
              MapKeys.selectedIndex: selectedIndex,
            });
          } else {
            context.pop(selectedTypes);
          }
        },
      ),
    );
  }
}