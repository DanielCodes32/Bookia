import 'dart:developer';

import 'package:bookia/core/services/apis/apis.dart';
import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/profile/data/models/edit_profile_params/edit_profile_params.dart';
import 'package:bookia/features/profile/data/models/profile_response/profile_response.dart';


class ProfileRepo {
  static Future<ProfileResponse?> updateProfile(EditProfileParams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.updateProfile,
        data: params.toFormData(),
        headers: {
          "Authorization": "Bearer ${SharedPref.gettoken()}",
          "Accept": "application/json",
          "Content-Type": "multipart/form-data"
        },
      );

      if (response.statusCode == 200) {
        var profileResponse = ProfileResponse.fromJson(response.data);
        if (profileResponse.data != null) {
          await SharedPref.saveuserinfo(profileResponse.data);
        }
        return profileResponse;
      } else {
        return null;
      }
    } on Exception catch (err) {
      log(err.toString());
      return null;
    }
  }
}
