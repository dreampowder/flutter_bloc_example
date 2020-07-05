import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:bloc_example/model/post_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:lipsum/lipsum.dart' as lipsum;

part 'posts_event.dart';

part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {

  PostsBloc(PostsState initialState) : super(initialState);

  @override
  Stream<PostsState> mapEventToState(PostsEvent event) async* {
    if(event is GetRandomPostsEvent){
       var posts = await generatePosts();
       yield DidReceivePostsState(posts);
    }else if(event is AddCommentToPostEvent){
      var comment = Comment();
      comment.content = lipsum.createSentence();
      yield DidAddCommentToPostState(event.postId, comment);
    }
  }

  Future<List<Post>> generatePosts(){
    Random random = Random();
    List<Post> posts = [];
    for(int i = 0;i<random.nextInt(20)+5;i++){
      posts.add(Post(lipsum.createSentence()));
    }
    return Future.value(posts);
  }
}
