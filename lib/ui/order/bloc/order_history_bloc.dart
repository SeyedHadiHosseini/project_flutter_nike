


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_seven_nike_welcomeback/common/exceptsion.dart';
import 'package:project_seven_nike_welcomeback/data/order.dart';
import 'package:project_seven_nike_welcomeback/data/repo/order_repository.dart';

part 'order_history_event.dart';

part 'order_history_state.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final IOrderRepository repository;

  OrderHistoryBloc(this.repository) : super(OrderHistoryLoading()) {
    on<OrderHistoryEvent>((event, emit) async {
      if (event is OrderHistoryStarted) {
        try {
          emit(OrderHistoryLoading());
          final orders = await repository.getOrders();
          emit(OrderHistorySuccess(orders));
        } catch (e) {
          emit(OrderHistoryError(AppException()));
        }
      }
    });
  }
}
