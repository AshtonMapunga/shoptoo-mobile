import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoptoo/core/utils/helpers.dart';
import 'package:shoptoo/features/auth/data/datasource/firebase_data_source_impl.dart';
import 'package:shoptoo/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:shoptoo/features/auth/domain/repositories/auth_repository.dart';
import 'package:shoptoo/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:shoptoo/features/auth/screens/login_screen.dart';
import 'package:shoptoo/features/layouts/screens/home_screen.dart';
import 'package:shoptoo/shared/themes/colors.dart';
import 'package:shoptoo/shared/widgets/buttons/primary_button.dart';
import 'package:shoptoo/shared/widgets/buttons/social_button.dart';
import 'package:shoptoo/shared/widgets/inputs/password_input.dart';
import 'package:shoptoo/shared/widgets/inputs/text_input.dart';


final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepositoryImpl(
  FirebaseAuthDataSourceImpl(FirebaseAuth.instance),
);
});


final signUpUseCaseProvider = Provider<SignUpUseCase>((ref) {
  final repository = ref.read(authRepositoryProvider);
  return SignUpUseCase(repository);
});


class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;



      Future<void> signUp() async {
    setState(() => _isLoading = true);
    try {
      final useCase = ref.read(signUpUseCaseProvider);
      final user = await useCase(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign up successful! Check your email to verify.')),
      );

                                          GeneralHelpers.temporaryNavigator(context, const SignUpScreen());

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignUp() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      // Simulate API call
      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          _isLoading = false;
        });
        // Navigate to home screen after successful signup
        GeneralHelpers.temporaryNavigator(context, const HomeScreen());
      });
    }
  }

  Widget _buildGoogleIcon() {
    return Image.asset(
      'assets/icons/google_icon.png',
      height: 24,
      width: 24,
      errorBuilder: (context, error, stackTrace) {
        return const Icon(
          Icons.g_mobiledata,
          size: 32,
          color: Colors.red,
        );
      },
    );
  }

  Widget _buildFacebookIcon() {
    return Image.asset(
      'assets/icons/facebook_icon.png',
      height: 24,
      width: 24,
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          Icons.facebook,
          size: 24,
          color: Colors.blue.shade700,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // White Background with animated half circles
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.white,
            child: Stack(
              children: [
                // Top right animated half circle
                Positioned(
                  top: -100,
                  right: -100,
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.easeInOut,
                    builder: (context, double value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Pallete.secondaryColor.withOpacity(0.15),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Secondary top right circle
                Positioned(
                  top: -80,
                  right: -80,
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 1800),
                    curve: Curves.easeInOut,
                    builder: (context, double value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Pallete.secondaryColor.withOpacity(0.1),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Bottom left animated half circle
                Positioned(
                  bottom: -100,
                  left: -100,
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 1500),
                    curve: Curves.easeInOut,
                    builder: (context, double value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          width: 250,
                          height: 250,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Pallete.secondaryColor.withOpacity(0.15),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                // Secondary bottom left circle
                Positioned(
                  bottom: -80,
                  left: -80,
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: const Duration(milliseconds: 1800),
                    curve: Curves.easeInOut,
                    builder: (context, double value, child) {
                      return Transform.scale(
                        scale: value,
                        child: Container(
                          width: 200,
                          height: 200,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Pallete.secondaryColor.withOpacity(0.1),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          // Content
          SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40),

                    

                      // Create Account Text
                      Text(
                        'Create Account',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: Pallete.lightPrimaryTextColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Sign up to get started',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Pallete.lightPrimaryTextColor.withOpacity(0.7),
                        ),
                      ),
                      const SizedBox(height: 40),

                  

                      // Email Field using TextInputField component
                      TextInputField(
                        label: 'Email',
                        hintText: 'Enter your email',
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        prefixIcon: Icons.email_outlined,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),

                      // Password Field using PasswordInputField component
                      PasswordInputField(
                        label: 'Password',
                        hintText: 'Create a password',
                        controller: _passwordController,
                      ),
                      const SizedBox(height: 30),

                      // Terms and Conditions Checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: true, // You might want to make this stateful
                            onChanged: (value) {
                              // Handle checkbox state
                            },
                            activeColor: Pallete.secondaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'I agree to the ',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Pallete.lightPrimaryTextColor.withOpacity(0.7),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Terms & Conditions',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Pallete.secondaryColor,
                                    ),
                                  ),
                                  TextSpan(
                                    text: ' and ',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      color: Pallete.lightPrimaryTextColor.withOpacity(0.7),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'Privacy Policy',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: Pallete.secondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),

                      // Sign Up Button using PrimaryButton component
                      PrimaryButton(
                        title: 'Sign Up',
                        onPressed: _isLoading ? null : signUp,
                        backgroundColor: Pallete.secondaryColor,
                        isLoading: _isLoading,
                      ),
                      const SizedBox(height: 30),

                      // Or Divider
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Pallete.lightPrimaryTextColor.withOpacity(0.3),
                              thickness: 1,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'Or continue with',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Pallete.lightPrimaryTextColor.withOpacity(0.6),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Pallete.lightPrimaryTextColor.withOpacity(0.3),
                              thickness: 1,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Social Sign Up Buttons using SocialLoginButton components
                      Row(
                        children: [
                          // Google Sign Up
                          SocialLoginButton(
                            text: 'Google',
                            icon: _buildGoogleIcon(),
                            onPressed: () {
                              // Handle Google sign up
                            },
                          ),
                          const SizedBox(width: 16),

                          // Facebook Sign Up
                          SocialLoginButton(
                            text: 'Facebook',
                            icon: _buildFacebookIcon(),
                            onPressed: () {
                              // Handle Facebook sign up
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Login Link
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Already have an account? ",
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Pallete.lightPrimaryTextColor.withOpacity(0.7),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              GeneralHelpers.temporaryNavigator(
                                context,
                                const LoginScreen(),
                              );
                            },
                            child: Text(
                              'Login',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Pallete.secondaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}