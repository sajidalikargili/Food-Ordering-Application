import 'package:code/features/login/data/login_model.dart';
import 'package:equatable/equatable.dart';
abstract class LoginEvent extends Equatable {

}
class LoginUserEvent extends LoginEvent {
  final LoginModel model;
  LoginUserEvent({required this.model});
  @override
  List<Object?> get props => [model];

}
class SignInWithGoogleEvent extends LoginEvent{
  @override
  List<Object?> get props => [];

}
class SignInWithFaceBookEvent extends LoginEvent{
  @override
  List<Object?> get props =>[];

}
class SignInWithAppleEvent extends LoginEvent{
  @override
  List<Object?> get props => [];
}