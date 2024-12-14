
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_seven_nike_welcomeback/common/exceptsion.dart';
import 'package:project_seven_nike_welcomeback/data/comment/comment.dart';
import 'package:project_seven_nike_welcomeback/data/repo/comment_repository.dart';

part 'commentlist_event.dart';

part 'commentlist_state.dart';

class CommentListBloc extends Bloc<CommentListEvent, CommentListState> {
  final ICommentRepository repository;
  final int productId;

  CommentListBloc({required this.repository, required this.productId})
      : super(CommentListLoading()) {
    on<CommentListEvent>(
      (event, emit) async {
        if (event is CommentListStarted) {
          emit(CommentListLoading());
          try{
            final comments = await repository.getAll(productId: productId);
            emit(CommentListSuccess(comments));
          }catch(e){
            emit(CommentListError(AppException()));
          }
        }
      },
    );
  }
}
