import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInMethod extends StatelessWidget {
  const SignInMethod({
    super.key,
    required this.text,
    required this.asset,
    this.onTap,
  });

  final String text;
  final String asset;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.lightgrey1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(asset),
            const SizedBox(width: 4),
            Text(
              text,
              style: TextStyles.caption1.copyWith(
                color: AppColors.darkgreycolor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
