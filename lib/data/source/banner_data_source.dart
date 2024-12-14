import 'package:dio/dio.dart';
import 'package:project_seven_nike_welcomeback/data/banner.dart';
import 'package:project_seven_nike_welcomeback/data/common/http_response_validator.dart';

abstract class IBannerDataSource {
  Future<List<BannerData>> getAll();
}

class BannerRemoteDataSource
    with HttpResponseValidator
    implements IBannerDataSource {
  final Dio httpClient;

  BannerRemoteDataSource(this.httpClient);

  @override
  Future<List<BannerData>> getAll() async {
    final response = await httpClient.get('banner/slider');
    validateResponse(response);
    final List<BannerData> banners = [];
    // این لیست که میگیم یعنی جیسون اری
    for (var jsonObject in (response.data as List)) {
    // ادد بکن هرکدوم از بنر دیتا هایی که ساخته شدن رو
      banners.add(BannerData.formJson(jsonObject));
    }

    return banners;
  }
}
