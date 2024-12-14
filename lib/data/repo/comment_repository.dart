

import 'package:project_seven_nike_welcomeback/common/http_client.dart';
import 'package:project_seven_nike_welcomeback/data/comment/comment.dart';
import 'package:project_seven_nike_welcomeback/data/source/comment_data_source.dart';

final commentRepository = CommentRepository(CommentRemoteDataSource(httpClient));

abstract class ICommentRepository {

  Future<List<CommentData>> getAll({required int productId});

}

class CommentRepository implements ICommentRepository {

  final ICommentDataSource dataSource;
  CommentRepository(this.dataSource);
  @override
  Future<List<CommentData> > getAll({required int productId}) => dataSource.getAll(productId: productId);

}