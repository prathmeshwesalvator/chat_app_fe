import 'dart:ui';
import 'package:auto_route/auto_route.dart';
import 'package:chat_app_fe/app/global/enums/blocstatus.dart';
import 'package:chat_app_fe/app/global/routes/app_route.dart';
import 'package:chat_app_fe/app/view/features/Auth/ui/bloc/signup/signup_bloc.dart';
import 'package:chat_app_fe/app/view/features/Auth/ui/bloc/signup/signup_event.dart';
import 'package:chat_app_fe/app/view/features/Auth/ui/bloc/signup/signup_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class SignupPageMobile extends StatefulWidget {
  const SignupPageMobile({super.key});

  @override
  State<SignupPageMobile> createState() => _SignupPageMobileState();
}

class _SignupPageMobileState extends State<SignupPageMobile>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late final TextEditingController _usernameCtrl;
  late final TextEditingController _emailCtrl;
  late final TextEditingController _passCtrl;
  late final TextEditingController _confirmPassCtrl;
  late final TextEditingController _otpCtrl;

  // Animation controllers
  late final AnimationController _fadeController;
  late final AnimationController _slideController;
  late final AnimationController _orbController;
  late final AnimationController _fieldController;

  // Animations
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  late final Animation<double> _orbAnimation;
  late final Animation<double> _fieldAnimation;

  // State tracking
  bool _isEmailValid = false;
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Bloc status tracking to prevent multiple snackbars
  Blocstatus? _lastSendOtpStatus;
  Blocstatus? _lastVerifyOtpStatus;
  Blocstatus? _lastSignupStatus;

  // Email validation regex
  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _initializeAnimations();
    _emailCtrl.addListener(_validateEmail);
  }

  void _initializeControllers() {
    _usernameCtrl = TextEditingController();
    _emailCtrl = TextEditingController();
    _passCtrl = TextEditingController();
    _confirmPassCtrl = TextEditingController();
    _otpCtrl = TextEditingController();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _orbController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
    )..repeat(reverse: true);

    _fieldController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeOut,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
    );

    _orbAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _orbController, curve: Curves.easeInOut),
    );

    _fieldAnimation = CurvedAnimation(
      parent: _fieldController,
      curve: Curves.easeInOut,
    );

    _fadeController.forward();
    _slideController.forward();
  }

  void _validateEmail() {
    final email = _emailCtrl.text.trim();
    final isValid = _emailRegex.hasMatch(email) && email.isNotEmpty;

    if (isValid != _isEmailValid) {
      setState(() => _isEmailValid = isValid);
    }
  }

  void _animateFieldChange() {
    _fieldController.forward(from: 0.0);
  }

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _emailCtrl.dispose();
    _passCtrl.dispose();
    _confirmPassCtrl.dispose();
    _otpCtrl.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _orbController.dispose();
    _fieldController.dispose();
    super.dispose();
  }

  void _sendOtp() {
    if (!_isEmailValid) {
      _showErrorSnackBar('Please enter a valid email address');
      return;
    }

    HapticFeedback.lightImpact();
    context.read<SignupBloc>().add(
          SendOtp(email: _emailCtrl.text.trim()),
        );
  }

  void _verifyOtp() {
    final otp = _otpCtrl.text.trim();

    if (otp.isEmpty) {
      _showErrorSnackBar('Please enter the OTP');
      return;
    }

    if (otp.length < 4) {
      _showErrorSnackBar('OTP must be at least 4 digits');
      return;
    }

    HapticFeedback.lightImpact();
    context.read<SignupBloc>().add(
          VerifyOtp(
            email: _emailCtrl.text.trim(),
            otp: otp,
          ),
        );
  }

  void _submit(SignupState state) {
    if (!_formKey.currentState!.validate()) {
      _showErrorSnackBar('Please fill all required fields correctly');
      return;
    }

    if (state.verifyOtpStatus != Blocstatus.success) {
      _showErrorSnackBar('Please verify your email first');
      return;
    }

    final username = _usernameCtrl.text.trim();
    final password = _passCtrl.text.trim();

    if (username.length < 3) {
      _showErrorSnackBar('Username must be at least 3 characters');
      return;
    }

    if (password.length < 8) {
      _showErrorSnackBar('Password must be at least 8 characters');
      return;
    }

    if (password != _confirmPassCtrl.text.trim()) {
      _showErrorSnackBar('Passwords do not match');
      return;
    }

    HapticFeedback.lightImpact();
    context.read<SignupBloc>().add(
          SignUpSubmit(
            username: username,
            password: password,
            email: _emailCtrl.text.trim(),
          ),
        );
  }

  void _showErrorSnackBar(String message) {
    HapticFeedback.mediumImpact();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(CupertinoIcons.exclamationmark_circle, 
                color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void _showSuccessSnackBar(String message) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(CupertinoIcons.checkmark_circle_fill, 
                color: Colors.white, size: 20),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    return BlocConsumer<SignupBloc, SignupState>(
      listener: (context, state) {
        // Handle signup success
        if (state.signupStatus == Blocstatus.success &&
            _lastSignupStatus != Blocstatus.success) {
          _showSuccessSnackBar('Account created successfully!');
          Future.delayed(const Duration(milliseconds: 500), () {
            if (mounted) {
              context.router.replaceAll([const AppShellRoute()]);
            }
          });
        }

        // Handle OTP sent success
        if (state.sendOtpStatus == Blocstatus.success &&
            _lastSendOtpStatus != Blocstatus.success) {
          _showSuccessSnackBar('OTP sent to your email');
          _animateFieldChange();
        }

        // Handle OTP verification success
        if (state.verifyOtpStatus == Blocstatus.success &&
            _lastVerifyOtpStatus != Blocstatus.success) {
          _showSuccessSnackBar('Email verified successfully');
          _animateFieldChange();
        }

        // Handle errors - only show if status changed
        if (state.sendOtpStatus == Blocstatus.error &&
            _lastSendOtpStatus != Blocstatus.error) {
          _showErrorSnackBar(
            state.errorMessage.isNotEmpty
                ? state.errorMessage
                : 'Failed to send OTP. Please try again.',
          );
        }

        if (state.verifyOtpStatus == Blocstatus.error &&
            _lastVerifyOtpStatus != Blocstatus.error) {
          _showErrorSnackBar(
            state.errorMessage.isNotEmpty
                ? state.errorMessage
                : 'Invalid OTP. Please try again.',
          );
        }

        if (state.signupStatus == Blocstatus.error &&
            _lastSignupStatus != Blocstatus.error) {
          _showErrorSnackBar(
            state.errorMessage.isNotEmpty
                ? state.errorMessage
                : 'Failed to create account. Please try again.',
          );
        }

        // Update last status
        _lastSendOtpStatus = state.sendOtpStatus;
        _lastVerifyOtpStatus = state.verifyOtpStatus;
        _lastSignupStatus = state.signupStatus;
      },
      builder: (context, state) {
        final otpSent = state.sendOtpStatus == Blocstatus.success;
        final otpVerified = state.verifyOtpStatus == Blocstatus.success;

        return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  colors.primary,
                  colors.primaryContainer,
                  colors.secondary,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Stack(
              children: [
                // Animated floating orbs
                _buildAnimatedOrb(
                  animation: _orbAnimation,
                  top: -100,
                  right: -50,
                  size: 280,
                  color: colors.primaryContainer,
                  offsetMultiplier: 1.0,
                ),
                _buildAnimatedOrb(
                  animation: _orbAnimation,
                  bottom: -80,
                  left: -60,
                  size: 220,
                  color: colors.tertiary,
                  offsetMultiplier: -0.8,
                ),
                _buildAnimatedOrb(
                  animation: _orbAnimation,
                  top: size.height * 0.25,
                  right: -30,
                  size: 160,
                  color: colors.secondary,
                  offsetMultiplier: 0.6,
                ),

                SafeArea(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),

                      // App icon with liquid effect
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: _LiquidAppIcon(colors: colors),
                      ),

                      const SizedBox(height: 16),

                      // Title
                      FadeTransition(
                        opacity: _fadeAnimation,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                          child: Column(
                            children: [
                              Text(
                                "Create Account",
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  color: colors.onPrimary,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                "Join us today",
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: colors.onPrimary.withOpacity(0.85),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 24),

                      // Form container with glassomorphism - lifted up
                      Expanded(
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: FadeTransition(
                            opacity: _fadeAnimation,
                            child: _GlassContainer(
                              colors: colors,
                              child: SingleChildScrollView(
                                physics: const BouncingScrollPhysics(),
                                padding: const EdgeInsets.only(bottom: 20),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      // Username field
                                      _buildAnimatedField(
                                        child: _GlassTextField(
                                          controller: _usernameCtrl,
                                          labelText: "Username",
                                          prefixIcon: CupertinoIcons.person,
                                          colors: colors,
                                          enabled: !otpVerified,
                                          validator: (v) {
                                            if (v == null || v.trim().isEmpty) {
                                              return "Username is required";
                                            }
                                            if (v.trim().length < 3) {
                                              return "Minimum 3 characters required";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),

                                      const SizedBox(height: 14),

                                      // Email field - locked after verification
                                      _buildAnimatedField(
                                        child: _GlassTextField(
                                          controller: _emailCtrl,
                                          labelText: "Email",
                                          prefixIcon: CupertinoIcons.mail,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          colors: colors,
                                          enabled: !otpVerified,
                                          suffixIcon: _isEmailValid
                                              ? Icon(
                                                  CupertinoIcons
                                                      .checkmark_circle_fill,
                                                  color: otpVerified
                                                      ? Colors.green
                                                      : colors.primary,
                                                  size: 22,
                                                )
                                              : null,
                                          validator: (v) {
                                            if (v == null || v.trim().isEmpty) {
                                              return "Email is required";
                                            }
                                            if (!_emailRegex
                                                .hasMatch(v.trim())) {
                                              return "Enter a valid email";
                                            }
                                            return null;
                                          },
                                        ),
                                      ),

                                      const SizedBox(height: 14),

                                      // Send OTP button
                                      if (_isEmailValid && !otpSent)
                                        _buildAnimatedField(
                                          child: _GlassButton(
                                            onPressed:
                                                state.sendOtpStatus ==
                                                        Blocstatus.loading
                                                    ? null
                                                    : _sendOtp,
                                            isLoading: state.sendOtpStatus ==
                                                Blocstatus.loading,
                                            colors: colors,
                                            text: "Send Verification Code",
                                            icon: CupertinoIcons.mail_solid,
                                          ),
                                        ),

                                      // OTP field and verify button
                                      if (otpSent && !otpVerified) ...[
                                        _buildAnimatedField(
                                          child: _GlassTextField(
                                            controller: _otpCtrl,
                                            labelText: "Verification Code",
                                            prefixIcon: CupertinoIcons.lock_shield,
                                            keyboardType: TextInputType.number,
                                            colors: colors,
                                            maxLength: 6,
                                            validator: (v) {
                                              if (v == null ||
                                                  v.trim().isEmpty) {
                                                return "OTP is required";
                                              }
                                              if (v.trim().length < 4) {
                                                return "Enter a valid OTP";
                                              }
                                              return null;
                                            },
                                          ),
                                        ),
                                        const SizedBox(height: 14),
                                        _buildAnimatedField(
                                          child: _GlassButton(
                                            onPressed: state.verifyOtpStatus ==
                                                    Blocstatus.loading
                                                ? null
                                                : _verifyOtp,
                                            isLoading:
                                                state.verifyOtpStatus ==
                                                    Blocstatus.loading,
                                            colors: colors,
                                            text: "Verify Code",
                                            icon: CupertinoIcons.checkmark_shield,
                                          ),
                                        ),
                                      ],

                                      // Success indicator for verified email
                                      if (otpVerified)
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 14),
                                          child: FadeTransition(
                                            opacity: _fieldAnimation,
                                            child: ScaleTransition(
                                              scale: _fieldAnimation,
                                              child: _SuccessBadge(
                                                colors: colors,
                                                text: "Email Verified",
                                              ),
                                            ),
                                          ),
                                        ),

                                      // Password fields (only after OTP verification)
                                      if (otpVerified) ...[
                                        FadeTransition(
                                          opacity: _fieldAnimation,
                                          child: SlideTransition(
                                            position: Tween<Offset>(
                                              begin: const Offset(0, 0.1),
                                              end: Offset.zero,
                                            ).animate(_fieldAnimation),
                                            child: _GlassTextField(
                                              controller: _passCtrl,
                                              labelText: "Password",
                                              prefixIcon: CupertinoIcons.lock,
                                              obscureText: !_isPasswordVisible,
                                              colors: colors,
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  _isPasswordVisible
                                                      ? CupertinoIcons.eye_slash_fill
                                                      : CupertinoIcons.eye_fill,
                                                  color: colors.onSurfaceVariant,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _isPasswordVisible =
                                                        !_isPasswordVisible;
                                                  });
                                                  HapticFeedback.selectionClick();
                                                },
                                              ),
                                              validator: (v) {
                                                if (v == null || v.isEmpty) {
                                                  return "Password is required";
                                                }
                                                if (v.length < 8) {
                                                  return "Minimum 8 characters required";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 14),
                                        FadeTransition(
                                          opacity: _fieldAnimation,
                                          child: SlideTransition(
                                            position: Tween<Offset>(
                                              begin: const Offset(0, 0.1),
                                              end: Offset.zero,
                                            ).animate(_fieldAnimation),
                                            child: _GlassTextField(
                                              controller: _confirmPassCtrl,
                                              labelText: "Confirm Password",
                                              prefixIcon:
                                                  CupertinoIcons.lock_shield,
                                              obscureText:
                                                  !_isConfirmPasswordVisible,
                                              colors: colors,
                                              suffixIcon: IconButton(
                                                icon: Icon(
                                                  _isConfirmPasswordVisible
                                                      ? CupertinoIcons.eye_slash_fill
                                                      : CupertinoIcons.eye_fill,
                                                  color: colors.onSurfaceVariant,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _isConfirmPasswordVisible =
                                                        !_isConfirmPasswordVisible;
                                                  });
                                                  HapticFeedback.selectionClick();
                                                },
                                              ),
                                              validator: (v) {
                                                if (v == null || v.isEmpty) {
                                                  return "Please confirm password";
                                                }
                                                if (v != _passCtrl.text) {
                                                  return "Passwords do not match";
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                      ],

                                      // Submit button
                                      _GlassButton(
                                        onPressed: otpVerified
                                            ? () => _submit(state)
                                            : null,
                                        isLoading: state.signupStatus ==
                                            Blocstatus.loading,
                                        colors: colors,
                                        text: "Create Account",
                                        icon: CupertinoIcons.checkmark_alt,
                                        isPrimary: true,
                                      ),

                                      const SizedBox(height: 20),

                                      // Login redirect
                                      Center(
                                        child: TextButton(
                                          onPressed: () {
                                            HapticFeedback.lightImpact();
                                            context.router.pop();
                                          },
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 20,
                                              vertical: 12,
                                            ),
                                          ),
                                          child: Text(
                                            "Already have an account? Sign In",
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                              color: colors.primary,
                                              fontWeight: FontWeight.w600,
                                            ),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAnimatedOrb({
    required Animation<double> animation,
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required Color color,
    required double offsetMultiplier,
  }) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Positioned(
          top: top != null ? top + (animation.value * 20 * offsetMultiplier) : null,
          bottom: bottom != null
              ? bottom + (animation.value * 15 * offsetMultiplier)
              : null,
          left: left != null ? left + (animation.value * 15 * offsetMultiplier) : null,
          right: right != null
              ? right + (animation.value * 10 * offsetMultiplier)
              : null,
          child: _FloatingOrb(size: size, color: color),
        );
      },
    );
  }

  Widget _buildAnimatedField({required Widget child}) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: child,
    );
  }
}

// Glass container widget - Enhanced with better spacing
class _GlassContainer extends StatelessWidget {
  final Widget child;
  final ColorScheme colors;

  const _GlassContainer({
    required this.child,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 28, 20, 28),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors.surface.withOpacity(0.95),
                colors.surface.withOpacity(0.88),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
            border: Border.all(
              color: colors.onSurface.withOpacity(0.1),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

// Glass text field widget - Enhanced
class _GlassTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData prefixIcon;
  final bool obscureText;
  final ColorScheme colors;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool enabled;

  const _GlassTextField({
    required this.controller,
    required this.labelText,
    required this.prefixIcon,
    required this.colors,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.keyboardType,
    this.maxLength,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            color: enabled
                ? colors.surfaceContainerHighest.withOpacity(0.35)
                : colors.surfaceContainerHighest.withOpacity(0.15),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: enabled
                  ? colors.outline.withOpacity(0.25)
                  : colors.outline.withOpacity(0.1),
              width: 1.2,
            ),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            validator: validator,
            keyboardType: keyboardType,
            maxLength: maxLength,
            enabled: enabled,
            style: TextStyle(
              color: enabled ? colors.onSurface : colors.onSurface.withOpacity(0.6),
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(
                color: enabled
                    ? colors.onSurfaceVariant
                    : colors.onSurfaceVariant.withOpacity(0.5),
                fontSize: 14,
              ),
              prefixIcon: Icon(
                prefixIcon,
                color: enabled
                    ? colors.onSurfaceVariant
                    : colors.onSurfaceVariant.withOpacity(0.5),
                size: 20,
              ),
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
              counterText: maxLength != null ? "" : null,
              errorStyle: TextStyle(
                color: colors.error,
                fontSize: 11,
                height: 0.8,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Glass button widget - Enhanced with icon support
class _GlassButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final bool isLoading;
  final ColorScheme colors;
  final String text;
  final IconData? icon;
  final bool isPrimary;

  const _GlassButton({
    required this.onPressed,
    required this.isLoading,
    required this.colors,
    required this.text,
    this.icon,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null && !isLoading;

    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            gradient: isPrimary && !isDisabled
                ? LinearGradient(
                    colors: [
                      colors.primary,
                      colors.primaryContainer,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: isPrimary
                ? null
                : isDisabled
                    ? colors.surfaceContainerHighest.withOpacity(0.2)
                    : colors.surfaceContainerHighest.withOpacity(0.4),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: isPrimary
                  ? colors.primary.withOpacity(0.5)
                  : isDisabled
                      ? colors.outline.withOpacity(0.15)
                      : colors.outline.withOpacity(0.3),
              width: 1.5,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(14),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                alignment: Alignment.center,
                child: isLoading
                    ? SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2.5,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            isPrimary ? colors.onPrimary : colors.primary,
                          ),
                        ),
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (icon != null) ...[
                            Icon(
                              icon,
                              color: isPrimary
                                  ? colors.onPrimary
                                  : isDisabled
                                      ? colors.onSurface.withOpacity(0.3)
                                      : colors.primary,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                          ],
                          Text(
                            text,
                            style: TextStyle(
                              color: isPrimary
                                  ? colors.onPrimary
                                  : isDisabled
                                      ? colors.onSurface.withOpacity(0.3)
                                      : colors.primary,
                              fontSize: 15,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.3,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Success badge widget - Enhanced
class _SuccessBadge extends StatelessWidget {
  final ColorScheme colors;
  final String text;

  const _SuccessBadge({
    required this.colors,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.green.shade50,
            Colors.green.shade100,
          ],
        ),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.green.shade300,
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.checkmark_seal_fill,
            color: Colors.green.shade700,
            size: 20,
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              color: Colors.green.shade800,
              fontWeight: FontWeight.w700,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// Liquid app icon widget - Enhanced
class _LiquidAppIcon extends StatelessWidget {
  final ColorScheme colors;

  const _LiquidAppIcon({required this.colors});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                colors.onPrimary.withOpacity(0.35),
                colors.onPrimary.withOpacity(0.18),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: colors.onPrimary.withOpacity(0.35),
              width: 2.5,
            ),
          ),
          child: Icon(
            CupertinoIcons.person_crop_circle_badge_plus,
            color: colors.onPrimary,
            size: 44,
          ),
        ),
      ),
    );
  }
}

// Floating orb widget - Enhanced with better gradients
class _FloatingOrb extends StatelessWidget {
  final double size;
  final Color color;

  const _FloatingOrb({
    required this.size,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            color.withOpacity(0.45),
            color.withOpacity(0.25),
            color.withOpacity(0.08),
            color.withOpacity(0),
          ],
          stops: const [0.0, 0.4, 0.7, 1.0],
        ),
      ),
    );
  }
}