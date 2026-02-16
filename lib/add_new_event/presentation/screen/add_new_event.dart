import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:traveller/add_types/presentation/screen/add_types.dart';
import 'package:traveller/core/constants/add_new_bottom_bar/add_new_bottom_bar.dart';
import 'package:traveller/core/constants/event_data/event_data.dart';
import 'package:traveller/core/constants/post_types/post_types.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/constants/add_new_build_map/add_new_build_map.dart';
import '../../../core/constants/add_new_header/add_new_header.dart';
import '../../../core/constants/add_new_post_option_tile/add_new_post_option_tile.dart';
import '../../../core/constants/app_header/app_header.dart';
import '../../../core/constants/text_area/text_area.dart';
import '../../../core/theme/colors/app_colors.dart';
import '../../../core/utils/location/location_service.dart';

class AddNewEvent extends StatefulWidget {
  final String imageUrl;
  final String location;

  const AddNewEvent({
    super.key,
    required this.imageUrl,
    required this.location,
  });

  @override
  State<AddNewEvent> createState() => _AddNewEventState();
}

class _AddNewEventState extends State<AddNewEvent>{
  int selectedIndex = 1;
  DateTime? eventDate;
  DateTime? lastDate;
  double eventPayment = 120;
  int personsNumber = 150;
  LatLng? selectedLocation;

  @override
  void initState() {
    super.initState();
    _loadCurrentLocation();
  }

  Future<void> _loadCurrentLocation() async {
    final current = await LocationService.getCurrentLatLng();
    if (current != null && mounted) {
      setState(() {
        selectedLocation = current;
      });
    }
  }

  String convertMonthToText({required int month}) {
    return switch (month) {
      1 => "Jan",
      2 => "Feb",
      3 => "Mar",
      4 => "Apr",
      5 => "May",
      6 => "Jun",
      7 => "Jul",
      8 => "Aug",
      9 => "Sep",
      10 => "Oct",
      11 => "Nov",
      12 => "Dec",
      _ => "Invalid month",
    };
  }

  Widget _buildDateSection({
    required String title,
    required DateTime? date,
    required VoidCallback onTap,
    required String text,
  }) {
    return EventData(
      title: title,
      icon: "assets/images/icons/calender.png",
      child: GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: TextStyle(
            color: date != null
                ? Colors.black
                : AppColors.spanishGrey,
          ),
        ),
      ),
    );
  }

  Future<void> _pickEventDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: eventDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );

    if (pickedDate == null) return;

    TimeOfDay? pickedTime = await showTimePicker(
      initialTime: TimeOfDay.now(),
      context: context,
    );

    if (pickedTime == null) return;

    final combinedDateTime = DateTime(
      pickedDate.year,
      pickedDate.month,
      pickedDate.day,
      pickedTime.hour,
      pickedTime.minute,
    );

    setState(() {
      eventDate = combinedDateTime;
    });
  }

  Future<void> _pickLastDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: lastDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: eventDate!,
    );

    if (picked != null) {
      setState(() {
        lastDate = picked;
      });
    }
  }

  Widget _buildCounterSection({
    required String title,
    required String icon,
    required int value,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
  }) {
    return EventData(
      title: title,
      icon: icon,
      trailing: [
        GestureDetector(
          onTap: onDecrement,
          child: Icon(
            Icons.minimize,
            color: AppColors.spanishGrey,
            size: 20.sp,
          ),
        ),
        SizedBox(width: 10.w),
        GestureDetector(
          onTap: onIncrement,
          child: Icon(
            Icons.add,
            color: AppColors.spanishGrey,
            size: 20.sp,
          ),
        ),
      ],
      child: Text(
        "$value\$",
        style: AppTextStyles.text,
      ),
    );
  }

  Widget _buildPaymentAndAvailability() {
    return AnimatedCrossFade(
      firstChild: const SizedBox.shrink(),
      secondChild: SizedBox(
        width: double.infinity,
        child: Row(
          children: [
            Expanded(
              child: _buildCounterSection(
                title: "Event payment",
                icon: "assets/images/icons/dollar.png",
                value: eventPayment.toInt(),
                onDecrement: () {
                  setState(() {
                    eventPayment--;
                  });
                },
                onIncrement: () {
                  setState(() {
                    eventPayment++;
                  });
                },
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _buildCounterSection(
                title: "Availability",
                icon: "assets/images/icons/person.png",
                value: personsNumber,
                onDecrement: () {
                  setState(() {
                    personsNumber--;
                  });
                },
                onIncrement: () {
                  setState(() {
                    personsNumber++;
                  });
                },
              ),
            ),
          ],
        ),
      ),
      crossFadeState: selectedIndex == 0
          ? CrossFadeState.showSecond
          : CrossFadeState.showFirst,
      duration: const Duration(milliseconds: 200),
    );
  }

  @override
  Widget build(BuildContext context) {
    String month = convertMonthToText(month: eventDate?.month??0);
    return Scaffold(
        appBar: AppHeader(
          title: "Add Event",
          showBack: true,
        ),
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - kToolbarHeight - 100.h,
            ),
            child: Column(
              children: [
                AddNewHeader(
                  imageUrl: widget.imageUrl,
                  location: widget.location,
                  isEventPage: true,
                  onToggleChanged: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  selectedIndex: selectedIndex,
                ),
        
                SizedBox(height: 20.h),
        
                TextArea(
                  hintText: "Event title",
                  height: 55.h,
                ),
        
                SizedBox(height: 10.h),
        
                TextArea(
                  hintText: "Event details",
                  height: 135.h,
                ),
        
                SizedBox(height: 10.h),

                AddNewPostOptionTile(
                  icon: Image.asset("assets/images/icons/link.png"),
                  title: "Event Link",
                  showDivider: false,
                  showIcon: false,
                  onTap: () {}
                ),
        
                SizedBox(height: 10.h),

                AddNewPostOptionTile(
                  icon: Image.asset("assets/images/icons/gate.png"),
                  title: "Choose a gate",
                  showDivider: false,
                  onTap: (){}
                ),
        
                SizedBox(height: 10.h),

                AddNewPostOptionTile(
                  icon: Image.asset("assets/images/icons/hashtag.png"),
                  title: "Choose a type",
                  showDivider: false,
                  onTap: (){
                    context.push(
                      AppRoutes.addTypes,
                      extra: AddTypesArgs(
                          title: "Add Event",
                          isEvent: true,
                          selectedIndex: selectedIndex
                      ),
                    );
                  },
                ),
        
                SizedBox(height: 10.h),

                _buildDateSection(
                  title: "Event Date",
                  date: eventDate,
                  onTap: _pickEventDate,
                  text: eventDate != null
                      ? "${eventDate!.day} $month - "
                      "${eventDate!.hour.toString().padLeft(2, '0')}:"
                      "${eventDate!.minute.toString().padLeft(2, '0')}"
                      : "Select date",
                ),

                SizedBox(height: 10.h),

                _buildDateSection(
                  title: "Last time for subscription",
                  date: lastDate,
                  onTap: eventDate == null ? () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Select event date first")),
                    );
                  } : _pickLastDate,
                  text: lastDate != null
                      ? "${lastDate!.day} $month"
                      : "Select date",
                ),
        
                SizedBox(height: 10.h),

              _buildPaymentAndAvailability(),
        
                SizedBox(height: 10.h),

                selectedLocation == null
                    ? const Center(child: CircularProgressIndicator())
                    : AddNewBuildMap(
                  selectedLocation: selectedLocation!,
                  onLocationChanged: (newLocation) {
                    setState(() {
                      selectedLocation = newLocation;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),

        bottomNavigationBar: AddNewBottomBar(
            text: "Post Event",
            onTap: (){},
          showSwitch: true,
          switchTitle: "Subscribe in event",
          showTypes: true,
          items:  [
            PostTypeItem(
              title: "Add Photo",
              imageUrl: "assets/images/icons/image_icon.png",
              color: AppColors.turnbullBlue,
              onTap: () {},
            ),
            PostTypeItem(
              title: "Add Video",
              imageUrl: "assets/images/icons/video.png",
              color: AppColors.lebaneseRed,
              onTap: () {},
            ),
          ],
        )
    );
  }
}