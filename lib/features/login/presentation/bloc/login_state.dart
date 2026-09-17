import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {

}
class LoginInitial extends LoginState{
  @override
  List<Object?> get props => [];
}
class LoginLoading extends LoginState{
  @override
  List<Object?> get props => [];
}
class GoogleSignLoading extends  LoginState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class FaceBookSignLoading extends LoginState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class AppleSignLoading extends LoginState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

}
class LoginSuccess extends LoginState{
  @override
  List<Object?> get props => [];
}
class GoogleSignSuccess extends LoginState{
  @override
  List<Object?> get props => [];
}
class FaceBookSignSuccess extends LoginState{
  @override
  List<Object?> get props => [];

}
class AppleSignSuccess extends LoginState{
  @override
  List<Object?> get props => [];
}
class LoginError extends LoginState{
  String message;
   LoginError(this.message);
  @override
  List<Object?> get props => [message];
}
