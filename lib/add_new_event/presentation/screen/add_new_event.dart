import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:traveller/add_types/presentation/screen/add_types.dart';
import 'package:traveller/core/constants/add_new_bottom_bar/add_new_bottom_bar.dart';
import 'package:traveller/core/constants/event_data/event_data.dart';
import 'package:traveller/core/constants/post_types/post_types.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';
import 'package:flutter/services.dart';
import '../../../auth/presentation/screen/choose_gates_screen.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/constants/add_new_build_map/add_new_build_map.dart';
import '../../../core/constants/add_new_header/add_new_header.dart';
import '../../../core/constants/add_new_post_option_tile/add_new_post_option_tile.dart';
import '../../../core/constants/app_header/app_header.dart';
import '../../../core/constants/media_text_area/media_text_area.dart';
import '../../../core/constants/text_area/text_area.dart';
import '../../../core/theme/colors/app_colors.dart';
import '../../../core/utils/location/location_service.dart';
import '../../../core/utils/media_picker/media_picker.dart';

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
  bool subscribeInEvent = true;
  LatLng? selectedLocation;
  List<String> selectedTypes = [];
  String? eventLink;
  String? selectedGateName;
  bool showTitleError = false;
  bool showBodyError = false;
  bool showEventDateError = false;
  bool showLastDateError = false;
  final TextEditingController linkController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final TextEditingController paymentController = TextEditingController();
  final TextEditingController availabilityController = TextEditingController();
  final GlobalKey<MediaTextAreaState> mediaKey = GlobalKey<MediaTextAreaState>();

  @override
  void initState() {
    super.initState();
    _loadCurrentLocation();
    paymentController.text = eventPayment.toInt().toString();
    availabilityController.text = personsNumber.toString();
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
      1 => context.l10n.jan,
      2 => context.l10n.feb,
      3 => context.l10n.mar,
      4 => context.l10n.apr,
      5 => context.l10n.may,
      6 => context.l10n.jun,
      7 => context.l10n.jul,
      8 => context.l10n.aug,
      9 => context.l10n.sep,
      10 => context.l10n.oct,
      11 => context.l10n.nov,
      12 => context.l10n.dec,
      _ => context.l10n.invalidMonth,
    };
  }

  Widget _buildDateSection({
    required String title,
    required DateTime? date,
    required VoidCallback onTap,
    required String text,
    bool showError = false,
  }) {
    return EventData(
      title: title,
      icon: "assets/images/icons/calender.png",
      showError: showError,
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
    required TextEditingController controller,
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
            Icons.remove,
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
      child: SizedBox(
        width: 20.w,
        child: TextField(
          controller: controller,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.start,
          style: AppTextStyles.text,
          decoration: const InputDecoration(
            border: InputBorder.none,
            isDense: true,
          ),
          onChanged: (value) {
            final number = int.tryParse(value);
            if (number != null) {
              if (title == context.l10n.eventPayment) {
                eventPayment = number.toDouble();
              } else {
                personsNumber = number;
              }
            }
          },
        ),
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
              child:_buildCounterSection(
                title: context.l10n.eventPayment,
                icon: "assets/images/icons/dollar.png",
                controller: paymentController,
                onDecrement: () {
                  int current = int.tryParse(paymentController.text) ?? 0;
                  if (current > 0) current--;
                  paymentController.text = current.toString();
                  eventPayment = current.toDouble();
                },
                onIncrement: () {
                  int current = int.tryParse(paymentController.text) ?? 0;
                  current++;
                  paymentController.text = current.toString();
                  eventPayment = current.toDouble();
                },
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: _buildCounterSection(
                title: context.l10n.availability,
                icon: "assets/images/icons/person.png",
                controller: availabilityController,
                onDecrement: () {
                  int current = int.tryParse(availabilityController.text) ?? 0;
                  if (current > 0) current--;
                  availabilityController.text = current.toString();
                  personsNumber = current;
                },
                onIncrement: () {
                  int current = int.tryParse(availabilityController.text) ?? 0;
                  current++;
                  availabilityController.text = current.toString();
                  personsNumber = current;
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

  void _openLinkDialog() {
    linkController.text = eventLink ?? "";
    bool isValid = true;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            String? errorText = isValid ? null : "Invalid link";

            return AlertDialog(
              titlePadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
              actionsPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),

              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    context.l10n.eventLink,
                    style: AppTextStyles.titles.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  GestureDetector(
                    onTap: () => context.pop(),
                    child: IconButton(
                      onPressed: () => context.pop(),
                      icon: Icon(Icons.close),
                    )
                  ),
                ],
              ),

              content: TextField(
                controller: linkController,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  hintText: "https://example.com",
                  errorText: errorText,
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: isValid
                          ? AppColors.spanishGrey
                          : AppColors.lebaneseRed,
                    ),
                  ),
                ),
                onChanged: (_) {
                  if (!isValid) setStateDialog(() => isValid = true);
                },
              ),

              actions: [
                ElevatedButton(
                  onPressed: () {
                    final text = linkController.text.trim();

                    final urlPattern =
                        r'^(https?:\/\/)?([\w\-]+\.)+[\w]{2,}(\/\S*)?$';
                    final isUrlValid = RegExp(urlPattern).hasMatch(text);

                    if (text.isEmpty || !isUrlValid) {
                      setStateDialog(() => isValid = false);
                      return;
                    }

                    setState(() {
                      eventLink = text;
                    });

                    context.pop();
                  },
                  child: Text(context.l10n.save),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String month = convertMonthToText(month: eventDate?.month??0);
    return Scaffold(
        appBar: AppHeader(
          title: context.l10n.addEvent,
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
                  hintText: context.l10n.eventTitle,
                  height: 55.h,
                  controller: titleController,
                  showError: showTitleError,
                  errorText: "Field required",
                ),
        
                SizedBox(height: 10.h),

                MediaTextArea(
                  key: mediaKey,
                  hintText: context.l10n.eventDetails,
                  height: 135.h,
                  controller: bodyController,
                ),
        
                SizedBox(height: 10.h),

                AddNewPostOptionTile(
                  icon: Image.asset("assets/images/icons/link.png"),
                  title: eventLink == null
                      ? context.l10n.eventLink
                      : eventLink!,
                  showDivider: false,
                  showIcon: false,
                  onTap: _openLinkDialog,
                ),

                SizedBox(height: 10.h),

                AddNewPostOptionTile(
                  icon: Image.asset("assets/images/icons/gate.png"),
                  title: selectedGateName ?? context.l10n.chooseAGate,
                  showDivider: false,
                  onTap: () async {
                    final result = await context.push<GateItem>(
                      AppRoutes.chooseGates,
                      extra: {
                        'allowMultiple': false,
                        'title': context.l10n.addEvent,
                      },
                    );

                    if (result != null) {
                      setState(() {
                        selectedGateName = result.title;
                      });
                    }
                  },
                ),
        
                SizedBox(height: 10.h),

                AddNewPostOptionTile(
                  icon: Image.asset("assets/images/icons/hashtag.png"),
                  title: selectedTypes.isEmpty
                      ? context.l10n.chooseAType
                      : selectedTypes.join(", "),
                  showDivider: false,
                  onTap: () async {
                    final result = await context.push(
                      AppRoutes.addTypes,
                      extra: AddTypesArgs(
                        title: context.l10n.addEvent,
                        isEvent: true,
                        selectedIndex: selectedIndex,
                      ),
                    );

                    if (result != null && result is List<String>) {
                      setState(() {
                        selectedTypes = result;
                      });
                    }
                  },
                ),


                SizedBox(height: 10.h),

                _buildDateSection(
                    title: context.l10n.eventDate,
                    date: eventDate,
                    onTap: _pickEventDate,
                    text: eventDate != null
                      ? "${eventDate!.day} $month - "
                      "${eventDate!.hour.toString().padLeft(2, '0')}:"
                      "${eventDate!.minute.toString().padLeft(2, '0')}"
                      : context.l10n.selectDate,
                    showError: showEventDateError
                ),

                SizedBox(height: 10.h),

                if (subscribeInEvent)
                  _buildDateSection(
                    title: context.l10n.lastTimeForSubscription,
                    date: lastDate,
                    onTap: eventDate == null
                        ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(context.l10n.selectEventDateFirst)),
                      );
                    }
                        : _pickLastDate,
                    text: lastDate != null
                        ? "${lastDate!.day} $month"
                        : context.l10n.selectDate,
                    showError: showLastDateError,
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
          text: context.l10n.postEvent,
          onTap: (){
            final title = titleController.text.trim();
            setState(() {
              showTitleError = title.isEmpty;
              showEventDateError = eventDate == null;
              showLastDateError =
                  subscribeInEvent && lastDate == null;
            });
            if (title.isEmpty) return;

            if (eventDate == null) return;

            if (subscribeInEvent && lastDate == null) return;
          },
          showSwitch: true,
          switchTitle: context.l10n.subscribeInEvent,
          switchValue: subscribeInEvent,
          onSwitchChanged: (value){
              setState(() {
                subscribeInEvent = value;
              });
          },
          showTypes: true,
          items:  [
            PostTypeItem(
              title: context.l10n.addEvent,
              imageUrl: "assets/images/icons/image_icon.png",
              color: AppColors.turnbullBlue,
              onTap: () async {
                bool granted = await MediaPicker.requestPermissions();
                if (!granted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(context.l10n.permissionDeniedPleaseEnableInSettings)),
                  );
                  return;
                }

                final file = await MediaPicker.pickImage();
                if (file != null) mediaKey.currentState?.addMedia(file);
              },
            ),
            PostTypeItem(
              title: context.l10n.addVideo,
              imageUrl: "assets/images/icons/video.png",
              color: AppColors.lebaneseRed,
              onTap: () async {
                bool granted = await MediaPicker.requestPermissions();
                if (!granted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(context.l10n.permissionDeniedPleaseEnableInSettings)),
                  );
                  return;
                }

                final file = await MediaPicker.pickVideo();
                if (file != null) mediaKey.currentState?.addMedia(file);
              },
            ),
          ],
        )
    );
  }
}