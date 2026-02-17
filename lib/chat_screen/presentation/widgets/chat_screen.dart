import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import '../../../core/constants/chat_screen/chat_message_bubble.dart';
import '../../../core/theme/colors/app_colors.dart';
import '../../../core/theme/fonts/app_text_styles.dart';
import '../../../core/utils/location/location_picker_bottom_sheet.dart';
import 'chat_input_bar.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<Map<String, dynamic>> messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    // Pre-fill all 4 static messages
    messages.addAll([
      {
        'message': 'مرحبا أهلا بك في التطبيق',
        'isMe': false,
        'avatarUrl': 'https://i.pravatar.cc/150?img=5',
        'time': '16 min ago',
      },
      {
        'message': 'Sweet, Welcome !! 😊',
        'isMe': true,
        'avatarUrl': 'https://i.pravatar.cc/150?img=12',
        'time': '15 min ago',
      },
      {
        'message': 'I was Reading your profile, Interest',
        'isMe': false,
        'avatarUrl': 'https://i.pravatar.cc/150?img=5',
        'time': '16 min ago',
      },
      {
        'message':
        'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء 😍',
        'isMe': false,
        'avatarUrl': 'https://i.pravatar.cc/150?img=5',
        'time': '16 min ago',
      },
    ]);
  }

  void _sendMessage(String text) {
    setState(() {
      messages.add({
        'message': text,
        'isMe': true,
        'avatarUrl': 'https://i.pravatar.cc/150?img=12',
        'time': 'now',
      });
    });
    _scrollToBottom();
  }

  void _sendLocation(LatLng location) {
    setState(() {
      messages.add({
        'location': location,
        'isMe': true,
        'avatarUrl': 'https://i.pravatar.cc/150?img=12',
        'time': 'now',
      });
    });
    _scrollToBottom();
  }

  void _sendAudio(File file) {
    setState(() {
      messages.add({
        'audioFile': file,
        'isMe': true,
        'avatarUrl': 'https://i.pravatar.cc/150?img=12',
        'time': 'now',
      });
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<Position?> requestLocationPermission() async {
    if (!await Geolocator.isLocationServiceEnabled()) return null;

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) return null;
    }

    if (permission == LocationPermission.deniedForever) return null;

    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Adham Mohamed',
          style: AppTextStyles.titles.copyWith(fontWeight: FontWeight.bold),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Icon(Icons.more_horiz, color: AppColors.spanishGrey),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      '8, July 2020 at 3:32 am',
                      style: AppTextStyles.description.copyWith(
                        color: AppColors.spanishGrey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                        (context, index) {
                      final msg = messages[index];
                      return ChatMessageBubble(
                        message: msg['message'],
                        location: msg['location'],
                        audioFile: msg['audioFile'],
                        isMe: msg['isMe'],
                        avatarUrl: msg['avatarUrl'],
                        time: msg['time'],
                      );
                    },
                    childCount: messages.length,
                  ),
                ),
                SliverToBoxAdapter(
                  child: SizedBox(height: 90.h),
                ),
              ],
            ),
          ),
          ChatInputBar(
            onSendMessage: _sendMessage,
            onSendLocation: _sendLocation,
            onSendAudio: _sendAudio,
          ),
        ],
      ),
    );
  }
}
