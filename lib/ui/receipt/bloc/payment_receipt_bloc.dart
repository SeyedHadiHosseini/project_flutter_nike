import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:project_seven_nike_welcomeback/common/exceptsion.dart';
import 'package:project_seven_nike_welcomeback/data/payment_receipt.dart';
import 'package:project_seven_nike_welcomeback/data/repo/order_repository.dart';

part 'payment_receipt_event.dart';
part 'payment_receipt_state.dart';

class PaymentReceiptBloc extends Bloc<PaymentReceiptEvent, PaymentReceiptState> {
  final IOrderRepository repository;
  PaymentReceiptBloc(this.repository) : super(PaymentReceiptLoading()) {
    on<PaymentReceiptEvent>((event, emit) async {
      if (event is PaymentReceiptStarted) {
        emit(PaymentReceiptLoading());
        // Change to String
        try{final result = await  repository.getPaymentReceipt(event.orderId);
        emit(PaymentSuccess(result));
        }catch(e){
          emit(PaymentReceiptError(AppException()));
        }
      }
    });
  }
}
