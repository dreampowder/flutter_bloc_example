import 'package:bloc_example/bloc/posts/posts_bloc.dart';
import 'package:bloc_example/model/post_model.dart';
import 'package:bloc_example/ui/post_detail_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsPage extends StatefulWidget {
  @override
  _PostsPageState createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {

  List<Post> posts = [];
  PostsBloc _bloc;

  @override
  void initState() {
    _bloc = BlocProvider.of<PostsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts"),),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: (){
            _bloc.add(GetRandomPostsEvent());
          },
          icon: Icon(Icons.refresh),
          label: Text("Generate Random Posts")),
      body: BlocListener(
        bloc: _bloc,
        listener: (context,state){
          if(state is DidReceivePostsState){
            setState(() {
              this.posts = state.posts;
            });
          }else if(state is DidAddCommentToPostState){
            var index = this.posts.indexWhere((post) => post.postId == state.postId);
            if(index >= 0){
              setState(() {
                this.posts[index].comments.add(state.comment);
              });
            }
          }
        },
        child: ListView.builder(
          itemCount:posts.length,
            itemBuilder: (context,index){
              Post post = posts[index];
              return ListTile(
                onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BlocProvider.value(value: _bloc,child: PostDetailPage(post),))),
                leading: Icon(Icons.person),
                title: Text(post.content),
                subtitle: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(Icons.message,color: Colors.black54,),
                    Text("${post.comments.length}",style: Theme.of(context).textTheme.bodyText1,)
                  ],
                ),
              );
            }),
      ),
    );
  }
}
