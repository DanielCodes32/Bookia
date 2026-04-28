import 'package:bookia/features/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/features/cart/data/repo/cart_repo.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitialstate());
  String? total;
  List<CartItem> cartItems = [];

  Future<void> getcart() async {
    emit(CartLoadingstate());
    var data = await CartRepo.getcart();
    if (data != null) {
      emit(CartLoadedstate());
      total = data.data!.total.toString();
      cartItems = data.data?.cartItems ?? [];
    } else {
      emit(CartErrorstate("Something went wrong"));
    }
  }

  Future<void> removeFromCart(int cartItemId) async {
    var item = cartItems.firstWhere((element) => element.itemId == cartItemId);
    cartItems.remove(item);
    if (total != null) {
      total = (double.tryParse(total ?? '0') ?? 0.0 - (item.itemTotal ?? 0.0))
          .toString();
    }
    emit(CartLoadedstate());
    var data = await CartRepo.removeFromCart(cartItemId);
    if (data != null) {
      emit(CartLoadedstate());
      total = data.data!.total.toString();
      cartItems = data.data?.cartItems ?? [];
    } else {
      cartItems.add(item);
      if (total != null) {
        total = (double.tryParse(total ?? '0') ?? 0.0 + (item.itemTotal ?? 0.0))
            .toString();
      }
      emit(CartErrorstate("Something went wrong"));
    }
  }

  Future<void> updateCart(int cartItemId, int quantity) async {
    var item = cartItems.firstWhere((element) => element.itemId == cartItemId);
    item.itemQuantity = quantity;
    double? oldtotal = item.itemTotal??0.0;
    double? newtotal = quantity * (item.itemProductPriceAfterDiscount ?? 0.0);
     item.itemTotal = newtotal;
     if (total != null) {
      total = ((double.tryParse(total ?? '0') ?? 0.0 - oldtotal + newtotal))
          .toString();}
    emit(CartLoadedstate());
    var data = await CartRepo.updateCart(cartItemId, quantity);
    if (data != null) {
      emit(CartLoadedstate());
      total = data.data!.total.toString();
      cartItems = data.data?.cartItems ?? [];
    } else {
      emit(CartErrorstate("Something went wrong"));
    }
  }
}
