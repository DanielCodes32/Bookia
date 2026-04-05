import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/widgets/mybodyview.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/home/presentation/widgets/home_slider.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Image.asset(AppAssets.splash, height: 30, width: 100),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPic(assetName: AppAssets.search),
          ),
        ],
      ),
      body: MyBodyView(child: Column(children: [HomeSlider()])),
    );
  }
}
