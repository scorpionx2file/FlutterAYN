import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/theme/colors/app_colors.dart';

import '../../../core/constants/chat_screen/chat_message_bubble.dart';
import '../../../core/theme/fonts/app_text_styles.dart';
import 'chat_input_bar.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

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
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                /// ================= DATE =================
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

                /// ================= MESSAGES =================
                SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(height: 16.h),

                    ChatMessageBubble(
                      message: 'مرحبا أهلا بك في التطبيق',
                      isMe: false,
                      avatarUrl: 'https://i.pravatar.cc/150?img=5',
                      time: '16 min ago',
                    ),

                    ChatMessageBubble(
                      message: 'Sweet, Welcome !! 😊',
                      isMe: true,
                      avatarUrl: 'https://i.pravatar.cc/150?img=12',
                      time: '15 min ago',
                    ),

                    ChatMessageBubble(
                      message: 'I was Reading your profile, Interest',
                      isMe: false,
                      avatarUrl: 'https://i.pravatar.cc/150?img=5',
                      time: '16 min ago',
                    ),

                    ChatMessageBubble(
                      message:
                          'هناك حقيقة مثبتة منذ زمن طويل وهي أن المحتوى المقروء 😍',
                      isMe: false,
                      avatarUrl: 'https://i.pravatar.cc/150?img=5',
                      time: '16 min ago',
                    ),

                    SizedBox(height: 12.h),

                    /// Typing indicator
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        'Typing ...',
                        style: AppTextStyles.description.copyWith(
                          color: AppColors.spanishGrey,
                        ),
                      ),
                    ),

                    /// Space so input doesn't overlap
                    SizedBox(height: 90.h),
                  ]),
                ),
              ],
            ),
          ),

          /// ================= CHAT INPUT BAR =================
          ChatInputBar(onSendMessage: (String message) {  },),
        ],
      ),
    );
  }
}
