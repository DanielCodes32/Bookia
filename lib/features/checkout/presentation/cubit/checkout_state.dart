class CheckoutState {}

class CheckoutInitial extends CheckoutState {}

class CheckoutLoadingstate extends CheckoutState {}

class CheckoutSuccessstate extends CheckoutState {}

class CheckoutErrorstate extends CheckoutState {
  final String message;
  CheckoutErrorstate(this.message);
}

class GetGovernoratesSuccessstate extends CheckoutState {}
