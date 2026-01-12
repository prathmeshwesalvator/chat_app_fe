import 'package:flutter/material.dart';

class CircularLogo extends StatefulWidget {
  const CircularLogo({
    super.key,
    required this.size,
    this.backgroundGradient,
    this.innerGradient,
    this.icon = Icons.message,
    this.iconColor,
    this.shadowColor,
    this.onTap,
    this.animate = false,
    this.animationDuration = const Duration(milliseconds: 300),
    this.hoverEffect = false,
    this.borderWidth = 0.0,
    this.borderColor,
    this.highlightColor,
    this.splashColor,
    this.iconSizeFactor = 0.28,
    this.backgroundColor,
    this.pulseAnimation = false,
    this.pulseDuration = const Duration(seconds: 2),
    this.elevation = 8.0,
    this.badge,
    this.badgeAlignment = Alignment.topRight,
  });

  /// Overall size of the logo
  final double size;

  /// Outer background gradient
  final Gradient? backgroundGradient;

  /// Inner circle gradient
  final Gradient? innerGradient;

  /// Center icon
  final IconData icon;

  /// Icon color (defaults to theme onPrimary)
  final Color? iconColor;

  /// Shadow / glow color
  final Color? shadowColor;

  /// Optional tap callback
  final VoidCallback? onTap;

  /// Whether to animate on mount
  final bool animate;

  /// Animation duration
  final Duration animationDuration;

  /// Enable hover effect
  final bool hoverEffect;

  /// Border width
  final double borderWidth;

  /// Border color
  final Color? borderColor;

  /// Highlight color when pressed
  final Color? highlightColor;

  /// Splash color
  final Color? splashColor;

  /// Icon size factor relative to logo size
  final double iconSizeFactor;

  /// Optional solid background color (overrides gradient if provided)
  final Color? backgroundColor;

  /// Enable pulsating animation
  final bool pulseAnimation;

  /// Duration for pulse animation
  final Duration pulseDuration;

  /// Elevation for Material widget
  final double elevation;

  /// Optional badge widget (e.g., notification count)
  final Widget? badge;

  /// Badge alignment
  final Alignment badgeAlignment;

  @override
  State<CircularLogo> createState() => _CircularLogoState();
}

class _CircularLogoState extends State<CircularLogo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<Color?> _colorAnimation;
  
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: widget.animate ? 0.0 : 1.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      ),
    );

    if (widget.pulseAnimation) {
      _pulseAnimation = Tween<double>(
        begin: 1.0,
        end: 1.1,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.easeInOut,
        ),
      )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            _controller.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _controller.forward();
          }
        });
    }

    if (widget.animate) {
      _controller.forward();
    }
    
    if (widget.pulseAnimation) {
      Future.delayed(widget.animationDuration, () {
        if (mounted && widget.pulseAnimation) {
          _controller.repeat(reverse: true);
        }
      });
    }
  }

  @override
  void didUpdateWidget(covariant CircularLogo oldWidget) {
    super.didUpdateWidget(oldWidget);
    
    if (oldWidget.pulseAnimation != widget.pulseAnimation) {
      if (widget.pulseAnimation && mounted) {
        _controller.repeat(reverse: true);
      } else {
        _controller.stop();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget _buildLogoContent() {
    final theme = Theme.of(context);
    final effectiveShadowColor = widget.shadowColor ?? theme.colorScheme.primary;
    final effectiveIconColor = widget.iconColor ?? theme.colorScheme.onPrimary;
    final effectiveBorderColor = widget.borderColor ?? theme.colorScheme.primary;
    
    return Stack(
      alignment: Alignment.center,
      children: [
        // OUTER GLOW CIRCLE with pulse animation
        ScaleTransition(
          scale: widget.pulseAnimation 
              ? _pulseAnimation 
              : AlwaysStoppedAnimation(1.0),
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: widget.backgroundGradient ??
                  LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      theme.colorScheme.primary.withOpacity(0.4),
                      theme.colorScheme.secondary.withOpacity(0.3),
                    ],
                  ),
              boxShadow: [
                BoxShadow(
                  color: effectiveShadowColor.withOpacity(0.35),
                  blurRadius: 32,
                  spreadRadius: 6,
                ),
              ],
            ),
          ),
        ),

        // MIDDLE GRADIENT CIRCLE
        Container(
          width: widget.size * 0.5,
          height: widget.size * 0.5,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: widget.innerGradient ??
                LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    theme.colorScheme.primary.withOpacity(0.45),
                    theme.colorScheme.secondary.withOpacity(0.35),
                  ],
                ),
          ),
        ),

        // MAIN LOGO CIRCLE
        Container(
          width: widget.size * 0.6,
          height: widget.size * 0.6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.backgroundColor ?? 
                theme.colorScheme.primary.withOpacity(0.85),
            border: widget.borderWidth > 0
                ? Border.all(
                    color: effectiveBorderColor,
                    width: widget.borderWidth,
                  )
                : null,
            boxShadow: [
              if (!_isPressed)
                BoxShadow(
                  color: effectiveShadowColor.withOpacity(0.4),
                  blurRadius: 18,
                  spreadRadius: 2,
                ),
              if (_isHovered && widget.hoverEffect)
                BoxShadow(
                  color: effectiveShadowColor.withOpacity(0.6),
                  blurRadius: 24,
                  spreadRadius: 4,
                ),
            ],
          ),
          child: Icon(
            widget.icon,
            size: widget.size * widget.iconSizeFactor,
            color: _isPressed 
                ? effectiveIconColor.withOpacity(0.8)
                : effectiveIconColor,
          ),
        ),

        // BADGE
        if (widget.badge != null)
          Positioned.fill(
            child: Align(
              alignment: widget.badgeAlignment,
              child: Transform.translate(
                offset: Offset(
                  widget.size * 0.15,
                  -widget.size * 0.15,
                ),
                child: widget.badge!,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final content = ScaleTransition(
      scale: _scaleAnimation,
      child: _buildLogoContent(),
    );

    // If no onTap provided, return just the logo
    if (widget.onTap == null) {
      return SizedBox(
        width: widget.size,
        height: widget.size,
        child: content,
      );
    }

    // Interactive logo with tap effects
    return MouseRegion(
      onEnter: (_) {
        if (widget.hoverEffect) {
          setState(() => _isHovered = true);
        }
      },
      onExit: (_) {
        if (widget.hoverEffect) {
          setState(() {
            _isHovered = false;
            _isPressed = false;
          });
        }
      },
      child: GestureDetector(
        onTapDown: (_) {
          if (widget.hoverEffect) {
            setState(() => _isPressed = true);
          }
        },
        onTapUp: (_) {
          if (widget.hoverEffect) {
            setState(() => _isPressed = false);
          }
          widget.onTap?.call();
        },
        onTapCancel: () {
          if (widget.hoverEffect) {
            setState(() => _isPressed = false);
          }
        },
        child: Material(
          color: Colors.transparent,
          elevation: widget.elevation,
          shape: const CircleBorder(),
          child: SizedBox(
            width: widget.size,
            height: widget.size,
            child: content,
          ),
        ),
      ),
    );
  }
}

// Example usage:
class EnhancedLogoExample extends StatelessWidget {
  const EnhancedLogoExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Basic logo
            const CircularLogo(
              size: 120,
              icon: Icons.chat,
            ),
            
            const SizedBox(height: 40),
            
            // Interactive logo with badge
            CircularLogo(
              size: 150,
              icon: Icons.notifications,
              onTap: () => print('Logo tapped!'),
              hoverEffect: true,
              animate: true,
              pulseAnimation: true,
              badge: Container(
                width: 24,
                height: 24,
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    '3',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Custom gradient logo
            CircularLogo(
              size: 100,
              backgroundGradient: const LinearGradient(
                colors: [Colors.purple, Colors.pink],
              ),
              innerGradient: const LinearGradient(
                colors: [Colors.blue, Colors.green],
              ),
              icon: Icons.settings,
              borderWidth: 2,
              borderColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}