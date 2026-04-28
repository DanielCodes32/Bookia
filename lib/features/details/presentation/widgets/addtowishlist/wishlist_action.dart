import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/custom_snake_bar.dart';
import 'package:bookia/core/styles/app_colors.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/details/presentation/widgets/addtowishlist/cubit/wishlist_actions_cubit.dart';
import 'package:bookia/features/details/presentation/widgets/addtowishlist/cubit/wishlist_actions_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistAction extends StatelessWidget {
  const WishlistAction({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WishlistActionsCubit(),
      child: BlocConsumer<WishlistActionsCubit, WishlistActionsState>(
        listener: (context, state) {
          if (state is WishlistActionsSuccessState) {
            mydiag(context, state.message, Colors.green);
          } else if (state is WishlistActionsErrorState) {
            mydiag(context, state.error, Colors.red);
          }
        },
        builder: (context, state) {
          var cubit = context.read<WishlistActionsCubit>();
          if (state is WishlistActionsLoadingState) {
            return const Padding(
              padding: EdgeInsets.all(12.0),
              child: SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            );
          }
          return IconButton(
            onPressed: () {
              if (cubit.isProductInWishlist(productId)) {
                cubit.removeFromWishlist(productId);
              } else {
                cubit.addToWishlist(productId);
              }
            },
            icon: SvgPic(
              assetName: AppAssets.bookmark,
              color: cubit.isProductInWishlist(productId)
                  ? AppColors.primaryColor
                  : null,
            ),
          );
        },
      ),
    );
  }
}
