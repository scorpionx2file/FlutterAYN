import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderAvatar extends StatelessWidget {
  final String imageUrl;
  final Function() onUserTap;


  const HeaderAvatar({
    super.key,
    required this.imageUrl, required this.onUserTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onUserTap();
        },
      child: CircleAvatar(
        radius: 22.r,
        backgroundImage: NetworkImage(imageUrl),
      ),
    );
  }
}
