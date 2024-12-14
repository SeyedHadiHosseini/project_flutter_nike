
import 'package:project_seven_nike_welcomeback/data/cart_item.dart';

class CartResponse {
  final List<CartItemData> cartItems;
   int payablePrice;
   int totalPrice;
   int shippingCost;

  CartResponse.formJson(Map<String,dynamic> json) :
  cartItems = CartItemData.parseJsonArray(json['cart_items'],),

  payablePrice = json['payable_price'],
  totalPrice = json['total_price'],
  shippingCost = json['shipping_cost'];
}