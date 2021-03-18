import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_services/Services/database_services.dart';
import 'package:firebase_services/firebase_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymkhana_app/constants.dart';

part 'post_state.dart';

part 'post_event.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostItem _postItem;

  PostItem get postItem => _postItem;
  final databaseService = DatabaseServices();

  PostBloc(this._postItem) : super(PostViewState(postItem: _postItem));

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is LoadPost) {
      yield PostLoadingState();
    }
    if (event is PostViewEvent) {
      yield PostViewState(postItem: event.postItem,lightTheme: currentTheme == 'light');
    }
    if (event is PostEditEvent) {
      yield PostEditState(postItem: event.postItem);
    }
  }
}
