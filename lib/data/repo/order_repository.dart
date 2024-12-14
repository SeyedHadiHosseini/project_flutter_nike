

import 'package:project_seven_nike_welcomeback/common/http_client.dart';
import 'package:project_seven_nike_welcomeback/data/order.dart';
import 'package:project_seven_nike_welcomeback/data/payment_receipt.dart';
import 'package:project_seven_nike_welcomeback/data/source/order_data_source.dart';

final orderRepository = OrderRepository(OrderRemoteDataSource(httpClient));

abstract class IOrderRepository extends IOrderDataSource {}

class OrderRepository implements IOrderRepository {
  final IOrderDataSource orderDataSource;

  OrderRepository(this.orderDataSource);

  @override
  Future<CreateOrderResult> create(CreateOrderParams params) =>
      orderDataSource.create(params);

  @override
  Future<PaymentReceiptData> getPaymentReceipt(int orderId) =>
      orderDataSource.getPaymentReceipt(orderId);

  @override
  Future<List<OrderData>> getOrders() {
    return orderDataSource.getOrders();
  }
}
