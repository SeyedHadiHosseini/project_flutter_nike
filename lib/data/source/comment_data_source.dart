
import 'package:dio/dio.dart';
import 'package:project_seven_nike_welcomeback/data/comment/comment.dart';
import 'package:project_seven_nike_welcomeback/data/common/http_response_validator.dart';

abstract class ICommentDataSource {
  Future<List<CommentData>> getAll({required int productId});
}

class CommentRemoteDataSource
    with HttpResponseValidator
    implements ICommentDataSource {
  final Dio httpClient;

  CommentRemoteDataSource(this.httpClient);

  @override
  Future<List<CommentData>> getAll({required int productId}) async {
    final response = await httpClient.get('comment/list?product_id=$productId');
    validateResponse(response);
    final List<CommentData> comment = [];
    for (var element in (response.data as List)) {
      comment.add(CommentData.fromJson(element));
    }
    return comment;
  }
}
