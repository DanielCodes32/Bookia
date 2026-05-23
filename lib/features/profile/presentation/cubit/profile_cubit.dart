import 'dart:io';

import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/profile/data/models/edit_profile_params/edit_profile_params.dart';
import 'package:bookia/features/profile/data/repo/profile_repo.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial()) {
    final user = SharedPref.getuserinfo();
    if (user != null) {
      name.text = user.name ?? '';
      address.text = user.address ?? '';
      phone.text = user.phone ?? '';
      city.text = user.city?.toString() ?? '';
    }
  }

  final formkey = GlobalKey<FormState>();
  final name = TextEditingController();
  final address = TextEditingController();
  final phone = TextEditingController();
  final city = TextEditingController();
File? image;
void pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
      emit(ProfileImagePicked());
    }
  
}
  Future<void> updateProfile() async {
    emit(ProfileLoading());
    try {
      final response = await ProfileRepo.updateProfile( EditProfileParams(
   
        name: name.text,
        address: address.text,
        phone: phone.text,
        image: image
      ));
      if (response != null && response.status == 200) {
        emit(ProfileLoaded());
      } else {
        emit(ProfileError(response?.message ?? "Failed to update profile"));
      }
    } catch (e) {
      emit(ProfileError("An unexpected error occurred"));
    }
  }
}
