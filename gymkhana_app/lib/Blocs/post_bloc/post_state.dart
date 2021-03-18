part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostLoadingState extends PostState {}

class PostViewState extends PostState {
  final PostItem _postItem;
  final bool lightTheme;

  PostItem get postItem => _postItem;

  const PostViewState({@required PostItem postItem, @required bool lightTheme})
      : assert(postItem != null),
        _postItem = postItem,
        this.lightTheme = lightTheme;
}

class PostEditState extends PostState {
  final PostItem _postItem;

  PostItem get postItem => _postItem;

  const PostEditState({@required PostItem postItem}) : _postItem = postItem;
}
