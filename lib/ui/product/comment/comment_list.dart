import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_seven_nike_welcomeback/data/repo/comment_repository.dart';
import 'package:project_seven_nike_welcomeback/ui/product/comment/bloc/commentlist_bloc.dart';
import 'package:project_seven_nike_welcomeback/ui/product/comment/comment.dart';
import 'package:project_seven_nike_welcomeback/ui/widgets/error.dart';

class CommentList extends StatelessWidget {
  final int productId;

  const CommentList({Key? key, required this.productId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final CommentListBloc bloc = CommentListBloc(
            repository: commentRepository, productId: productId);
        bloc.add(CommentListStarted());
        return bloc;
      },
      child: BlocBuilder<CommentListBloc, CommentListState>(
          builder: (context, state) {
        if (state is CommentListSuccess) {
          return SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              // CommentsItem
              return CommentItem(
                commentData: state.comments[index],
              );
            }, childCount: state.comments.length),
          );
        } else if (state is CommentListLoading) {
          return const SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is CommentListError) {
          return SliverToBoxAdapter(
            child: AppErrorWidget(
                exception: state.exception,
                onPressed: () {
                  BlocProvider.of<CommentListBloc>(context)
                      .add(CommentListStarted());
                }),
          );
        } else {
          throw Exception('state is not supported');
        }
      }),
    );
  }
}

