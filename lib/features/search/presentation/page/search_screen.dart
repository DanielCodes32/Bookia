import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/navigations.dart';
import 'package:bookia/core/shimmer/book_card_shimmer.dart';
import 'package:bookia/core/shimmer/grid_shimmer.dart';
import 'package:bookia/core/widgets/mybodyview.dart';
import 'package:bookia/core/widgets/svg_pic.dart';
import 'package:bookia/features/home/presentation/widgets/book_card.dart';
import 'package:bookia/features/search/presentation/cubit/search_cubit.dart';
import 'package:bookia/features/search/presentation/cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SearchScreen extends StatelessWidget{
  const SearchScreen({super.key});


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title:GestureDetector(
          onTap: () {
            pop(context);
          },
          child: SvgPic(assetName: AppAssets.back),
        ),),
      body: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          var books=context.read<SearchCubit>().books;
          if(state is! SearchSuccess){
            return GridShimmer(shimmerWidget: BookCardShimmer());
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
                    var book =books[index];
                    return BookCard(book: book);
                    
                  },
                  itemCount: books.length,
                ),
              ],
            ),
          ),
        );
        }
      )
    );
  }


}