import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:traveller/add_new_topic/presentation/screen/poll_preview.dart';
import 'package:traveller/core/constants/app_header/app_header.dart';
import 'package:traveller/core/constants/text_area/text_area.dart';
import 'package:traveller/core/utils/extensions/build_context_extensions.dart';
import '../../../add_types/presentation/screen/add_types.dart';
import '../../../auth/presentation/screen/choose_gates_screen.dart';
import '../../../config/routes/app_routes.dart';
import '../../../core/constants/add_new_bottom_bar/add_new_bottom_bar.dart';
import '../../../core/constants/add_new_header/add_new_header.dart';
import '../../../core/constants/add_new_post_option_tile/add_new_post_option_tile.dart';
import '../../../core/constants/media_text_area/media_text_area.dart';
import '../../../core/constants/post_types/post_types.dart';
import '../../../core/theme/colors/app_colors.dart';
import '../../../core/utils/map_keys/map_keys.dart';
import '../../../core/utils/media_picker/media_picker.dart';

class AddNewTopic extends StatefulWidget {
  final String imageUrl;
  final String location;

  const AddNewTopic({
    super.key,
    required this.imageUrl,
    required this.location
  });

  @override
  State<AddNewTopic> createState() => _AddNewTopicState();
}

class _AddNewTopicState extends State<AddNewTopic> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController bodyController = TextEditingController();
  final GlobalKey<MediaTextAreaState> mediaKey = GlobalKey<MediaTextAreaState>();
  List<String> selectedTypes = [];
  String? selectedGateName;
  PollData? createdPoll;
  bool showTitleError = false;
  bool showBodyError = false;

  bool get _hasUnsavedData {
    return titleController.text.trim().isNotEmpty ||
        bodyController.text.trim().isNotEmpty ||
        selectedTypes.isNotEmpty ||
        selectedGateName != null ||
        createdPoll != null ||
        (mediaKey.currentState?.hasMedia ?? false);
  }

  Future<bool> _showDiscardDialog() async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(context.l10n.discardChanges),
          content:  Text(
            context.l10n.checkDiscard,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(context.l10n.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                context.l10n.discard,
                style: TextStyle(color: AppColors.lebaneseRed),
              ),
            ),
          ],
        );
      },
    );

    return result ?? false;
  }

  Future<void> _handleBack() async {
    if (_hasUnsavedData) {
      final shouldDiscard = await _showDiscardDialog();
      if (shouldDiscard && mounted) {
        context.pop();
      }
    } else {
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;

        if (_hasUnsavedData) {
          final shouldDiscard = await _showDiscardDialog();
          if (shouldDiscard && mounted) {
            context.pop();
          }
        } else {
          context.pop();
        }
      },
      child: Scaffold(
        appBar: AppHeader(
          title: context.l10n.addTopic,
          showBack: true,
          onBack: _handleBack,
        ),
        resizeToAvoidBottomInset: true,
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              AddNewHeader(
                imageUrl: widget.imageUrl,
                location: widget.location,
                isEventPage: false,
              ),
              SizedBox(height: 20.h),
              TextArea(
                hintText: context.l10n.topicTitle,
                height: 55.h,
                controller: titleController,
                showError: showTitleError,
                errorText: context.l10n.fieldRequired,
              ),
              SizedBox(height: 10.h),
              MediaTextArea(
                key: mediaKey,
                hintText: context.l10n.topicDetails,
                height: 135.h,
                controller: bodyController,
                showError: showBodyError,
                errorText: context.l10n.fieldRequired,
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
                      MapKeys.allowMultiple: false,
                      MapKeys.title: context.l10n.addVideo,
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
                      title: context.l10n.addTopic,
                      isEvent: false,
                      selectedIndex: 0,
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
      
              if (createdPoll != null)
                PollPreview(
                  question: createdPoll!.question,
                  options: createdPoll!.options,
                  onEdit: () async {
                    final edited = await context.push<PollData>(
                      AppRoutes.addPoll,
                      extra: createdPoll,
                    );
                    if (edited != null) {
                      setState(() {
                        createdPoll = edited;
                      });
                    }
                  },
                  onDelete: () {
                    setState(() {
                      createdPoll = null;
                    });
                  },
                ),
            ],
          ),
        ),
        bottomNavigationBar: AddNewBottomBar(
          text: context.l10n.postTopic,
            onTap: () {
              final title = titleController.text.trim();
              final body = bodyController.text.trim();
      
              setState(() {
                showTitleError = title.isEmpty;
                showBodyError = body.isEmpty;
              });
      
              if (title.isEmpty || body.isEmpty) {
                return;
              }
      
              final wordCount =
                  body.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).length;
      
              if (wordCount < 20) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(context.l10n.postDetailsLimitation)),
                );
                return;
              }
          },
          showTypes: true,
          items: [
            PostTypeItem(
              title: context.l10n.addPhoto,
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
      
            PostTypeItem(
              title: context.l10n.poll,
              imageUrl: "assets/images/icons/poll.png",
              color: AppColors.darkYellow,
              onTap: () async {
                final result = await context.push<PollData>(AppRoutes.addPoll);
                if (result != null) {
                  setState(() {
                    createdPoll = result;
                  });
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}