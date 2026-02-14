import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:traveller/core/constants/event_data/event_data.dart';
import 'package:traveller/core/constants/post_types/post_types.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';

import '../../../core/constants/add_new_header/add_new_header.dart';
import '../../../core/constants/app_header/app_header.dart';
import '../../../core/constants/button/app_button.dart';
import '../../../core/constants/option_switch/option_switch.dart';
import '../../../core/constants/profile_settings/profile_settings_tile.dart';
import '../../../core/constants/text_area/text_area.dart';
import '../../../core/theme/colors/app_colors.dart';

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
  LatLng selectedLocation = LatLng(50.0, 10.0);
  int selectedIndex = 1;
  DateTime? eventDate;
  DateTime? lastDate;
  double eventPayment = 120;
  int personsNumber = 150;

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
        
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: ProfileSettingsTile(
                    icon: Image.asset("assets/images/icons/link.png"),
                    title: "Event Link",
                    showDivider: false,
                    showIcon: false,
                  ),
                ),
        
                SizedBox(height: 10.h),
        
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: ProfileSettingsTile(
                    icon: Image.asset("assets/images/icons/gate.png"),
                    title: "Choose a gate",
                    showDivider: false,
                  ),
                ),
        
                SizedBox(height: 10.h),
        
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: ProfileSettingsTile(
                    icon: Image.asset("assets/images/icons/hashtag.png"),
                    title: "Choose a type",
                    showDivider: false,
                  ),
                ),
        
                SizedBox(height: 10.h),
        
                EventData(
                  title: "Event Date",
                  icon: "assets/images/icons/calender.png",
                  child: GestureDetector(
                    onTap: () async {
                      // 1. Pick date
                      DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: eventDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );

                      if (pickedDate == null) return;

                      // 2. Pick time
                      TimeOfDay? pickedTime = await showTimePicker(
                        initialTime: TimeOfDay.now(),
                        context: context,
                      );

                      if (pickedTime == null) return;

                      // 3. Combine date + time
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
                    },

                    child: Text(
                      eventDate != null
                          ? "${eventDate!.day} $month - "
                          "${eventDate!.hour.toString().padLeft(2, '0')}:"
                          "${eventDate!.minute.toString().padLeft(2, '0')}"
                          : "Select date",
                      style: TextStyle(
                        color: eventDate != null ? Colors.black : AppColors.spanishGrey,
                      ),
                    ),
                  ),
                ),
        
                SizedBox(height: 10.h),
        
                EventData(
                  title: "Last time for subscription",
                  icon: "assets/images/icons/calender.png",
                  child: GestureDetector(
                    onTap: () async {
                      DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: lastDate ?? DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) {
                        setState(() {
                          lastDate = picked;
                        });
                      }
                    },
                    child: Text(
                      lastDate != null
                          ? "${lastDate!.day} $month"
                          : "Select date",
                      style: TextStyle(
                        color: lastDate != null ? Colors.black : AppColors.spanishGrey,
                      ),
                    ),
                  ),
                ),
        
                SizedBox(height: 10.h),
        
                AnimatedCrossFade(
                    firstChild: SizedBox.shrink(),
                    secondChild: SizedBox(
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: EventData(
                              title: "Event payment",
                              icon: "assets/images/icons/dollar.png",
                              trailing: [
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      eventPayment--;
                                    });
                                  },
                                  child: Icon(
                                      Icons.minimize,
                                    color: AppColors.spanishGrey,
                                    size: 20.sp,
                                  ),
                                ),

                                SizedBox(width: 10.w),

                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      eventPayment++;
                                    });
                                  },
                                  child: Icon(
                                      Icons.add,
                                    color: AppColors.spanishGrey,
                                    size: 20.sp,
                                  ),
                                )
                              ],
                              child: Text(
                                "$eventPayment\$",
                                style: AppTextStyles.text,
                              )
                                                  ),
                          ),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: EventData(
                              title: "Availability",
                              icon: "assets/images/icons/person.png",
                              trailing: [
                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      personsNumber--;
                                    });
                                  },
                                  child: Icon(
                                    Icons.minimize,
                                    color: AppColors.spanishGrey,
                                    size: 20.sp,
                                  ),
                                ),

                                GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      personsNumber++;
                                    });
                                  },
                                  child: Icon(
                                    Icons.add,
                                    color: AppColors.spanishGrey,
                                    size: 20.sp,
                                  ),
                                )
                              ],
                              child: Text(
                                "$personsNumber\$",
                                style: AppTextStyles.text,
                              )
                                                  ),
                          )],
                      ),
                    ),
                  crossFadeState: selectedIndex == 0
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 200),
                ),
        
                SizedBox(height: 10.h),
        
                Container(
                  height: 135.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: AppColors.white,
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter: selectedLocation,
                          initialZoom: 5,
                          onTap: (tapPosition, point) {
                            setState(() {
                              selectedLocation = point;
                            });
                          },
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                            'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png',
                            subdomains: ['a', 'b', 'c', 'd'],
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                point: selectedLocation,
                                width: 40,
                                height: 40,
                                alignment: Alignment.topCenter,
                                child: Icon(
                                  Icons.location_pin,
                                  color: AppColors.turnbullBlue,
                                  size: 40,
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
            top: 12,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _AddMedia(),
              SizedBox(height: 16.h),
              OptionSwitch(
                title: 'Subscribe in event',
                value: true,
                onChanged: (bool value) {  },
              ),
              SizedBox(height: 16.h),
              AppButton(
                text: "Post Event",
                icon: Icon(
                  Icons.videocam,
                  color: AppColors.white,
                ),
                onPressed: () {},
              ),
            ],
          ),
        )
    );
  }
}

class _AddMedia extends StatelessWidget{
  const _AddMedia({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PostTypes(
            title: "Add Photo",
            imageUrl: "assets/images/icons/image_icon.png",
            color: AppColors.turnbullBlue,
            onTap: (){}
        ),

        SizedBox(width: 35.w),

        PostTypes(
            title: "Add Video",
            imageUrl: "assets/images/icons/video.png",
            color: AppColors.lebaneseRed,
            onTap: (){}
        )
      ],
    );
  }
}