import 'package:gymkhana_app/Widgets/all_widgets.dart';

import 'view_post_page.dart';
import 'package:firebase_services/firebase_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymkhana_app/Blocs/post_bloc/post_bloc.dart';
import '../../constants.dart';

part 'edit_post_page.dart';

class PostView extends StatelessWidget {
  final PostItem _postItem;

  const PostView({Key key, PostItem postItem})
      : _postItem = postItem,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostBloc(_postItem),
      child: PostViewPage(),
    );
  }
}

class PostViewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  GestureDetector(
                    onTap: () => context
                        .bloc<PostBloc>()
                        .add(PostEditEvent(context.bloc<PostBloc>().postItem)),
                    child: Container(
                      margin: EdgeInsets.only(right: 20),
                      padding: EdgeInsets.all(17),
                      decoration: neumorphicBorderDecoration(context,borderRadius: 10,offset1: 6,spreadRadius: 0,blurRadius: 10,),
                      child: Text('Update',style: Theme.of(context).textTheme.subtitle2),
                    ),
                  ),

                ],
              ),
              SizedBox(height: 20,),
              BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  if (state is PostLoadingState) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is PostViewState) {
                    return ViewPostPage(state.postItem, currentTheme);
                  }
                  if (state is PostEditState) {
                    return Center(
                      child: EditPostPage(state.postItem),
                    );
                  }
                  return Text('Something went Wrong');
                },
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
