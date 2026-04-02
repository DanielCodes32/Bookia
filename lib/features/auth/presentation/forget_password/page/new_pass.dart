import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/custom_snake_bar.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/functions/validation.dart';
import 'package:bookia/core/routes/app_router.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_password_field.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/mybodyview.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class NewPassword extends StatelessWidget {
  const NewPassword({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<AuthCubit>();
    String pass = '';
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccessState) {
          pushTo(context, Routes.passchanged);
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
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Create new password", style: TextStyles.headline),
                  Gap(10),
                  Text(
                    "Your new password must be unique from those previously used.",
                    style: TextStyles.caption1,
                  ),
                  Gap(32),
                  CustomPassField(
                    hintText: 'New Password',
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
                  Gap(15),
                  CustomPassField(
                    hintText: 'Confirm Password',
                    controller: cubit.passwordconfirmationController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      } else if (!isPasswordValid(value)) {
                        return 'Please enter a valid password';
                      } else if (pass != value) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  Gap(38),
                  MainButton(
                    title: 'Reset Password',
                    onTap: () {
                      if (cubit.formKey.currentState!.validate()) {
                        cubit.resetpass();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
