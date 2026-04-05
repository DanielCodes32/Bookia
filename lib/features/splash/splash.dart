import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    bool isloggedin = SharedPref.gettoken().isNotEmpty ? true : false;
    Future.delayed(const Duration(seconds: 3), () {
      // pushReplacement(context, isloggedin ? Routes.mainappscreen : Routes.welcome);
      pushReplacement(context, Routes.welcome);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.splash),
            Gap(9),
            Text("Order Your Book Now!", style: TextStyles.title),
          ],
        ),
      ),
    );
  }
}
