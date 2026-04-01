import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/routes/app_router.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:bookia/core/functions/navigations.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppAssets.welcome,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
            child: Column(
              children: [
                Spacer(flex: 2),
                Image.asset(AppAssets.splash),
                const Gap(24),
                Text("Order Your Book Now!", style: TextStyles.title),
                Spacer(flex: 5),
                MainButton(
                  title: "Login",
                  onTap: () {
                    pushTo(context, Routes.login);
                  },
                ),
                Gap(15),
                MainButton(
                  title: "Register",
                  onTap: () {
                    pushTo(context, Routes.register);
                  },
                  bordercolor: AppColors.blackColor,
                  bgcolor: AppColors.backgroundColor,
                  textcolor: AppColors.blackColor,
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
