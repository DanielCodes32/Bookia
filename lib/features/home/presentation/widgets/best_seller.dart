import 'package:bookia/core/shimmer/book_card_shimmer.dart';
import 'package:bookia/core/shimmer/grid_shimmer.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/mybodyview.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/cubit/home_state.dart';
import 'package:bookia/features/home/presentation/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class BestSeller extends StatelessWidget {
  const BestSeller({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, state) {
        var books = context.read<HomeCubit>().bestsellers;
        if (state is! HomeSuccessState) {
          return const MyBodyView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [GridShimmer(shimmerWidget: BookCardShimmer())],
            ),
          );
        }
        return MyBodyView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Best Sellers", style: TextStyles.title),
              Gap(15),
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
                  return BookCard(book: book);
                },
                itemCount: books.length,
              ),
            ],
          ),
        );
      },
    );
  }
}
