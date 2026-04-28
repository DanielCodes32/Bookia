abstract class WishlistActionsState {}

class WishlistActionsInitialState extends WishlistActionsState {}

class WishlistActionsLoadingState extends WishlistActionsState {}

class WishlistActionsSuccessState extends WishlistActionsState {
  final String message;
  WishlistActionsSuccessState({required this.message});
}

class WishlistActionsErrorState extends WishlistActionsState {
  final String error;
  WishlistActionsErrorState({required this.error});
}
