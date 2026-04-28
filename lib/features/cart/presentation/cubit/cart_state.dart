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