import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/page/cart_screen.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/page/home_screen.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/features/wishlist/presentation/page/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainAppScreen extends StatefulWidget {
  const MainAppScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _MainAppScreenState();
  }
}

class _MainAppScreenState extends State<MainAppScreen> {
  int selectedIndex = 0;
  final List<Widget> screens = [
    Center(
      child: BlocProvider(
        create: (context) => HomeCubit()..getInitData(),
        child: HomeScreen(),
      ),
    ),
    Center(
      child: BlocProvider(
        create: (context) => WishlistCubit()..getWishlist(),
        child: WishlistScreen(),
      ),
    ),
     Center(child:   BlocProvider(
        create: (context) => CartCubit()..getcart(),
        child: CartScreen(),
      ),),
    const Center(child: Text("profile")),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: navBar(),
    );
  }

  BottomNavigationBar navBar() {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: SvgPic(assetName: AppAssets.home),
          activeIcon: SvgPic(
            assetName: AppAssets.home,
            color: AppColors.primaryColor,
          ),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: SvgPic(assetName: AppAssets.bookmark),
          activeIcon: SvgPic(
            assetName: AppAssets.bookmark,
            color: AppColors.primaryColor,
          ),
          label: "bookmark",
        ),
        BottomNavigationBarItem(
          icon: SvgPic(assetName: AppAssets.category),
          activeIcon: SvgPic(
            assetName: AppAssets.category,
            color: AppColors.primaryColor,
          ),
          label: "category",
        ),
        BottomNavigationBarItem(
          icon: SvgPic(assetName: AppAssets.profile),
          activeIcon: SvgPic(
            assetName: AppAssets.profile,
            color: AppColors.primaryColor,
          ),
          label: "profile",
        ),
      ],
    );
  }
}
