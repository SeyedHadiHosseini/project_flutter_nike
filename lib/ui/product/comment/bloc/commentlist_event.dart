part of 'commentlist_bloc.dart';

@immutable
abstract class CommentListEvent extends Equatable{
  const CommentListEvent();

  @override
  List<Object> get props => [];
}

class CommentListStarted extends CommentListEvent{

}