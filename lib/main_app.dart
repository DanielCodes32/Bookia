import 'dart:io';
import 'package:bookia/core/routes/app_router.dart';
import 'package:bookia/core/styles/themes.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.routes,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darktheme,
      themeMode: ThemeMode.light,
      builder: (context, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            top: false,
            bottom: Platform.isAndroid,
            maintainBottomViewPadding: true,
            child: child!,
          ),
        );
      },
    );
  }
}
