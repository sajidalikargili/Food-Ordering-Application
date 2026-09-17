import 'package:code/features/register/data/bloc/register_event.dart';
import 'package:code/features/register/data/bloc/register_state.dart';
import 'package:code/features/register/data/service/register_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterService registerService;

  RegisterBloc({required this.registerService}) : super(RegisterInitial()) {
    on<RegisterUserEvent>(_registerUser);
    on<SignInWithAppleEvent>(_signWithApple);
    on<SignInWithFaceBookEvent>(_signWtihFacebook);
    on<SignInWithGoogleEvent>(_signWithGoogle);
  }

  void _registerUser(RegisterUserEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());
    try {
     await registerService.register(event.model);
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterError(e.toString()));
    }
  }

  void _signWithGoogle(SignInWithGoogleEvent event, Emitter<RegisterState> emit) async {
     emit(GoogleSignLoading());
     try{
      final userCredential= await  registerService.signInWithGoogle();
      if(userCredential==null){
        emit(RegisterInitial());
        return;
      }
       emit(GoogleSignSuccess());
     }catch(e){
       emit(RegisterError(e.toString()));
     }

  }

  void _signWtihFacebook(
    SignInWithFaceBookEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(FaceBookSignLoading());
   try{
    final userCredential= await registerService.signInWithFacebook();
    if(userCredential==null){
      emit(RegisterInitial());
      return;
    }
     emit(FaceBookSignSuccess());
   }catch(e){
      emit(RegisterError(e.toString()));
   }

  }

  void _signWithApple(SignInWithAppleEvent event, Emitter<RegisterState> emit) async {
     emit(AppleSignLoading());
     try{
     final userCredential=  await  registerService.signInWithApple();
     if(userCredential==null){
       emit(RegisterInitial());
       return;
     }
       emit(AppleSignSuccess());
     }catch(e){
       emit(RegisterError(e.toString()));
     }

  }
}
