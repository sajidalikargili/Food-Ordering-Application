import 'package:code/features/login/data/login_service.dart';
import 'package:code/features/login/presentation/bloc/login_event.dart';
import 'package:code/features/login/presentation/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent,LoginState> {
     final LoginService loginService;
      LoginBloc({required this.loginService}):super(LoginInitial()){
        on<LoginUserEvent>(_loginUser);
        on<SignInWithAppleEvent>(_signWithApple);
        on<SignInWithFaceBookEvent>(_signWtihFacebook);
        on<SignInWithGoogleEvent>(_signWithGoogle);
      }
      void _loginUser(LoginUserEvent event,Emitter<LoginState> emit) async{
          emit(LoginLoading());
          try{
            final userCredential =
            await loginService.login(event.model);

            if (userCredential == null) {
              // User cancelled Google sign-in
              emit(LoginInitial());
              return;
            }
           emit(LoginSuccess());
          } catch(e){
             emit(LoginError(e.toString()));
          }
      }
     void _signWithGoogle(SignInWithGoogleEvent event, Emitter<LoginState> emit) async {
       emit(GoogleSignLoading());
       try{
       final userCredential=  await  loginService.signInWithGoogle();
       if(userCredential==null){
         emit(LoginInitial());
         return;
       }
         emit(GoogleSignSuccess());
       }catch(e){
         emit(LoginError(e.toString()));
       }

     }

     void _signWtihFacebook(
         SignInWithFaceBookEvent event,
         Emitter<LoginState> emit,
         ) async {
       emit(FaceBookSignLoading());
       try{
       final userCredential=  await loginService.signInWithFacebook();
       if(userCredential==null){
         emit(LoginInitial());
         return;
       }
         emit(FaceBookSignSuccess());
       }catch(e){
         emit(LoginError(e.toString()));
       }

     }

     void _signWithApple(SignInWithAppleEvent event, Emitter<LoginState> emit) async {
       emit(AppleSignLoading());
       try{
       final userCredential=  await loginService.signInWithApple();
       if(userCredential==null){
         emit(LoginInitial());
         return;
       }
         emit(AppleSignSuccess());
       }catch(e){
         emit(LoginError(e.toString()));
       }

     }

}