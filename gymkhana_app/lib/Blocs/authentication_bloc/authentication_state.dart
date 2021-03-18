part of 'authentication_bloc.dart';

enum AuthStatus { authenticated, unauthenticated }

class AuthenticationState extends Equatable {
  const AuthenticationState._({
    this.status = AuthStatus.unauthenticated,
    this.user = CustomUser.empty
  });

  const AuthenticationState.unauthenticated() : this._();
  const AuthenticationState.authenticated(CustomUser user) : this._(status:AuthStatus.authenticated,user:user);

  final AuthStatus status;
  final CustomUser user;

  @override
  // TODO: implement props
  List<Object> get props => [status,user];
}