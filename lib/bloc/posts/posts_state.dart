part of 'posts_bloc.dart';

@immutable
abstract class PostsState {}

class InitialPostsState extends PostsState {}

class DidReceivePostsState extends PostsState{
  final List<Post> posts;
  DidReceivePostsState(this.posts);
}

class DidAddCommentToPostState extends PostsState{
  final UniqueKey postId;
  final Comment comment;
  DidAddCommentToPostState(this.postId, this.comment);
}