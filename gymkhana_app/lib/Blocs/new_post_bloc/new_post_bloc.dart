import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_services/Services/database_services.dart';

part 'new_post_event.dart';

part 'new_post_state.dart';

class NewPostBloc extends Bloc<NewPostEvent,NewPostState > {

  NewPostBloc() : super(NewPostState.pure());

  final databaseServices = DatabaseServices();

  @override
  Stream<NewPostState> mapEventToState(NewPostEvent event) async*{
    if(event is TitleChanged){
      yield state.copyWith(title: event.title, body: null);
    }
    if(event is BodyChanged){
      yield state.copyWith(body: event.body);
    }
    if(event is FeedBackChanged){
      print('${event.feedback} from event ');
      yield state.copyWith(feedback: event.feedback);
    }
  }
}
