 part of 'payment_receipt_bloc.dart';

@immutable
abstract class PaymentReceiptState extends Equatable {
  const PaymentReceiptState();

  @override
  List<Object> get props => [];
}

class PaymentReceiptLoading extends PaymentReceiptState {}

class PaymentSuccess extends PaymentReceiptState {
  final PaymentReceiptData paymentReceiptData;

  const PaymentSuccess(this.paymentReceiptData);

  @override
  List<Object> get props => [paymentReceiptData];
}

class PaymentReceiptError extends PaymentReceiptState {
  final AppException exception;

  const PaymentReceiptError(this.exception);

  @override
  List<Object> get props => [exception];
}
