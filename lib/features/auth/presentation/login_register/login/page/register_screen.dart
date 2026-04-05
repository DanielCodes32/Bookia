import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/custom_snake_bar.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/functions/validation.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_form_field.dart';
import 'package:bookia/core/widgets/custom_password_field.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/mybodyview.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    String pass = "";
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          pushToBase(context, Routes.mainappscreen);
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
            child: SvgPic(assetName: AppAssets.back),
          ),
        ),
        body: MyBodyView(
          padding: const EdgeInsets.all(22),
          child: SingleChildScrollView(
            child: Form(
              key: cubit.formKey,
              autovalidateMode: AutovalidateMode.onUnfocus,
              child: Column(
                children: [
                  Text(
                    "Hello! Register to get started",
                    style: TextStyles.headline,
                  ),
                  Gap(32),
                  CustomFormField(
                    hintText: 'Username',
                    controller: cubit.usernameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  Gap(11),
                  CustomFormField(
                    hintText: 'Email',
                    keyboardtype: 1,
                    controller: cubit.emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      } else if (!isEmailValid(value)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  Gap(13),
                  CustomPassField(
                    hintText: 'Password',
                    controller: cubit.passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (!isPasswordValid(value)) {
                        return 'Please enter a valid password';
                      }
                      pass = value;
                      return null;
                    },
                  ),
                  Gap(12),
                  CustomPassField(
                    hintText: 'Confirm password',
                    controller: cubit.passwordconfirmationController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (!isPasswordValid(value)) {
                        return 'Please enter a valid password';
                      } else if (value != pass) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),

                  Gap(30),
                  MainButton(
                    title: 'Register',
                    onTap: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.register();
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
      ),
    );
  }
}
