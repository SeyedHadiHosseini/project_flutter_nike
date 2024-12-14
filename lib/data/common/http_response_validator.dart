import 'package:dio/dio.dart';
import 'package:project_seven_nike_welcomeback/common/exceptsion.dart';

mixin HttpResponseValidator {


// اعتبار سنجی
  validateResponse(Response response) {
    if (response.statusCode != 200) {
      throw AppException();
    }
  }


}