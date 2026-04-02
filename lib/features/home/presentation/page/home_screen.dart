import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/mybodyview.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/home/presentation/widgets/best_seller.dart';
import 'package:bookia/features/home/presentation/widgets/home_slider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [HomeSlider(), BestSeller()],
        ),
      ),
    );
  }
}
