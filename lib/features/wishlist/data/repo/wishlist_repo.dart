import 'package:bookia/core/services/apis/apis.dart';
import 'package:bookia/core/services/apis/dio_provider.dart';
import 'package:bookia/core/services/local/shared_pref.dart';
import 'package:bookia/features/wishlist/data/models/wishlist_response/wishlist_response.dart';

class WishlistRepo {
  static Future<WishlistResponse?> getwishlist() async {
    try {
      var response = await DioProvider.get(
        endpoint: Apis.wishlist,
        headers: {"Authorization": "Bearer ${SharedPref.gettoken()}"},
      );

      if (response.statusCode == 200) {
        var wishlistResponse = WishlistResponse.fromJson(response.data);
        _cacheWishlistIds(wishlistResponse);
        return wishlistResponse;
      } else {
        return null;
      }
    } on Exception catch (err) {
      print(err.toString());
      return null;
    }
  }

  static Future<WishlistResponse?> addToWishlist(int productId) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.addToWishlist,
        data: {"product_id": productId},
        headers: {"Authorization": "Bearer ${SharedPref.gettoken()}"},
      );

      if (response.statusCode == 200) {
        var wishlistResponse = WishlistResponse.fromJson(response.data);
        _cacheWishlistIds(wishlistResponse);
        return wishlistResponse;
      } else {
        return null;
      }
    } on Exception catch (err) {
      print(err.toString());
      return null;
    }
  }

  static Future<WishlistResponse?> removeFromWishlist(int productId) async {
    try {
      var response = await DioProvider.post(
        endpoint: Apis.removeFromWishlist,
        data: {"product_id": productId},
        headers: {"Authorization": "Bearer ${SharedPref.gettoken()}"},
      );

      if (response.statusCode == 200) {
        var wishlistResponse = WishlistResponse.fromJson(response.data);
        _cacheWishlistIds(wishlistResponse);
        return wishlistResponse;
      } else {
        return null;
      }
    } on Exception catch (err) {
      print(err.toString());
      return null;
    }
  }

  static void _cacheWishlistIds(WishlistResponse? response) {
    if (response?.data?.data != null) {
      List<String> ids =
          response!.data!.data!.map((e) => e.id.toString()).toList();
      print("Caching wishlist IDs: $ids");
      SharedPref.saveWishlist(ids);
    }
  }
}
