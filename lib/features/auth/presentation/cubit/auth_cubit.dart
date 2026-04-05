import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/auth/data/models/authparams.dart';
import 'package:bookia/features/auth/data/models/forgetparams.dart';
import 'package:bookia/features/auth/data/repository/auth_repo.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordconfirmationController = TextEditingController();
  final passwordController = TextEditingController();
  final otpController = TextEditingController();
  Future<void> login() async {
    emit(AuthLoadingState());
    var params = Authparams(
      email: emailController.text,
      password: passwordController.text,
    );
    var data = await AuthRepo.login(params);
    if (data != null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState());
    }
  }

  Future<void> register() async {
    emit(AuthLoadingState());
    var params = Authparams(
      name: usernameController.text,
      email: emailController.text,
      password: passwordController.text,
      passwordconfirmation: passwordconfirmationController.text,
    );
    var data = await AuthRepo.register(params);
    if (data != null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState());
    }
  }

  Future<void> forgetpass() async {
    emit(AuthLoadingState());
    var params = Forgetparams(email: emailController.text);
    var data = await AuthRepo.forgetPass(params);
    if (data == null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState());
    }
  }

  Future<void> verfiy() async {
    emit(AuthLoadingState());
    var params = Forgetparams(
      otp: otpController.text,
      email: emailController.text,
    );
    var data = await AuthRepo.verfiy(params);
    if (data == null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState());
    }
  }

  Future<void> resetpass() async {
    emit(AuthLoadingState());
    var params = Forgetparams(
      otp: SharedPref.getotp(),
      password: passwordController.text,
      passwordconfirmation: passwordconfirmationController.text,
    );
    var data = await AuthRepo.resetpass(params);
    if (data == null) {
      emit(AuthSuccessState());
    } else {
      emit(AuthErrorState());
    }
  }
}
