import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/custom_snake_bar.dart';
import 'package:bookia/core/shimmer/list_shimmer.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: AppColors.containercolor,
      appBar: AppBar(
        backgroundColor: AppColors.containercolor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("My Cart", style: TextStyles.title),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          var cubit = context.read<CartCubit>();
          var cartItems = cubit.cartItems;
        if (state is CartLoadedstate) {
        if (cartItems.isEmpty) {
          return Center(child:Column(mainAxisAlignment: MainAxisAlignment.center, children: [SvgPic(assetName: AppAssets.category, width: 100,height: 100,),Gap(15), Text("No items in cart", style: TextStyles.title) ]));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(20),
        
          itemBuilder: (BuildContext context, int index) {
            
            var book=cartItems[index];
            return CartCard(book: book, onDelete: () { cubit.removeFromCart(book.itemId??0); },onDecrement: () {
             if((book.itemQuantity??0)>1) cubit.updateCart(book.itemId??0, (book.itemQuantity??0)-1);
            else {
              cubit.removeFromCart(book.itemId??0);
            }
            },
            onIncrement: () {
              if((book.itemQuantity??0)<(book.itemProductStock??0)){
              cubit.updateCart(book.itemId??0, (book.itemQuantity??0)+1);
              }
              else  {
                mydiag(context, "You can't add more than stock", Colors.red); 
               }
            },
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return Gap(16);
          },
          itemCount: cartItems.length,
        );
        }
        else  {
            return Padding(padding: const EdgeInsets.all(20), child: ListShimmer(itemCount: 5, scrollDirection: Axis.vertical));
            
          }
        }
        
      ),
  
    );
  }
}
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
                          "\$${book.itemTotal??""}", 
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