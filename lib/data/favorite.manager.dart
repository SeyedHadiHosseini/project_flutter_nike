import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:project_seven_nike_welcomeback/data/product.dart';

final favoriteManager = FavoriteManager();

class FavoriteManager {
  static const _boxName = 'favorite';
final _box = Hive.box<ProductData>(_boxName);
ValueListenable<Box<ProductData>> get listenable => Hive.box<ProductData>(_boxName).listenable();
static init() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductDataAdapter());
  Hive.openBox<ProductData>(_boxName);
}

  void addFavorite(ProductData product){
    _box.put(product.id, product);

  }
  void delete(ProductData product){
    _box.delete(product.id);
  }

  List<ProductData> get favorite => _box.values.toList();


bool isFavorite(ProductData product) {
  return _box.containsKey(product.id);
}
}