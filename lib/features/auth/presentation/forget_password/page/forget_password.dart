import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/custom_snake_bar.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/functions/validation.dart';
import 'package:bookia/core/routes/app_router.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_form_field.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/mybodyview.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ForgetPassword extends StatelessWidget {
  const ForgetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit =context.read<AuthCubit>();
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          pushTo(context, Routes.verification);
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
      child:Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            pop(context);
          },
          child: SvgPic(assetName: AppAssets.back, width: 41, height: 41),
        ),
      ),
      body: Form(
        key: cubit.formKey,
        child: MyBodyView(
          padding: const EdgeInsets.all(22),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Forgot Password?", style: TextStyles.headline),
                Gap(10),
                Text(
                  "Don't worry! It occurs. Please enter the email address linked with your account.",
                  style: TextStyles.caption1,
                ),
                Gap(32),
                CustomFormField(hintText: 'Enter your email',keyboardtype: 1,controller:cubit.emailController ,validator: (value) {
                   if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!isEmailValid(value)) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                  
                ),
            
                Gap(38),
                MainButton(
                  title: 'Send Code',
                  onTap: () {
                    if (cubit.formKey.currentState!.validate()) {
                      cubit.forgetpass();
                    }
                    
                  },
                ),
              ],
            ),
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
