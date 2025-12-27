import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:lottie/lottie.dart';
import 'package:shoptoo/core/utils/helpers.dart';
import 'package:shoptoo/features/layouts/screens/home_screen.dart';
import 'package:shoptoo/shared/themes/colors.dart';

class VerifyEmailScreen extends StatefulWidget {
  final String email;
  
  const VerifyEmailScreen({
    Key? key,
    required this.email,
  }) : super(key: key);

  @override
  State<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  bool _isResending = false;
  bool _isVerifying = false;
  int _resendCooldown = 30;
  bool _cooldownActive = false;

    Timer? timer;
  bool isVerified = false;


  @override
  void initState() {
    super.initState();

        timer = Timer.periodic(const Duration(seconds: 3), (_) => checkEmailVerified());

    
    // Set up focus node listeners for auto-focus movement
    for (int i = 0; i < _controllers.length; i++) {
      _controllers[i].addListener(() {
        if (_controllers[i].text.length == 1 && i < _controllers.length - 1) {
          _focusNodes[i + 1].requestFocus();
        }
      });
      
      _focusNodes[i].addListener(() {
        if (_focusNodes[i].hasFocus) {
          _controllers[i].selection = TextSelection(
            baseOffset: 0,
            extentOffset: _controllers[i].text.length,
          );
        }
      });
    }
    
    // Start the resend cooldown
    _startCooldown();
  }


   Future<void> checkEmailVerified() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.reload(); // IMPORTANT: reload the user from Firebase
      final updatedUser = FirebaseAuth.instance.currentUser;
      if (updatedUser?.emailVerified ?? false) {
        timer?.cancel();
        if (mounted) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const HomeScreen()),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    for (var focusNode in _focusNodes) {
      focusNode.dispose();
    }
        timer?.cancel();

    super.dispose();
  }

  void _startCooldown() {
    setState(() {
      _cooldownActive = true;
    });
    
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        if (_resendCooldown > 1) {
          setState(() {
            _resendCooldown--;
          });
          _startCooldown();
        } else {
          setState(() {
            _cooldownActive = false;
            _resendCooldown = 30;
          });
        }
      }
    });
  }

  void _handleVerify() {
    final code = _controllers.map((c) => c.text).join();
    
    if (code.length != 4) {
      GeneralHelpers.showSnackBar(context, 'Please enter the complete 4-digit code');
      return;
    }
    
    setState(() {
      _isVerifying = true;
    });
    
    // Simulate API verification
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isVerifying = false;
        });
        // Navigate to success screen or home
        GeneralHelpers.showSnackBar(context, 'Email verified successfully!', isSuccess: true);
      }
    });
  }

  void _handleResendCode() {
    if (_cooldownActive) return;
    
    setState(() {
      _isResending = true;
    });
    
    // Simulate API call to resend code
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isResending = false;
        });
        _startCooldown();
        GeneralHelpers.showSnackBar(context, 'Verification code sent to ${widget.email}', isSuccess: true);
      }
    });
  }

  void _clearAllFields() {
    for (var controller in _controllers) {
      controller.clear();
    }
    _focusNodes[0].requestFocus();
  }

  String get _maskedEmail {
    final email = widget.email;
    if (email.length < 5) return email;
    
    final atIndex = email.indexOf('@');
    if (atIndex <= 2) return email;
    
    final firstPart = email.substring(0, 2);
    final lastPart = email.substring(atIndex);
    return '$firstPart***$lastPart';
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40),
                    
                    // Back Button
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.grey[100],
                        ),
                        child: const Icon(
                          Iconsax.arrow_left,
                          size: 20,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    
                    // Header Section
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Verify Your Email',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Pallete.lightPrimaryTextColor,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 12),
                        
                        Text(
                          'We sent a verification link to',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Pallete.lightPrimaryTextColor.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 4),
                        
                        Row(
                          children: [
                            Text(
                              _maskedEmail,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Pallete.secondaryColor,
                              ),
                            ),
                            const SizedBox(width: 8),
                          
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    

                    Center(
                      child: Lottie.asset(
                        'assets/animations/email_sent.json',
                        width: 250,
                        height: 250,
                        fit: BoxFit.contain,
                        repeat: false,            
                        reverse: false,          // play in reverse
                        animate: true,           // true = play automatically
                        frameRate: FrameRate.max, // speed of animation
                      ),
                    ),

          
              
                    const SizedBox(height: 30),
                    
                    // Resend Code Section
                    Column(
                      children: [
                        // Didn't receive code text
                        Text(
                          "Didn't receive the email?",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Pallete.lightPrimaryTextColor.withOpacity(0.7),
                          ),
                        ),
                        const SizedBox(height: 8),
                        
                        // Resend Button
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (_cooldownActive)
                              Text(
                                'Resend code in $_resendCooldown seconds',
                                style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              )
                            else
                              GestureDetector(
                                onTap: _handleResendCode,
                                child: Row(
                                  children: [
                                    if (_isResending)
                                      Container(
                                        width: 16,
                                        height: 16,
                                        margin: const EdgeInsets.only(right: 8),
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: Pallete.secondaryColor,
                                        ),
                                      )
                                    else
                                      Icon(
                                        Iconsax.refresh,
                                        size: 16,
                                        color: Pallete.secondaryColor,
                                      ),
                                    const SizedBox(width: 6),
                                    Text(
                                      'Resend Code',
                                      style: GoogleFonts.poppins(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Pallete.secondaryColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    
                    // Support Section
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Pallete.primaryColor.withOpacity(0.1),
                            ),
                            child: Icon(
                              Iconsax.info_circle,
                              size: 20,
                              color: Pallete.primaryColor,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Need help?',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Pallete.lightPrimaryTextColor,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Check your email address or contact support',
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: Pallete.lightPrimaryTextColor.withOpacity(0.6),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              // Open support
                            },
                            child: Text(
                              'Contact',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Pallete.primaryColor,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}