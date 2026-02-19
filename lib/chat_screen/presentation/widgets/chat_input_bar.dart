import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../../core/utils/location/location_picker_bottom_sheet.dart';
import '../../../core/utils/location/location_service.dart';

class ChatInputBar extends StatefulWidget {
  final void Function(String) onSendMessage;
  final void Function(LatLng) onSendLocation;
  final void Function(File audio, int durationInSeconds)? onSendAudio;

  const ChatInputBar({
    super.key,
    required this.onSendMessage,
    required this.onSendLocation,
    this.onSendAudio,
  });

  @override
  State<ChatInputBar> createState() => _ChatInputBarState();
}

class _ChatInputBarState extends State<ChatInputBar> {
  final TextEditingController textController = TextEditingController();
  bool isTextEmpty = true;

  FlutterSoundRecorder? _recorder;
  bool isRecording = false;
  bool isPaused = false;
  String? audioPath;
  int seconds = 0;
  Timer? _timer;
  OverlayEntry? _recordingOverlay;

  double _recordingWidth(BuildContext context) {
    final minWidth = 140.w;
    final maxWidth = MediaQuery.of(context).size.width - 32.w;

    final extra = seconds * 6.w;
    final width = minWidth + extra;

    return width.clamp(minWidth, maxWidth);
  }

  @override
  void initState() {
    super.initState();
    textController.addListener(() {
      setState(() => isTextEmpty = textController.text.trim().isEmpty);
    });
    _initRecorder();
  }

  Future<void> _initRecorder() async {
    _recorder = FlutterSoundRecorder();
    await _recorder!.openRecorder();
  }

  @override
  void dispose() {
    textController.dispose();
    _recorder?.closeRecorder();
    _timer?.cancel();
    _hideRecordingOverlay();
    super.dispose();
  }

  void _sendMessage() {
    final text = textController.text.trim();
    if (text.isEmpty) return;
    widget.onSendMessage(text);
    textController.clear();
    setState(() => isTextEmpty = true);
  }

  void _startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (_) {
        setState(() => seconds++);
        _recordingOverlay?.markNeedsBuild();
      },
    );
  }


  void _stopTimer() {
    _timer?.cancel();
    seconds = 0;
  }

  void _showRecordingOverlay() {
    if (_recordingOverlay != null) return;

    _recordingOverlay = OverlayEntry(
      builder: (context) => Positioned(
        bottom: MediaQuery.of(context).viewInsets.bottom + 70.h,
        left: 16.w,
        right: 16.w,
        child: Material(
          color: Colors.transparent,
          child: AnimatedContainer(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.turnbullBlue, AppColors.turnbullBlue],
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            duration: const Duration(milliseconds: 300),
            width: _recordingWidth(context),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Circular timer
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: AppColors.spanishGrey.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${(seconds ~/ 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}',
                    style: TextStyle(
                      color: AppColors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),

                // Pulsing mic
                SizedBox(
                  width: 40.w,
                  height: 40.w,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (isRecording && !isPaused)
                        TweenAnimationBuilder<double>(
                          tween: Tween(begin: 0.7, end: 1.3),
                          duration: const Duration(seconds: 1),
                          curve: Curves.easeInOut,
                          builder: (context, scale, child) {
                            return Transform.scale(
                              scale: scale,
                              child: Container(
                                width: 36.w,
                                height: 36.w,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.turnbullBlue.withOpacity(
                                    0.3,
                                  ),
                                ),
                              ),
                            );
                          },
                          onEnd: () {
                            if (isRecording && !isPaused)
                              _recordingOverlay?.markNeedsBuild();
                          },
                        ),
                      Icon(
                        isPaused ? Icons.mic_off : Icons.mic,
                        color: AppColors.white,
                        size: 26.sp,
                      ),
                    ],
                  ),
                ),

                const Spacer(),
                Row(
                  children: [
                    // Delete button
                    IconButton(
                      padding: EdgeInsets.zero,
                      iconSize: 22.sp,
                      icon: const Icon(Icons.delete, color: AppColors.white),
                      onPressed: () => _stopRecording(send: false),
                    ),
                    SizedBox(width: 8.w),
                    // Send button
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.turnbullBlue,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 22.sp,
                        icon: const Icon(Icons.send, color: AppColors.white),
                        onPressed: () => _stopRecording(send: true),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );

    Overlay.of(context)!.insert(_recordingOverlay!);
  }

  void _hideRecordingOverlay() {
    _recordingOverlay?.remove();
    _recordingOverlay = null;
  }

  Future<void> _startRecording() async {
    final status = await Permission.microphone.request();
    if (!status.isGranted) return;

    if (_recorder == null) await _initRecorder();

    final dir = await getTemporaryDirectory();
    audioPath = '${dir.path}/${DateTime.now().millisecondsSinceEpoch}.aac';

    await _recorder!.startRecorder(
      toFile: audioPath,
      codec: Codec.aacADTS,
      sampleRate: 16000,
      bitRate: 32000,
    );

    setState(() {
      isRecording = true;
      isPaused = false;
    });

    _startTimer();
    _showRecordingOverlay();
  }

  Future<void> _pauseRecording() async {
    if (_recorder == null || !_recorder!.isRecording) return;
    await _recorder!.pauseRecorder();
    _stopTimer();
    setState(() => isPaused = true);
  }

  Future<void> _resumeRecording() async {
    if (_recorder == null) return;
    await _recorder!.resumeRecorder();
    _startTimer();
    setState(() => isPaused = false);
    _recordingOverlay?.markNeedsBuild();
  }

  Future<void> _stopRecording({bool send = false}) async {
    if (_recorder == null) return;

    await _recorder!.stopRecorder();
    final recordedDuration = seconds;
    _stopTimer();

    if (send && audioPath != null) {
      // Pass duration to parent callback
      widget.onSendAudio?.call(File(audioPath!), recordedDuration);
    } else if (audioPath != null) {
      File(audioPath!).deleteSync();
    }

    audioPath = null;
    setState(() {
      isRecording = false;
      isPaused = false;
    });

    _hideRecordingOverlay();
  }

  Future<Position?> _requestLocationPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) return null;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }
    if (permission == LocationPermission.deniedForever) return null;

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      height: 60.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            icon: Icon(
              Icons.send,
              size: 22.sp,
              color: isTextEmpty
                  ? AppColors.spanishGrey
                  : AppColors.turnbullBlue,
            ),
            onPressed: isTextEmpty ? null : _sendMessage,
          ),
          Container(
            width: 1.w,
            height: 28.h,
            color: AppColors.spanishGrey.withOpacity(0.4),
          ),
          IconButton(
            icon: Icon(
              Icons.camera_alt_outlined,
              size: 22.sp,
              color: AppColors.spanishGrey,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              isRecording
                  ? (isPaused ? Icons.mic_none : Icons.pause)
                  : Icons.mic_none_outlined,
              size: 22.sp,
              color: AppColors.spanishGrey,
            ),
            onPressed: () async {
              if (!isRecording)
                await _startRecording();
              else if (!isPaused)
                await _pauseRecording();
              else
                await _resumeRecording();
            },
          ),

          // LOCATION
          IconButton(
            icon: Icon(
              Icons.location_on_outlined,
              size: 22.sp,
              color: AppColors.spanishGrey,
            ),
            onPressed: () async {
              final currentLatLng = await LocationService.getCurrentLatLng();

              if (currentLatLng == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Location permission denied")),
                );
                return;
              }
              final pos = await _requestLocationPermission();
              if (pos == null) return;

              final initialLatLng = LatLng(pos.latitude, pos.longitude);
              if (!context.mounted) return;

              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (_) => LocationPickerBottomSheet(
                  initialPosition: initialLatLng,
                  onSend: widget.onSendLocation,
                ),
              );
            },
          ),
          Expanded(
            child: TextField(
              controller: textController,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _sendMessage(),
              decoration: InputDecoration(
                hintText: "Write your message here",
                hintStyle: AppTextStyles.description.copyWith(
                  color: AppColors.spanishGrey,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 4.w),
              ),
            ),
          ),
        ],
      ),
    );
  }
}