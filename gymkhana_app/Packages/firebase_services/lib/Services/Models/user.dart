import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

class CustomUser extends Equatable {
  const CustomUser(
      {@required this.email,
      @required this.name,
      @required this.id,
      @required this.photoUrl})
      : assert(email != null),
        assert(id != null);

  final String email;
  final String id;
  final String name;
  final String photoUrl;

  @override
  // TODO: implement props
  List<Object> get props => [email, id, name, photoUrl];

  static const empty =
      CustomUser(email: '', id: '', name: null, photoUrl: null);
}
