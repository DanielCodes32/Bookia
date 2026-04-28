import 'package:bookia/core/functions/custom_snake_bar.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/features/details/presentation/widgets/add_to_cart/cubit/add_to_cart_cubit.dart';
import 'package:bookia/features/details/presentation/widgets/add_to_cart/cubit/add_to_cart_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddToCart extends StatelessWidget {
  const AddToCart({
    super.key, required this.productId,
  });
final int productId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddToCartCubit(),
      child: BlocConsumer<AddToCartCubit, AddToCartState>(
        listener: (context, state) {
              if (state is AddToCartLoadingState) {
Padding(
              padding: EdgeInsets.all(12.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
              }
         else if (state is AddToCartSuccessState) {
          
            mydiag(context, state.message, Colors.green);
          } else if (state is AddToCartErrorState) {
            
            mydiag(context, state.error, Colors.red);
          }
        },
        builder: (context, state) {
          
         
         return MainButton(
          title: "Add To Cart",
          size: Size(212, 56),
          bgcolor: AppColors.blackColor,
          textcolor: AppColors.backgroundColor,
          onTap: () {
             context.read<AddToCartCubit>().addToCart(productId);
            
          },
        );},
      ),
    );
  }
}
