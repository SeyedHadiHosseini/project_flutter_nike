part of 'cart_bloc.dart';

@immutable
abstract class CartState {
  const CartState();
}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final CartResponse cartResponse;

  const CartSuccess(this.cartResponse);
}

class CartError extends CartState {
  final AppException exception;

  const CartError(this.exception);
}

class CartEmpty extends CartState {}

class CartAuthRequired extends CartState {}
