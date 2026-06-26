import 'dart:io';
import 'package:bookia/core/routes/app_router.dart';
import 'package:bookia/core/styles/themes.dart';
import 'package:chili_debug_view/chili_debug_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter.routes,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      darkTheme: AppThemes.darktheme,
      themeMode: ThemeMode.light,
      builder: (context, child) {
        return DebugView(
          app: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              top: false,
              bottom: Platform.isAndroid,
              maintainBottomViewPadding: true,
              child: child!,
            ),
          ),
          navigatorKey: navigatorKey,
          showDebugViewButton: true,
        );
      },
    );
  }
}
