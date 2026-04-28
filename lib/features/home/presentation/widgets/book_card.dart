import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/routes/routes.dart';
import 'package:bookia/core/shimmer/book_card_shimmer.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/features/home/models/best_seller_response/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class BookCard extends StatelessWidget {
  const BookCard({
    super.key,
    required this.book,

    this.onRemove,
    this.onRefresh,
  });

  final Product book;

  final VoidCallback? onRemove;
  final VoidCallback? onRefresh;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        pushTo(context, Routes.details, extra: book).then((value) {
          onRefresh?.call();
        });
      },
      child: Container(
      
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: AppColors.backgroundColor,
        ),
        child: Column(
          children: [
            Expanded(
              child: Hero(
                tag: book.id ?? "",
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl: book.image ?? "",
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => BookCardShimmer(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Gap(5),
            Text(
              book.name ?? "",
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyles.caption1.copyWith(color: AppColors.blackColor),
            ),
            Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "\$${book.priceAfterDiscount ?? book.price}",
                  style: TextStyles.caption1.copyWith(
                    color: AppColors.blackColor,
                  ),
                ),
                if (onRemove != null)
                  GestureDetector(
                    onTap: onRemove,
                    child: Icon(
                      Icons.close,
                      color: AppColors.blackColor,
                      size: 20,
                    ),
                  )
                else
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 23,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.blackColor,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Text(
                        "Buy",
                        style: TextStyles.caption2.copyWith(
                          color: AppColors.backgroundColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
