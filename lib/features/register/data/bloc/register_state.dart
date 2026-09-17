 import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {

}
class RegisterInitial extends RegisterState{
  @override
  List<Object?> get props => [];
}
class RegisterLoading extends RegisterState{
  @override
  List<Object?> get props => [];
}
 class GoogleSignLoading extends  RegisterState{
   @override
   // TODO: implement props
   List<Object?> get props => [];

 }
 class FaceBookSignLoading extends RegisterState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

 }
 class AppleSignLoading extends RegisterState{
  @override
  // TODO: implement props
  List<Object?> get props => [];

 }
class RegisterSuccess extends RegisterState{
  @override
  List<Object?> get props => [];
}
class GoogleSignSuccess extends RegisterState{
  @override
  List<Object?> get props => [];
}
class FaceBookSignSuccess extends RegisterState{
  @override
  List<Object?> get props => [];

}
class AppleSignSuccess extends RegisterState{
  @override
  List<Object?> get props => [];
}

class RegisterError extends RegisterState{
  final String message;
  RegisterError(this.message);
  @override
  List<Object?> get props => [message];
}
