import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:traveller/core/constants/post_service_provider_header/post_or_service_provider_header.dart';
import 'package:traveller/core/constants/service_provider/service_provider_bottom.dart';
import '../../theme/colors/app_colors.dart';

class ServiceProvider extends StatelessWidget{
  final PostHeaderData data;
  final String location;
  final String language;

  const ServiceProvider({
    super.key,
    required this.data,
    required this.location,
    required this.language,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: AppColors.turnbullBlue,
          borderRadius: BorderRadius.circular(10.r),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            PostOrServiceProviderHeader(
              data: data,
              onMoreTap: (){},
            ),
            ServiceProviderBottom(
              location: location,
              language: language,
            )
          ]
      ),
    );
  }
}