
import 'package:project_seven_nike_welcomeback/common/http_client.dart';
import 'package:project_seven_nike_welcomeback/data/product.dart';
import 'package:project_seven_nike_welcomeback/data/source/product_data_source.dart';

final productRepository =
    ProductRepository(ProductRemoteDataSource(httpClient));

// اینجا جایی هست که تصمیم میگیره اطلاعات رو از کجا بگیره
abstract class IProductRepository {
  Future<List<ProductData>> getAll(int sort);

  Future<List<ProductData>> search(String searchTerm);
}

// زمانی که بخوایم یک interface رو پیاده سازی بکنیم باید از یک implements استفا ده بکنیم
// این repository هست که تصمیم میگیره از کجا ازجه دیتا سورسی اطلاعات رو به ما بده
class ProductRepository implements IProductRepository {
  final IProductDataSource dataSource;

  ProductRepository(this.dataSource);

  @override
  Future<List<ProductData>> getAll(int sort) {
    return dataSource.getAll(sort);
  }

  @override
  Future<List<ProductData>> search(String searchTerm) {
    return dataSource.search(searchTerm);
  }
}
