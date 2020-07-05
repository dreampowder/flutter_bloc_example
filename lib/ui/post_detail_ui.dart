import 'package:bloc_example/bloc/posts/posts_bloc.dart';
import 'package:bloc_example/model/post_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailPage extends StatefulWidget {
  final Post post;

  PostDetailPage(this.post);

  @override
  _PostDetailPageState createState() => _PostDetailPageState();
}

class _PostDetailPageState extends State<PostDetailPage> {

  PostsBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<PostsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Post Detail"),),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: ()=>_bloc.add(AddCommentToPostEvent(widget.post.postId)),
        label: Text("Add Comment"),
        icon: Icon(Icons.add_circle),
      ),
      body: BlocListener(
        bloc: _bloc,
        listenWhen: (prevState,state)=>(state is DidAddCommentToPostState && state.postId == widget.post.postId),
        listener: (context,state){
          if(state is DidAddCommentToPostState){
            print("add comment");
            setState(() {
              //We don't add comments in here because we already have a 'final' post item and we are updating it from the previous screen.
//              comments.add(state.comment);
            });
          }
        },
        child: Container(
          padding: EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.post.content,style: Theme.of(context).textTheme.bodyText1,),
                ),
              ),
              SizedBox(height: 8,),
              Text("Comments",style: Theme.of(context).textTheme.caption,),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.post.comments.length,
                  itemBuilder: (context,index){
                    Comment comment = widget.post.comments[index];
                    return ListTile(
                      title: Text(comment.content),
                    );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
