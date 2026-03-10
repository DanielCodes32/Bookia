import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_form_field.dart';
import 'package:bookia/core/widgets/custom_password_field.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/mybodyview.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            pop(context);
          },
          child: SvgPic(assetName: AppAssets.back),
        ),
      ),
      body: MyBodyView(
        padding: const EdgeInsets.all(22),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                "Hello! Register to get started",
                style: TextStyles.headline,
              ),
              Gap(32),
              CustomFormField(hintText: 'Username'),
              Gap(11),
              CustomFormField(hintText: 'Email',keyboardtype: 1,),
              Gap(13),
              CustomPassField(hintText: 'Password'),
              Gap(12),
               CustomPassField(hintText: 'Confirm password'),

              Gap(30),
              MainButton(title: 'Register', onTap: () {}),
             ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account? ",
            style: TextStyles.caption1.copyWith(color: AppColors.blackColor),
          ),
          TextButton(
            onPressed: () {},
            style: ButtonStyle(
              padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
            ),
            child: Text(
              "Login Now",
              style: TextStyles.caption1.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
