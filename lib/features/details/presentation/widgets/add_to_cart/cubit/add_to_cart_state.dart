class AddToCartState {}

class AddToCartInitial extends AddToCartState {}

class AddToCartLoadingState extends AddToCartState {}

class AddToCartSuccessState extends AddToCartState {
  final String message;

  AddToCartSuccessState({required this.message});
}

class AddToCartErrorState extends AddToCartState {
  final String error;

  AddToCartErrorState({required this.error});
}

