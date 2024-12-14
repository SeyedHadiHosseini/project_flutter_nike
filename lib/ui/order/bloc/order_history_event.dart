part of 'order_history_bloc.dart';

@immutable
abstract class OrderHistoryEvent {
  const OrderHistoryEvent();

  @override
  List<Object> get props => [];

}


class OrderHistoryStarted extends OrderHistoryEvent {}

