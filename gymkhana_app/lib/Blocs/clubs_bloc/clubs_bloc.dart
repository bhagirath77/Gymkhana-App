import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

part 'clubs_state.dart';

part 'clubs_event.dart';

class ClubsBloc extends Bloc<ClubSelectEvent, ClubsListState> {
  ClubsBloc() : super(ClubsListState.initial());

  static const List<String> _cult = ['Drama', 'Dance'];
  static const List<String> _science = ['Programming CLub', 'Astronomy Club'];
  static  const List<String> _campusLife=['Informals','Dining'];
  static const List<String> _acads= ['Placement Cell','MUN'];
  static const List<String> _sports = ['Cricket','Football'];
  static const List<String> _design = ['Arts','Photoshop'];

  @override
  Stream<ClubsListState> mapEventToState(ClubSelectEvent event) async* {
    if(event is ClearAll){
      yield ClubsListState.initial();
    }
    if (event is SocietyChanged) {
      yield* _societyChangedToState(event);
    }
  }
  Stream<ClubsListState> _societyChangedToState(SocietyChanged event) async* {
    switch (event.society) {
      case 'Cult and Lit':
        yield ClubsListState.clubsLoaded(society: event.society, clubs: _cult,selected:event.selected );
        break;
      case 'Science and Tech':
        yield ClubsListState.clubsLoaded(society: event.society, clubs: _science,selected:event.selected );
        break;
      case 'Campus Life':
        yield ClubsListState.clubsLoaded(society: event.society, clubs: _campusLife,selected:event.selected );
        break;
      case 'Academics and Career':
        yield ClubsListState.clubsLoaded(society: event.society, clubs: _acads,selected:event.selected );
        break;
      case 'Sports and Games':
        yield ClubsListState.clubsLoaded(society: event.society, clubs: _sports,selected:event.selected );
        break;
      case 'Design and Arts':
        yield ClubsListState.clubsLoaded(society: event.society, clubs: _design,selected:event.selected );
        break;
      default : yield ClubsListState.initial();
    }
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
