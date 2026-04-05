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
import 'package:bookia/features/auth/presentation/login_register/login/widgets/sign_in_method.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
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
            child: SvgPic(assetName: AppAssets.back, width: 41, height: 41),
          ),
        ),
        body: MyBodyView(
          padding: const EdgeInsets.all(22),
          child: Form(
            key: cubit.formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    "Welcome back! Glad to see you, Again!",
                    style: TextStyles.headline,
                  ),
                  Gap(32),
                  CustomFormField(
                    hintText: 'Enter your email',
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
                  Gap(15),
                  CustomPassField(
                    hintText: 'Enter your password',
                    controller: cubit.passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                      } else if (!isPasswordValid(value)) {
                        return 'Please enter a valid password';
                      }
                      return null;
                    },
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          pushTo(context, Routes.forgetpassword);
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyles.caption2.copyWith(
                            color: AppColors.darkgreycolor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Gap(30),
                  MainButton(
                    title: 'Login',
                    onTap: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.login();
                      }
                    },
                  ),
                  Gap(45),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      Gap(45),
                      Text("OR", style: TextStyles.caption2),
                      Gap(45),
                      Expanded(child: Divider()),
                    ],
                  ),

                  SignInMethod(
                    text: 'Sign in with Google',
                    asset: AppAssets.google,
                  ),
                  Gap(15),
                  SignInMethod(
                    text: 'Sign in with Apple',
                    asset: AppAssets.apple,
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
              "Don’t have an account? ",
              style: TextStyles.caption1.copyWith(color: AppColors.blackColor),
            ),
            TextButton(
              onPressed: () {
                pushTo(context, Routes.register);
              },
              style: ButtonStyle(
                padding: WidgetStateProperty.all(const EdgeInsets.all(0)),
              ),
              child: Text(
                "Register Now",
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
