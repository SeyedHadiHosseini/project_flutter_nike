
import 'package:project_seven_nike_welcomeback/data/product.dart';

class CreateOrderParams {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final String address;
  final String postalCode;
  final PaymentMethod paymentMethod;

  CreateOrderParams(this.firstName, this.lastName, this.phoneNumber,
      this.address, this.paymentMethod, this.postalCode);
}

enum PaymentMethod {
  online,
  cashOnDelivery,
}

class CreateOrderResult {
  final int orderId;
  final String bankGatewayUrl;

  CreateOrderResult(this.orderId, this.bankGatewayUrl);

  CreateOrderResult.fromJson(Map<String, dynamic> json)
      : orderId = json['order_id'],
        bankGatewayUrl = json['bank_gateway_url'];
}


class OrderData {
  final int id;
  final int payablePrice;
  final List<ProductData> items;

  OrderData(this.id,this.payablePrice,this.items);
  OrderData.fromJson(Map<String,dynamic> json):
      id = json['id'],
  payablePrice = json['payable'],
  items = (json['order_items'] as List).map((item) => ProductData.formJson(item['product '])).toList();
}
