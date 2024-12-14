

import 'package:project_seven_nike_welcomeback/common/http_client.dart';
import 'package:project_seven_nike_welcomeback/data/banner.dart';
import 'package:project_seven_nike_welcomeback/data/source/banner_data_source.dart';

final bannerRepository = BannerRepository(BannerRemoteDataSource(httpClient)) ;

abstract class IBannerRepository {
//یک لیستی از بنردیتا قراره برگرده اسمش هم میزارم getAll
  Future<List<BannerData>> getAll();
}

class BannerRepository implements IBannerRepository {
  final IBannerDataSource dataSource;

  BannerRepository(this.dataSource);

  @override
  Future<List<BannerData>> getAll() {
    return dataSource.getAll();
  }
}
