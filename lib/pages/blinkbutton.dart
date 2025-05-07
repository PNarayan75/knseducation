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

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    
    _scaleAnimation = TweenSequence<double>(
      [
        TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.05), weight: 1),
        TweenSequenceItem(tween: Tween(begin: 1.05, end: 1.0), weight: 1),
      ],
    ).animate(_blinkController);
    
    _opacityAnimation = Tween(begin: 1.0, end: 0.7).animate(
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
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          backgroundColor: Colors.deepOrangeAccent,
          foregroundColor: Colors.white,
          textStyle: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 6,
          shadowColor: Colors.deepOrange.withOpacity(0.4),
          surfaceTintColor: Colors.transparent,
          minimumSize: const Size(200, 60),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text("REGISTER NOW"),
            const SizedBox(width: 10),
            // const Icon(Icons.arrow_forward, size: 20),
          ],
        ),
      ),
    );
  }
}