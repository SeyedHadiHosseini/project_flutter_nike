
import 'package:project_seven_nike_welcomeback/data/product.dart';

class CartItemData {
  final ProductData product;
  final int id;
  int count;
  bool deleteButtonLoading = false;
  bool changeCountLoading = false;
  CartItemData.fromJson(Map<String, dynamic> json)
      : product = ProductData.formJson(json['product']),
        id = json['cart_item_id'],
        count = json['count'];

  static List<CartItemData> parseJsonArray(List<dynamic> jsonArray) {
    final List<CartItemData> cartItem = [];
    for (var element in jsonArray) {
        cartItem.add(
          CartItemData.fromJson(element),
        );
      }
    return cartItem;
  }
}
