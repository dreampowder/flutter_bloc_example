import 'package:flutter/cupertino.dart';

class Post{
  UniqueKey postId = UniqueKey();
  String content;
  List<Comment> comments = [];
  Post(this.content);

}

class Comment{
  String content;
}