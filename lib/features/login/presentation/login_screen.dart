import 'package:code/core/common/auth/build_elevated_button.dart';
import 'package:code/core/common/auth/social_button.dart';
import 'package:code/core/constant/app_colors.dart';
import 'package:code/core/route/app_routes.dart';
import 'package:code/core/util/helper_method.dart';
import 'package:code/features/login/data/login_model.dart';
import 'package:code/features/login/presentation/bloc/login_bloc.dart';
import 'package:code/features/login/presentation/bloc/login_event.dart';
import 'package:code/features/login/presentation/bloc/login_state.dart';
import 'package:code/features/register/data/bloc/register_bloc.dart';
import 'package:code/features/register/data/model/register_model.dart';
import 'package:code/features/theme/bloc/theme_bloc.dart';
import 'package:code/features/theme/bloc/theme_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      final model = LoginModel(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      context.read<LoginBloc>().add(LoginUserEvent(model: model));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              context.read<ThemeBloc>().add(ThemeToggleEvent());
            },
            icon: Icon(Icons.light_mode),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: BlocListener<LoginBloc, LoginState>(
                listener: (context, state) {
                  if (state is LoginSuccess) {
                    _passwordController.clear();
                    _emailController.clear();
                    // In splash screen
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.main,
                      (route) => false,
                    );
                  }
                  if (state is GoogleSignSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.main,
                          (route) => false,
                    );
                  }
                  if (state is FaceBookSignSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.main,
                          (route) => false,
                    );
                  }
                  if (state is AppleSignSuccess) {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      AppRoutes.main,
                          (route) => false,
                    );
                  }
                  if (state is LoginError) {
                    HelperMethod.show_toast(state.message);
                  }
                },
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ==========================================
                      // HEADER
                      // ==========================================
                      Text(
                        'Welcome Back 👋',
                        style: theme.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: colorScheme.onSurface,
                        ),
                      ),

                      const SizedBox(height: 6),

                      Text(
                        'Login to continue',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurface.withOpacity(0.65),
                        ),
                      ),

                      const SizedBox(height: 8),

                      // ==========================================
                      // FOOD IMAGE
                      // ==========================================
                      Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 130,
                          width: 190,
                          child: Image.asset(
                            'assets/jpg/images/burger_image.jpg',
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // ==========================================
                      // EMAIL
                      // ==========================================
                      Text(
                        'Email',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 7),

                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        decoration: const InputDecoration(
                          hintText: 'Enter your email',
                          prefixIcon: Icon(Icons.email_outlined),
                        ),
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

                      const SizedBox(height: 16),

                      // ==========================================
                      // PASSWORD
                      // ==========================================
                      Text(
                        'Password',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      const SizedBox(height: 7),

                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        textInputAction: TextInputAction.done,
                        decoration: InputDecoration(
                          hintText: 'Enter your password',

                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
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
                        onFieldSubmitted: (_) => _login(),
                      ),

                      const SizedBox(height: 8),

                      // ==========================================
                      // FORGOT PASSWORD
                      // ==========================================
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            // Navigate to forgot password screen
                          },
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                            minimumSize: const Size(0, 35),
                          ),
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: colorScheme.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 6),

                      // ==========================================
                      // LOGIN BUTTON
                      // ==========================================
                      BlocBuilder<LoginBloc, LoginState>(
                        builder: (context, state) {
                          if (state is LoginLoading) {
                            return Center(child: CircularProgressIndicator());
                          }
                          return buildElevatedButton(
                            colorScheme,
                            () => _login(),
                            "Login",
                          );
                        },
                      ),

                      const SizedBox(height: 20),

                      // ==========================================
                      // OR DIVIDER
                      // ==========================================
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: colorScheme.onSurface.withOpacity(0.12),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              'or continue with',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: colorScheme.onSurface.withOpacity(0.55),
                                fontSize: 11,
                              ),
                            ),
                          ),

                          Expanded(
                            child: Divider(
                              color: colorScheme.onSurface.withOpacity(0.12),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // ==========================================
                      // SOCIAL LOGIN
                      // ==========================================
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is GoogleSignLoading) {
                                return Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                );
                              }
                              return SocialButton(
                                icon: Icons.g_mobiledata,
                                onPressed: () {
                                  context.read<LoginBloc>().add(
                                    SignInWithGoogleEvent(),
                                  );
                                },
                              );
                            },
                          ),

                          const SizedBox(width: 16),
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is FaceBookSignLoading) {
                                return Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                );
                              }
                              return SocialButton(
                                icon: Icons.facebook,
                                onPressed: () {
                                  context.read<LoginBloc>().add(
                                    SignInWithFaceBookEvent(),
                                  );
                                },
                              );
                            },
                          ),

                          const SizedBox(width: 16),
                          BlocBuilder<LoginBloc, LoginState>(
                            builder: (context, state) {
                              if (state is AppleSignLoading) {
                                return Center(
                                  child: SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                );
                              }
                              return SocialButton(
                                icon: Icons.apple,
                                onPressed: () {
                                  context.read<LoginBloc>().add(
                                    SignInWithAppleEvent(),
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 24),

                      // ==========================================
                      // REGISTER
                      // ==========================================
                      Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Don't have an account? ",
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: colorScheme.onSurface.withOpacity(0.75),
                            ),
                            children: [
                              WidgetSpan(
                                alignment: PlaceholderAlignment.middle,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                      context,
                                      AppRoutes.register,
                                    );
                                  },
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      color: colorScheme.primary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
