import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/custom_snake_bar.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/widgets/custom_form_field.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/mybodyview.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = SharedPref.getuserinfo();
    final cubit = context.read<ProfileCubit>();

    return BlocListener<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoading) {
          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is ProfileLoaded) {
           pop(context); // Pop the progress dialog
          mydiag(context, "Profile updated successfully!", Colors.green);
          pop(context); // Go back to the profile screen
        } else if (state is ProfileError) {
          pop(context); // Pop the progress dialog
          mydiag(context, state.message, Colors.red);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () {
                pop(context);
              },
              child: SvgPic(assetName: AppAssets.back, width: 30, height: 30),
            ),
          ),
          title: const Text("Edit Profile"),
        ),
        body: MyBodyView(
          child: SingleChildScrollView(
            child: Form(
              key: cubit.formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Gap(50),
                  Stack(
                    children: [
                      if(cubit.image != null) ClipOval(
                        child: Image.file(
                          cubit.image!,
                          width: 120,
                          height: 120,
                        ),
                      )
                      
                      else if(user?.image != null)
                      ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: user?.image ?? "",
                          width: 120,
                          height: 120,
                        ),
                      )
                      else
                      ClipOval(
                        child: Image.asset(
                          AppAssets.splash,
                          width: 120,
                          height: 120,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: (){
                            cubit.pickImage();
                          },
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              color: AppColors.lightgrey,
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPic(assetName: AppAssets.camera),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Gap(55),
                  CustomFormField(
                    controller: cubit.name,
                    hintText: "Full Name",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                  const Gap(12),
                  CustomFormField(
                    controller: cubit.phone,
                    hintText: "Phone",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your phone number";
                      } else if (value.length != 11) {
                        return "Please enter a valid phone number";
                      }
                      return null;
                    },
                  ),
                  const Gap(12),
                  CustomFormField(
                    controller: cubit.city,
                    hintText: "City",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your city";
                      }
                      return null;
                    },
                  ),
                  const Gap(12),
                  CustomFormField(
                    controller: cubit.address,
                    hintText: "Address",
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your address";
                      }
                      return null;
                    },
                  ),
                  const Gap(30),
                  MainButton(
                    title: "Save Changes",
                    onTap: () {
                      if (cubit.formkey.currentState!.validate()) {
                        cubit.updateProfile();
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
