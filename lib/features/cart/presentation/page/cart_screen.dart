import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/custom_snake_bar.dart';
import 'package:bookia/core/shimmer/list_shimmer.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:bookia/features/cart/presentation/widgets/cart_card.dart';
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
   bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
     builder: (context, state) {
       
     
     return Padding(
       padding: const EdgeInsets.all(15),
       child: Column(mainAxisSize: MainAxisSize.min,
        children: [
          Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total", style: TextStyles.title.copyWith(color: AppColors.darkgreycolor),),
              Text(context.read<CartCubit>().total ?? "", style: TextStyles.title.copyWith(color: AppColors.darkgreycolor),),
             ],
          ),
          MainButton(title: "Checkout", onTap: () {},)
        ],
        
       ),
     );
     }
   ),
    );
  }
}
