part of 'clubs_bloc.dart';

class ClubsListState {
  final String society;
  final List<String> clubs;
  final String club;
  final int selected;

  const ClubsListState(
      {@required this.society, @required this.clubs, @required this.club, @required this.selected});

  const ClubsListState.initial()
      : this(society: null,
      clubs: const <String>[],
      club: 'Nothing selected',
      selected: 0);

  // const ClubsListState.societiesLoaded({@required List<String> societies})
  //     : this(
  //           societies: societies,
  //           society: null,
  //           clubs: const <String>[],
  //           club: null);

  const ClubsListState.clubsLoaded({@required String society, @required List<
      String> clubs, @required selected})
      : this(society: society, clubs: clubs, club: null, selected: selected);

  ClubsListState copyWith({List<String> societies,
    @required String society,
    @required List<String> clubs,
    @required int selected,
    String club}) {
    return ClubsListState(
        society: society ?? this.society,
        clubs: clubs ?? this.clubs,
        club: club ?? this.club, selected: selected);
  }
}
