class CartState {}

class CartInitialstate extends CartState {}

class CartLoadingstate extends CartState {}

class CartLoadedstate extends CartState {
  CartLoadedstate();
}

class CartErrorstate extends CartState {
  final String message;
  CartErrorstate(this.message);
}

class CheckoutLoadingstate extends CartState {}

class CheckoutSuccessstate extends CartState {}

class CheckoutErrorstate extends CartState {
  final String message;
  CheckoutErrorstate(this.message);
}

class GetGovernoratesLoadingstate extends CartState {}

class GetGovernoratesLoadedstate extends CartState {}

class GetGovernoratesErrorstate extends CartState {
  final String message;
  GetGovernoratesErrorstate(this.message);
}
