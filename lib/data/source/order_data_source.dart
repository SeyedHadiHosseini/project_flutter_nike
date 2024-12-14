import 'package:dio/dio.dart';
import 'package:project_seven_nike_welcomeback/data/order.dart';
import 'package:project_seven_nike_welcomeback/data/payment_receipt.dart';

abstract class IOrderDataSource {
  Future<CreateOrderResult> create(CreateOrderParams params);
  Future<PaymentReceiptData> getPaymentReceipt(int orderId);
  Future<List<OrderData>> getOrders();
}

class OrderRemoteDataSource implements IOrderDataSource  {
  final Dio httpClient;

  OrderRemoteDataSource(this.httpClient);

  @override
  Future<CreateOrderResult> create(CreateOrderParams params) async {
    //order/submit
    final response = await httpClient.post('order/submit', data: {
      
      'first_name' : params.firstName,
      'last_name' : params.lastName,
      'mobile' : params.phoneNumber,
      'postal_code' : params.postalCode,
      'address' : params.address,
      'payment_method' : params.paymentMethod == PaymentMethod.online ? 'online' : 'cash_on_delivery',
      
    });
    return CreateOrderResult.fromJson(response.data);
  }

  @override
  Future<PaymentReceiptData> getPaymentReceipt(int orderId) async {
    final response = await httpClient.get('order/checkout?order_id=$orderId');
    return PaymentReceiptData.fromJson(response.data);
  }

  @override
  Future<List<OrderData>> getOrders() async {
  final response = await httpClient.get('order/list');
  return (response.data as List).map((item) => OrderData.fromJson(item)).toList();
  }
}