import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderAvatar extends StatelessWidget {
  final String imageUrl;

  const HeaderAvatar({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22.r,
      backgroundImage: NetworkImage(imageUrl),
    );
  }
}
