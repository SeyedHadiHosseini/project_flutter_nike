import 'package:hive_flutter/adapters.dart';
part 'product.g.dart';
@HiveType(typeId: 0)
class ProductData {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String imageUrl;
  @HiveField(3)
  final int price;
  @HiveField(4)
  final int discount;
  @HiveField(5)
  final int previousPrice;
  ProductData(this.id,this.title,this.imageUrl,this.price,this.discount,this.previousPrice);

  ProductData.formJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        imageUrl = json['image'],
        price = json['previous_price'] == null
            ? json['price'] - json['discount']
            : json['price'],
        previousPrice = json['previous_price'] ?? json['price'],
        discount = json['discount'];
}
class ProductSort {
// باعث میشه کد تمیز تر باشه و مقدار اشتباهی sort رو سمت سرور ارسال نکنه
  static const int latest = 0;
  static const int popular = 1;
  static const int priceHighToLow = 2;
  static const int priceLowToHigh = 3;
  static const List<String> name = [
    'جدید ترین',
    'پربازدید ترین',
    'قیمت نزولی',
    'قیمت صعودی',
  ];
}
