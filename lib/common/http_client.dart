import 'package:dio/dio.dart';
import 'package:project_seven_nike_welcomeback/data/repo/auth_repositroy.dart';


final httpClient = Dio(
    BaseOptions(
        baseUrl: 'http://expertdevelopers.ir/api/v1/'),)
  ..interceptors.add(InterceptorsWrapper(onRequest: (option, handler) {
    final authInfo = AuthRepository.authChangeNotifier.value;
    if (authInfo != null && authInfo.accessToken.isNotEmpty) {
      option.headers['Authorization'] = 'Bearer ${authInfo.accessToken}';
    }

    handler.next(option);
  },),);


