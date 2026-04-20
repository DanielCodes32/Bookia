import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/details/presentation/widgets/addtowishlist/cubit/wishlist_actions_state.dart';
import 'package:bookia/features/wishlist/data/repo/wishlist_repo.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistActionsCubit extends Cubit<WishlistActionsState> {
  WishlistActionsCubit() : super(WishlistActionsInitialState());

  Future<void> addToWishlist(int productId) async {
    emit(WishlistActionsLoadingState());
    var data = await WishlistRepo.addToWishlist(productId);
    if (data != null) {
      emit(WishlistActionsSuccessState(
        message: "Added to wishlist",
      ));
    } else {
      emit(WishlistActionsErrorState(error: "Failed to add to wishlist"));
    }
  }

  Future<void> removeFromWishlist(int productId) async {
    emit(WishlistActionsLoadingState());
    var data = await WishlistRepo.removeFromWishlist(productId);
    if (data != null) {
      emit(WishlistActionsSuccessState(
        message: "Removed from wishlist",
      ));
    } else {
      emit(WishlistActionsErrorState(error: "Failed to remove from wishlist"));
    }
  }

  bool isProductInWishlist(int productId) {
    List<String> wishlistIds = SharedPref.getWishlist();
    return wishlistIds.contains(productId.toString());
  }
}
