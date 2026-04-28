import 'package:bookia/core/shimmer/book_card_shimmer.dart';
import 'package:bookia/core/shimmer/grid_shimmer.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/mybodyview.dart';
import 'package:bookia/features/home/presentation/widgets/book_card.dart';

import 'package:bookia/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text("Wishlist", style: TextStyles.title),
      ),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        builder: (context, state) {
          if (state is WishlistLoadingState) {
            return GridShimmer(shimmerWidget: BookCardShimmer());
          } else if (state is WishlistErrorState) {
            return Center(child: Text(state.error));
          }

          var books = context.read<WishlistCubit>().wishlist;

          if (books.isEmpty && state is WishlistSuccessState) {
            return Center(child: Text("No items in wishlist"));
          }

          return MyBodyView(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.65,
                      crossAxisCount: 2,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      var book = books[index];
                      return BookCard(
                        book: book,
                        onRemove: () {
                          context.read<WishlistCubit>().removeFromWishlist(
                            book.id!,
                          );
                        },
                        onRefresh: () {
                          context.read<WishlistCubit>().getWishlist();
                        },
                      );
                    },
                    itemCount: books.length,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
