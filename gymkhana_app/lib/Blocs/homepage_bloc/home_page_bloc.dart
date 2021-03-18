import 'package:equatable/equatable.dart';
import 'package:firebase_services/Services/Models/post.dart';
import 'package:firebase_services/firebase_repository.dart';
import 'package:bloc/bloc.dart';

part 'home_page_state.dart';

part 'home_page_event.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc(FirestoreRepository firestoreRepository)
      : _firestoreRepository = firestoreRepository,
        super(HomePageLoading());

  final FirestoreRepository _firestoreRepository;
  Stream<List<PostItem>> _postItems;

  var stopwatch = Stopwatch();

  Stream commentsStream(String id) {
    return _firestoreRepository.getCommentsStream(id);
  }

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is HomepageInit) {
      yield HomePageLoading();
      try {
        await Future<void>.delayed(Duration(seconds: 1));
        if (_postItems == null) {
          _postItems = _firestoreRepository.snapshotStream;
          print(_postItems.toString());
        }
        yield HomePageLoaded(_postItems);
      } catch (error) {
        print(error.toString());
        yield HomePageError();
      }
    }
    if (event is FilterEvent) {
      yield HomePageLoading();
      print(stopwatch.elapsed);
      try {
        var postItems = _firestoreRepository.searchPosts(
            searchTerm: event.text, clubName: event.club);
        if (await postItems.isEmpty || (postItems == null)) {
          yield HomePageEmpty();
        } else {
          print(stopwatch.elapsed);
          yield HomePageLoaded(postItems);
        }
      } catch (error) {
        print(error.toString());
        print('yielding home page error');
        yield HomePageError();
      }
    }
    if (event is TimerEvent) {
      print('waiting 8 seconds');
      if (stopwatch.elapsed > const Duration(seconds: 2)) {
        await Future.delayed(const Duration(seconds: 8));
      }

      print('waited 8 seconds');
      if (stopwatch.elapsed > const Duration(seconds: 8)) {
        yield HomePageEmpty();
      }
    }
  }
}
