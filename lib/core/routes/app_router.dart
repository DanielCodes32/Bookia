import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/forget_password/page/Verify.dart';
import 'package:bookia/features/auth/presentation/forget_password/page/forget_password.dart';
import 'package:bookia/features/auth/presentation/forget_password/page/new_pass.dart';
import 'package:bookia/features/auth/presentation/forget_password/page/success.dart';
import 'package:bookia/features/auth/presentation/login_register/login/page/login_screen.dart';
import 'package:bookia/features/auth/presentation/login_register/login/page/register_screen.dart';
import 'package:bookia/features/details/presentation/page/details_screen.dart';
import 'package:bookia/features/home/models/best_seller_response/product.dart';
import 'package:bookia/features/main/main_app_screen.dart';
import 'package:bookia/features/splash/splash.dart';
import 'package:bookia/features/welcome/welcome.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final routes = GoRouter(
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.details,
        builder: (context, state) => DetailsScreen(
          book: state.extra as Product,
        ),
      ),
      GoRoute(
        path: Routes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: Routes.mainappscreen,
        builder: (context, state) => MainAppScreen(),
      ),
      GoRoute(
        path: Routes.login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: Routes.register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: Routes.forgetpassword,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const ForgetPassword(),
        ),
      ),
      GoRoute(
        path: Routes.verification,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const VerficationScreen(),
        ),
      ),

      GoRoute(
        path: Routes.newpass,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const NewPassword(),
        ),
      ),
      GoRoute(
        path: Routes.passchanged,
        builder: (context, state) => const PassChanged(),
      ),
    ],
  );
}
