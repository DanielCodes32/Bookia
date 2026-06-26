import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/core/utils/bloc_observer.dart';

import 'package:bookia/main_app.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  await EasyLocalization.ensureInitialized();
  DioProvider.init();
  Bloc.observer = MyBlocObserver();
  runApp(EasyLocalization(supportedLocales: [Locale('en'), Locale('ar')], path: 'assets/translations/',fallbackLocale: Locale('en'),
  child: const MainApp()));
}
