part of 'new_post_bloc.dart';

class NewPostState extends Equatable {
  final String title;
  final String body;
  final bool feedback;

  bool get titleValid => title.length > 15 ? true : false;

  bool get bodyValid => body.length > 45 ? true : false;

  bool get formValid => (titleValid && bodyValid) ? true : false;

  NewPostState({this.title, this.body, this.feedback});

   NewPostState.pure()
      : title = '',
        body = '',
        feedback = true;

  NewPostState copyWith({String title, String body,bool feedback}) {
    return NewPostState(title: title ?? this.title, body: body ?? this.body,feedback: feedback ?? this.feedback);
  }

  @override
  List<Object> get props => [title, body];
}
