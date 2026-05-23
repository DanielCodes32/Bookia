import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/forget_password/page/Verify.dart';
import 'package:bookia/features/auth/presentation/forget_password/page/forget_password.dart';
import 'package:bookia/features/auth/presentation/forget_password/page/new_pass.dart';
import 'package:bookia/features/auth/presentation/forget_password/page/success.dart';
import 'package:bookia/features/auth/presentation/login_register/login/page/login_screen.dart';
import 'package:bookia/features/auth/presentation/login_register/login/page/register_screen.dart';
import 'package:bookia/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:bookia/features/checkout/presentation/page/place_order_screen.dart';
import 'package:bookia/features/checkout/presentation/page/success.dart';
import 'package:bookia/features/details/presentation/page/details_screen.dart';
import 'package:bookia/features/home/models/best_seller_response/product.dart';
import 'package:bookia/features/main/main_app_screen.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/profile/presentation/page/edit_profile.dart';
import 'package:bookia/features/search/presentation/cubit/search_cubit.dart';
import 'package:bookia/features/search/presentation/page/search_screen.dart';
import 'package:bookia/features/splash/splash.dart';
import 'package:bookia/features/welcome/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  static final routes = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: Routes.orderPlaced,
        builder: (context, state) => const OrderPlaced(),
      ),
      GoRoute(
        path: Routes.details,
        builder: (context, state) =>
            DetailsScreen(book: state.extra as Product),
      ),
      GoRoute(
        path: Routes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: Routes.mainappscreen,
        builder: (context, state) =>
            MainAppScreen(currentIndex: state.extra as int?),
      ),
      GoRoute(
        path: Routes.editProfile,
        builder: (context, state) => BlocProvider(
          create: (context) => ProfileCubit(),
          child: EditProfile(),
        ),
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
        path: Routes.newpass,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const NewPassword(),
        ),
      ),
      GoRoute(
        path: Routes.search,
        builder: (context, state) => BlocProvider(
          create: (context) => SearchCubit()..search(''),
          child: const SearchScreen(),
        ),
      ),
      GoRoute(
        path: Routes.passchanged,
        builder: (context, state) => const PassChanged(),
      ),
      GoRoute(
        path: Routes.placeorder,
        builder: (context, state) => BlocProvider(
          create: (context) => CheckoutCubit()..getGovernorates(),
          child: PlaceOrderScreen(total: state.extra as String),
        ),
      ),
    ],
  );
}
