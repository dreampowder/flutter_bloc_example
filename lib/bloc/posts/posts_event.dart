part of 'posts_bloc.dart';

@immutable
abstract class PostsEvent {}

class AddCommentToPostEvent extends PostsEvent{
  final UniqueKey postId;
  AddCommentToPostEvent(this.postId);
}

class GetRandomPostsEvent extends PostsEvent{}