import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CartCard extends StatelessWidget {
  const CartCard({super.key, required this.book, required this.onDelete, required this.onIncrement, required this.onDecrement});
 final CartItem book;
 final VoidCallback onDelete;
 final VoidCallback onIncrement;
 final VoidCallback onDecrement;
  @override
  Widget build(BuildContext context) {
    return Container(padding: EdgeInsets.all(10),
       decoration: BoxDecoration(
    
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.circular(10),),
      child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: CachedNetworkImage(imageUrl: book.itemProductImage ?? "",
                    height: 120,
                    width: 100, fit: BoxFit.cover,),
                  ),
                  Gap(10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          
                          children: [
                            Expanded(
                              child: Text(
                                book.itemProductName ?? "",
                                style: TextStyles.caption1.copyWith(
                                  color: AppColors.darkgreycolor,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
          
                            IconButton(
                              onPressed: onDelete,
                              icon: SvgPic(assetName: AppAssets.close),
                            ),
                          ],
                        ),
                        Text(
                          "\$${book.itemProductPriceAfterDiscount??""}", 
                          style: TextStyles.caption2.copyWith(
                            color: AppColors.black1,
                          ),
                        ),
                        Gap(15),
                        Row(
                          spacing: 5,
                          children: [
                            GestureDetector(
                              onTap: onDecrement,
                              child: Container(
                                padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.lightgrey1,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: 
                                 
                                  
                                   Icon(Icons.remove),
                                ),
                            ),
                            
                            SizedBox( width: 25,
                              child: Text(
                                book.itemQuantity.toString(),
                                textAlign: TextAlign.center,
                                style:  TextStyles.caption1.copyWith(
                                  color: AppColors.black1,
                                ),
                              ),
                            ),
                             GestureDetector(
                               onTap: onIncrement,
                               child: Container(
                                 padding: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.lightgrey1,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Icon(Icons.add)),
                                
                             ),
                             Spacer(),
                            Text(
                          "\$${(book.itemTotal?.toStringAsFixed(2) ?? "")}", 
                          style: TextStyles.caption2.copyWith(
                            color: AppColors.black1,
                          ),
                        ),
                             
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}