import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/shimmer/book_card_shimmer.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/home/models/best_seller_response/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:readmore/readmore.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.book});
  final Product book;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        title: GestureDetector(
          onTap: () {
            pop(context);
          },
          child: SvgPic(assetName: AppAssets.back),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: SvgPic(assetName: AppAssets.bookmark),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            children: [
              Hero(
                tag: book.id ?? "",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                  
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.height*0.5,
                      imageUrl: book.image ?? "",
                      progressIndicatorBuilder:
                          (context, url, downloadProgress) =>
                             BookCardShimmer(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                ),
              ),
              Gap(11),
              Text(
                book.name ?? "",
                style: TextStyles.headline,
                textAlign: TextAlign.center,
              ),
              Gap(11),
              Text(
                book.category ?? "",
                style: TextStyles.caption1.copyWith(
                  color: AppColors.primaryColor,
                ),
                textAlign: TextAlign.center,
              ),
              Gap(16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 0),
                child: ReadMoreText(
                  book.description ?? "",trimMode: TrimMode.Line,
                  style: TextStyles.caption2.copyWith(color: AppColors.darkgreycolor),
                  textAlign: TextAlign.justify,
                  trimLines: 4,
                  colorClickableText: AppColors.primaryColor,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("\$${book.price}", style: TextStyles.title),
          MainButton(
            title: "Add To Cart",
            size: Size(212, 56),
            bgcolor: AppColors.blackColor,
            textcolor: AppColors.backgroundColor,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
