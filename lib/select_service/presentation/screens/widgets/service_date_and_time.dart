import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/button/app_button.dart';
import '../../../../core/theme/colors/app_colors.dart';
import '../../../../core/theme/fonts/app_text_styles.dart';

class ServiceDateAndTimeSection extends StatefulWidget {
  const ServiceDateAndTimeSection({super.key});

  @override
  State<ServiceDateAndTimeSection> createState() =>
      _ServiceDateAndTimeSectionState();
}

class _ServiceDateAndTimeSectionState
    extends State<ServiceDateAndTimeSection> {

  /// ================= DATE =================

  List<String> selectedDays = [];
  String dateDisplay = "Select days";

  final List<String> weekdays = [
    'Mon','Tue','Wed','Thu','Fri','Sat','Sun'
  ];

  final List<String> fullWeekdays = [
    'Monday','Tuesday','Wednesday',
    'Thursday','Friday','Saturday','Sunday'
  ];

  OverlayEntry? _overlayEntry;
  final LayerLink _layerLink = LayerLink();
  bool isDropdownOpen = false;

  void _toggleDropdown() {
    if (isDropdownOpen) {
      _removeDropdown();
    } else {
      _showDropdown();
    }
  }

  void _showDropdown() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: 220.w,
        child: CompositedTransformFollower(
          link: _layerLink,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.spanishGrey,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [

                  /// Days
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: List.generate(fullWeekdays.length, (index) {

                      final day = fullWeekdays[index];
                      final shortDay = weekdays[index];
                      final isSelected =
                      selectedDays.contains(shortDay);

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              selectedDays.remove(shortDay);
                            } else {
                              selectedDays.add(shortDay);
                            }
                          });
                          _overlayEntry?.markNeedsBuild();
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.w, vertical: 4.h),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.lightGreen
                                : AppColors.lightSilver,
                            borderRadius:
                            BorderRadius.circular(20.r),
                          ),
                          child: Text(
                            day,
                            style: AppTextStyles.text.copyWith(
                              color: isSelected
                                  ? AppColors.turnbullBlue
                                  : AppColors.strongGrey,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),

                  SizedBox(height: 20.h),

                  /// Save button
                  SizedBox(
                    width: double.infinity,
                    child:AppButton(text: "Save", onPressed: (){
                      _updateDateDisplay();
                      _removeDropdown();
                    }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    isDropdownOpen = true;
  }

  void _removeDropdown() {
    _overlayEntry?.remove();
    _overlayEntry = null;
    isDropdownOpen = false;
  }

  void _updateDateDisplay() {
    if (selectedDays.isEmpty) {
      dateDisplay = "Select days";
    } else {
      selectedDays.sort((a, b) =>
          weekdays.indexOf(a).compareTo(
              weekdays.indexOf(b)));

      dateDisplay = selectedDays.join(', ');
    }

    setState(() {});
  }

  /// ================= TIME =================

  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  String timeDisplay = "4:00 PM - 8:00 PM";

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? startTime = await showTimePicker(
      context: context,
      initialTime: selectedStartTime ?? TimeOfDay.now(),
    );

    if (startTime != null) {
      final TimeOfDay? endTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: startTime.hour + 1,
          minute: startTime.minute,
        ),
      );

      if (endTime != null) {
        setState(() {
          selectedStartTime = startTime;
          selectedEndTime = endTime;

          timeDisplay =
          "${_formatTime(startTime)} - ${_formatTime(endTime)}";
        });
      }
    }
  }

  String _formatTime(TimeOfDay time) {
    final hour =
    time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final period =
    time.period == DayPeriod.am ? 'AM' : 'PM';
    return "$hour:${time.minute.toString().padLeft(2, '0')} $period";
  }

  /// ================= UI =================

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsets.symmetric(horizontal: 8.w),
      child: Row(
        children: [

          /// Date
          Expanded(
            child: CompositedTransformTarget(
              link: _layerLink,
              child: GestureDetector(
                onTap: _toggleDropdown,
                child: Container(
                  padding: EdgeInsets.symmetric(
                      vertical: 14.h),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius:
                    BorderRadius.circular(12.r),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    dateDisplay,
                    style:
                    AppTextStyles.text.copyWith(
                      color:
                      AppColors.turnbullBlue,
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 12.w),

          /// Time
          Expanded(
            child: GestureDetector(
              onTap: () {
                _selectTime(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: 14.h),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius:
                  BorderRadius.circular(12.r),
                ),
                alignment: Alignment.center,
                child: Text(
                  timeDisplay,
                  style:
                  AppTextStyles.text.copyWith(
                    color:
                    AppColors.turnbullBlue,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
