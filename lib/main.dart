import 'dart:io';

import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/styles/themes.dart';
import 'package:flutter/material.dart';

void main() async {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: Routes.routes,
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
