import 'package:code/features/register/data/model/register_model.dart';
import 'package:equatable/equatable.dart';
abstract class RegisterEvent  extends Equatable{
}
class  RegisterUserEvent extends RegisterEvent{
  RegisterModel model;
  RegisterUserEvent(this.model);
  @override
  List<Object?> get props => [model];

}
class SignInWithGoogleEvent extends RegisterEvent{
  @override
  List<Object?> get props => [];

}
class SignInWithFaceBookEvent extends RegisterEvent{
  @override
  List<Object?> get props =>[];

}
class SignInWithAppleEvent extends RegisterEvent{
  @override
  List<Object?> get props => [];
}