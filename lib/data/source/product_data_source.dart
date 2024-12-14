import 'package:dio/dio.dart';
import 'package:project_seven_nike_welcomeback/data/common/http_response_validator.dart';
import 'package:project_seven_nike_welcomeback/data/product.dart';

// اینجایی هست که اطلاعات ازش میان
abstract class IProductDataSource {
  // مشابه repository این دوتا فانکشن رو داره
  Future<List<ProductData>> getAll(int sort);

  Future<List<ProductData>> search(String searchTerm);
}

class ProductRemoteDataSource with HttpResponseValidator implements IProductDataSource {
  final Dio httpClient;

  ProductRemoteDataSource(this.httpClient);

  @override
  Future<List<ProductData>> getAll(int sort) async {
    final response = await httpClient.get('product/list?sort=$sort');
    // هرزمانی که درخواستی رو داریم باید صدا بزنیم برای این که مطمین بشیم response مون اعتبار سنجی شده
    validateResponse(response);
    // یک لیستی دارم از نوع ProductData
    final products = <ProductData>[];
    // این response.data شامل چیزی هست که برای ما اومده بعنوان خروجی
    // که میگیم بیا بعنوان یک لیست تبدیلش بکن
    for (var element in (response.data as List)) {
      products.add(ProductData.formJson(element));
    }
    return products;
  }

  @override
  Future<List<ProductData>> search(String searchTerm) async {
    final response = await httpClient.get('product/search?q=$searchTerm');
    // هرزمانی که درخواستی رو داریم باید صدا بزنیم برای این که مطمین بشیم response مون اعتبار سنجی شده
    validateResponse(response);
    // یک لیستی دارم از نوع ProductData
    final products = <ProductData>[];
    // این response.data شامل چیزی هست که برای ما اومده بعنوان خروجی
    // که میگیم بیا بعنوان یک لیست تبدیلش بکن
    for (var element in (response.data as List)) {
      products.add(ProductData.formJson(element));
    }
    return products;
  }


}
