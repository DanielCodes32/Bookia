import 'dart:developer';

import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/services/apis/apis.dart';
import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/models/authparams.dart';
import 'package:bookia/features/auth/data/models/authresponse/authresponse.dart';
import 'package:bookia/features/auth/data/models/forget_pass/forget_pass/forget_pass.dart';
import 'package:bookia/features/auth/data/models/forgetparams.dart';

class AuthRepo {
  static Future<Authresponse?> login(Authparams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.login,
        data: params.toJson(),
      );
      if (response.statusCode == 200) {
        var data = Authresponse.fromJson(response.data);
        SharedPref.savetoken(data.data?.token);
        SharedPref.saveuserinfo(data.data?.user);
        return data;
      } else {
        return null;
      }
    } on Exception catch (err) {
      log(err.toString());
      return null;
    }
  }

  static Future<Authresponse?> register(Authparams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.register,
        data: params.toJson(),
      );
      if (response.statusCode == 201) {
        var data = Authresponse.fromJson(response.data);
        SharedPref.savetoken(data.data?.token);
        SharedPref.saveuserinfo(data.data?.user);
        return data;
      } else {
        return null;
      }
    } on Exception catch (err) {
      log(err.toString());
      return null;
    }
  }

  static Future<ForgetPass?> forgetPass(Forgetparams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.forgetPass,
        data: params.toJson(),
      );

      if (response.statusCode == 200) {
        return ForgetPass.fromJson(response.data);
      } else if (response.statusCode == 422) {
        return null;
      } else if (response.statusCode == 500) {
        return null;
      } else {
        log('Unexpected status code: ${response.statusCode}');
        return null;
      }
    } on Exception catch (err) {
      log(err.toString());
      return null;
    }
  }

  static Future<ForgetPass?> verfiy(Forgetparams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.checkforgetpassword,
        data: params.toJson(),
      );

      if (response.statusCode == 200) {
        SharedPref.saveotp(params.otp);
        return ForgetPass.fromJson(response.data);
      } else if (response.statusCode == 422) {
        return null;
      } else {
        log('Unexpected status code: ${response.statusCode}');
        return null;
      }
    } on Exception catch (err) {
      log(err.toString());
      return null;
    }
  }

  static Future<ForgetPass?> resetpass(Forgetparams params) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.resetpassword,
        data: params.toJson(),
      );

      if (response.statusCode == 200) {
        return ForgetPass.fromJson(response.data);
      } else if (response.statusCode == 422) {
        return null;
      } else {
        log('Unexpected status code: ${response.statusCode}');
        return null;
      }
    } on Exception catch (err) {
      log(err.toString());
      return null;
    }
  }
}
