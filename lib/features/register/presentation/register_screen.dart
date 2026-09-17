import 'package:code/core/common/auth/build_elevated_button.dart';
import 'package:code/core/common/auth/social_button.dart';
import 'package:code/core/route/app_routes.dart';
import 'package:code/core/util/auth_error.dart';
import 'package:code/core/util/helper_method.dart';
import 'package:code/features/register/data/bloc/register_bloc.dart';
import 'package:code/features/register/data/bloc/register_event.dart';
import 'package:code/features/register/data/bloc/register_state.dart';
import 'package:code/features/register/data/model/register_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      print('Name: ${_nameController.text}');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      final model=RegisterModel(name: _nameController.text.trim(), email: _emailController.text.trim(), password: _passwordController.text);
      context.read<RegisterBloc>().add(RegisterUserEvent(model));
      Navigator.pushNamed(context, AppRoutes.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child:BlocListener<RegisterBloc,RegisterState>(listener: (context,state){
            if(state is RegisterSuccess){
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.login,
                    (route) => false,
              );
            }
            if(state is GoogleSignSuccess){
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                    (route) => false,
              );
            }
            if(state is FaceBookSignSuccess){
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                    (route) => false,
              );
            }
            if(state is AppleSignSuccess){
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                    (route) => false,
              );
            }
            if(state is RegisterError){
              Navigator.pushNamedAndRemoveUntil(
                context,
                AppRoutes.home,
                    (route) => false,
              );
            }

          },child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 28),

                  // =====================================================
                  // TITLE
                  // =====================================================

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                        'Create Account',
                        style: theme.textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: colorScheme.onSurface
                        )
                    ),
                  ),

                  const SizedBox(height: 5),

                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      'Sign up to get started',
                      style:theme.textTheme.bodyMedium?.copyWith(
                          fontSize: 11,
                          color: colorScheme.onSurface.withOpacity(0.72)
                      ) ,
                    ),
                  ),

                  const SizedBox(height: 25),

                  // =====================================================
                  // FULL NAME
                  // =====================================================

                  _buildTextField(
                    controller: _nameController,
                    icon: Icons.person_outline,
                    label: 'Full Name',
                    hint: 'Enter your name',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  // =====================================================
                  // EMAIL
                  // =====================================================

                  _buildTextField(
                    controller: _emailController,
                    icon: Icons.mail_outline,
                    label: 'Email',
                    hint: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter your email';
                      }

                      if (!value.contains('@')) {
                        return 'Please enter a valid email';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  // =====================================================
                  // PASSWORD
                  // =====================================================

                  _buildTextField(
                    controller: _passwordController,
                    icon: Icons.lock_outline,
                    label: 'Password',
                    hint: 'Enter your password',
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 19
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }

                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 10),

                  // =====================================================
                  // CONFIRM PASSWORD
                  // =====================================================

                  _buildTextField(
                    controller: _confirmPasswordController,
                    icon: Icons.lock_outline,
                    label: 'Confirm Password',
                    hint: 'Confirm your password',
                    obscureText: _obscureConfirmPassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword =
                          !_obscureConfirmPassword;
                        });
                      },
                      icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          size: 19
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }

                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }

                      return null;
                    },
                  ),

                  const SizedBox(height: 25),

                  BlocBuilder<RegisterBloc,RegisterState>(builder:(context,state){
                    if (state is RegisterLoading){
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return buildElevatedButton(colorScheme,(){
                      _register();
                      },'Register');
                  },),



                  const SizedBox(height: 16),

                  Row(
                    children: [
                      Expanded(
                        child: Divider(
                          color: colorScheme.onSurface.withOpacity(0.11),
                        ),
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 12),
                        child: Text(
                          'or continue with',
                          style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 11,
                              color: colorScheme.onSurface.withOpacity(0.56)
                          ),
                        ),
                      ),

                      Expanded(
                        child: Divider(
                            color:  colorScheme.onSurface.withOpacity(0.11)
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  // =====================================================
                  // SOCIAL BUTTONS
                  // =====================================================

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      BlocBuilder<RegisterBloc,RegisterState>(builder:(context,state){
                        if (state is GoogleSignLoading){
                          return Center(
                            child: SizedBox(
                              height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth:2)),
                          );
                        }
                        return SocialButton(
                          icon: Icons.g_mobiledata,
                          onPressed: () {
                            context.read<RegisterBloc>().add(SignInWithGoogleEvent());
                          },
                        ) ;
                      }),


                      const SizedBox(width: 16),
                     BlocBuilder<RegisterBloc,RegisterState>(builder: (context,state){
                       if(state is FaceBookSignLoading){
                         return Center(
                           child: SizedBox(
                               height: 20,
                               width: 20,
                               child: CircularProgressIndicator(strokeWidth: 2)),
                         );
                       }
                       return  SocialButton(
                         icon: Icons.facebook,
                         onPressed: () {
                           context.read<RegisterBloc>().add(SignInWithFaceBookEvent());
                         },
                       );
                     }),


                      const SizedBox(width: 16),
                      BlocBuilder<RegisterBloc,RegisterState>(builder: (context,state){
                        if(state is AppleSignLoading){
                          return Center(
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(strokeWidth:2),
                            ),
                          );
                        }
                        return SocialButton(
                          icon: Icons.apple,
                          onPressed: () {
                            context.read<RegisterBloc>().add(SignInWithAppleEvent());
                          },
                        );
                      })


                    ],
                  ),

                  const SizedBox(height: 50),

                  // =====================================================
                  // LOGIN
                  // =====================================================

                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account? ',
                          style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 12,
                              color: colorScheme.onSurface.withOpacity(0.72)
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(context, AppRoutes.login);

                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.primary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),) ,
        ),
      ),
    );
  }



  // ================================================================
  // TEXT FIELD
  // ================================================================

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      style: const TextStyle(
        fontSize: 12,
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          icon,
          size: 19,

        ),
         suffixIcon: suffixIcon,

        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 10,
        ),

        hintText: hint,
        hintStyle: const TextStyle(
          fontSize: 10,

        ),

        contentPadding: const EdgeInsets.only(
          left: 0,
          right: 8,
          top: 7,
          bottom: 3,
        ),
      ),
    );
  }

  // ================================================================
  // SOCIAL BUTTON
  // ================================================================


}