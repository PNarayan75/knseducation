import 'package:flutter/material.dart';

class BlinkingRegisterButton extends StatefulWidget {
  final VoidCallback onTap;

  const BlinkingRegisterButton({super.key, required this.onTap});

  @override
  State<BlinkingRegisterButton> createState() => _BlinkingRegisterButtonState();
}

class _BlinkingRegisterButtonState extends State<BlinkingRegisterButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _blinkController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _borderAnimation;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    
    _scaleAnimation = TweenSequence<double>(
      [
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.1), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 1.1, end: 1.0), weight: 1),
      ],
    ).animate(_blinkController);
    
    _opacityAnimation = Tween(begin: 1.0, end: 0.7).animate(
      CurvedAnimation(
        parent: _blinkController,
        curve: Curves.easeInOut,
      ),
    );

    _borderAnimation = Tween<double>(begin: 1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _blinkController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _blinkController,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: child,
          ),
        );
      },
      child: ElevatedButton(
        onPressed: widget.onTap,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.2,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: const Color(0xFF000080), // Navy Blue
              width: _borderAnimation.value,
            ),
          ),
          elevation: 8,
          shadowColor: const Color(0xFFFF9933).withOpacity(0.5), // Saffron shadow
          surfaceTintColor: Colors.transparent,
          minimumSize: const Size(180, 56),
          // Gradient background
          // ignore: deprecated_member_use
          // onSurface: Colors.transparent,
        ).copyWith(
          backgroundColor: WidgetStateProperty.all(Colors.transparent),
          overlayColor: WidgetStateProperty.all(Colors.white.withOpacity(0.1)),
        ),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFFFF9933), // Saffron
                Color(0xFF138808), // Green
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _blinkController,
                  builder: (context, child) {
                    return ShaderMask(
                      shaderCallback: (bounds) {
                        return LinearGradient(
                          colors: const [
                            Color(0xFFFF9933), // Saffron
                            Color(0xFFFFFFFF), // White
                            Color(0xFF138808), // Green
                            Color(0xFF000080), // Navy Blue
                            Color(0xFFFF9933), // Saffron
                          ],
                          stops: const [
                            0.0,
                            0.25,
                            0.5,
                            0.75,
                            1.0,
                          ],
                          transform: GradientRotation(
                              _blinkController.value * 2 * 3.14159),
                        ).createShader(bounds);
                      },
                      child: const Text(
                        "REGISTER NOW",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.2,
                          color: Colors.white, // Base color for ShaderMask
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 8),
                // AnimatedBuilder(
                //   animation: _blinkController,
                //   builder: (context, child) {
                //     return ShaderMask(
                //       shaderCallback: (bounds) {
                //         return LinearGradient(
                //           colors: const [
                //             Color(0xFFFF9933), // Saffron
                //             Color(0xFFFFFFFF), // White
                //             Color(0xFF138808), // Green
                //             Color(0xFF000080), // Navy Blue
                //             Color(0xFFFF9933), // Saffron
                //           ],
                //           stops: const [
                //             0.0,
                //             0.25,
                //             0.5,
                //             0.75,
                //             1.0,
                //           ],
                //           transform: GradientRotation(
                //               _blinkController.value * 2 * 3.14159),
                //         ).createShader(bounds);
                //       },
                //       child: const Icon(
                //         Icons.arrow_forward,
                //         size: 18,
                //         color: Colors.white, // Base color for ShaderMask
                //       ),
                //     );
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}