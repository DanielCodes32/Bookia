import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/custom_snake_bar.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/routes/app_router.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/mybodyview.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:pinput/pinput.dart';

class VerficationScreen extends StatelessWidget {
  const VerficationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          pushTo(context, Routes.newpass);
        }
        if (state is AuthErrorState) {
          errordiag(context, "Something went wrong please try again");

          pop(context);
        }
        if (state is AuthLoadingState) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: GestureDetector(
            onTap: () {
              pop(context);
            },
            child: SvgPic(assetName: AppAssets.back, width: 41, height: 41),
          ),
        ),
        body: MyBodyView(
          padding: const EdgeInsets.all(22),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("OTP Verification", style: TextStyles.headline),
                Gap(10),
                Text(
                  "Enter the verification code we just sent on your email address.",
                  style: TextStyles.caption1,
                ),
                Gap(35),
                Padding(
                  padding: const EdgeInsets.all(5),
                  child: Pinput(
                    controller: cubit.otpController,
                    length: 6,
                    defaultPinTheme: PinTheme(
                      width: 48,
                      height: 60,
                      textStyle: TextStyles.headline,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                    ),
                  ),
                ),
                Gap(30),
                MainButton(
                  title: 'Verify',
                  onTap: () {
                    if (cubit.otpController.text.isEmpty) {
                      errordiag(context, "Please enter OTP");
                    } else if (cubit.otpController.text.length < 6) {
                      errordiag(context, "Please enter valid OTP");
                    } else {
                      cubit.verfiy();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Remember Password?",
              style: TextStyles.caption1.copyWith(color: AppColors.blackColor),
            ),
            TextButton(
              onPressed: () {
                pushTo(context, Routes.login);
              },
              style: ButtonStyle(
                padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
              ),
              child: Text(
                "Login",
                style: TextStyles.caption1.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
