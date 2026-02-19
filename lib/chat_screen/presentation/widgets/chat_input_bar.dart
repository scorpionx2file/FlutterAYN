import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:latlong2/latlong.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';
import 'package:traveller/core/theme/fonts/app_text_styles.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';

import '../../../core/utils/location/location_picker_bottom_sheet.dart';
import '../../../core/utils/location/location_service.dart';
import '../../../core/utils/media_picker/media_picker.dart';

enum MediaType { image, video }

class ChatInputBar extends StatefulWidget {
  final void Function(String) onSendMessage;
  final void Function(LatLng) onSendLocation;
  final void Function(File audio, int durationInSeconds)? onSendAudio;
  final void Function(File file, MediaType type)? onSendMedia;

  const ChatInputBar({
    super.key,
    required this.onSendMessage,
    required this.onSendLocation,
    this.onSendAudio,
    this.onSendMedia,
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

  void _openMediaPickerSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _mediaTile(
              icon: Icons.camera_alt,
              title: context.l10n.takePhoto,
              onTap: () async {
                Navigator.pop(context);
                final file = await MediaPicker.takePictureFromCamera();
                if (file != null)
                  widget.onSendMedia?.call(file, MediaType.image);
              },
            ),
            _mediaTile(
              icon: Icons.videocam,
              title: context.l10n.recordVideo,
              onTap: () async {
                Navigator.pop(context);
                final file = await MediaPicker.recordVideoFromCamera();
                if (file != null)
                  widget.onSendMedia?.call(file, MediaType.video);
              },
            ),
            _mediaTile(
              icon: Icons.photo,
              title: context.l10n.chooseImage,
              onTap: () async {
                Navigator.pop(context);
                final file = await MediaPicker.pickImage();
                if (file != null)
                  widget.onSendMedia?.call(file, MediaType.image);
              },
            ),
            _mediaTile(
              icon: Icons.video_library,
              title: context.l10n.chooseVideo,
              onTap: () async {
                Navigator.pop(context);
                final file = await MediaPicker.pickVideo();
                if (file != null)
                  widget.onSendMedia?.call(file, MediaType.video);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _mediaTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppColors.turnbullBlue),
      title: Text(title, style: AppTextStyles.description),
      onTap: onTap,
    );
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() => seconds++);
      _recordingOverlay?.markNeedsBuild();
    });
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
            ),
            duration: const Duration(milliseconds: 300),
            width: _recordingWidth(context),
            child: Row(
              children: [
                Text(
                  '${(seconds ~/ 60).toString().padLeft(2, '0')}:${(seconds % 60).toString().padLeft(2, '0')}',
                  style: const TextStyle(color: AppColors.white),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete, color: AppColors.white),
                  onPressed: () => _stopRecording(send: false),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: AppColors.white),
                  onPressed: () => _stopRecording(send: true),
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
  }

  Future<void> _stopRecording({bool send = false}) async {
    if (_recorder == null) return;

    await _recorder!.stopRecorder();
    final recordedDuration = seconds;
    _stopTimer();

    if (send && audioPath != null) {
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

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      height: 60.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
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
          IconButton(
            icon: Icon(
              Icons.camera_alt_outlined,
              size: 22.sp,
              color: AppColors.spanishGrey,
            ),
            onPressed: _openMediaPickerSheet,
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
          IconButton(
            icon: Icon(
              Icons.location_on_outlined,
              size: 22.sp,
              color: AppColors.spanishGrey,
            ),
            onPressed: () async {
              final currentLatLng = await LocationService.getCurrentLatLng();
              if (currentLatLng == null) return;

              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (_) => LocationPickerBottomSheet(
                  initialPosition: currentLatLng,
                  onSend: widget.onSendLocation,
                ),
              );
            },
          ),
          Expanded(
            child: TextField(
              controller: textController,
              onSubmitted: (_) => _sendMessage(),
              decoration: InputDecoration(
                hintText: "Write your message here",
                hintStyle: AppTextStyles.description.copyWith(
                  color: AppColors.spanishGrey,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
