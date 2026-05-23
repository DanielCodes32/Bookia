import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/mybodyview.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class OrderPlaced extends StatelessWidget {
  const OrderPlaced({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MyBodyView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(AppAssets.successmark, width: 100, height: 100),
              Gap(35),
              Text("SUCCESS!", style: TextStyles.headline),
              Gap(5),
              Text(
                "Your order will be delivered soon. \nThank you for choosing our app!",
                style: TextStyles.caption1,
                textAlign: TextAlign.center,
              ),
              Gap(40),
              MainButton(
                title: 'Back To Home',
                onTap: () {
                  pushToBase(context, Routes.mainappscreen, extra: 0);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
