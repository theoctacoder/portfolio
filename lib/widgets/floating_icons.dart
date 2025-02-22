import 'dart:math';
import 'package:flutter/material.dart';
import 'package:portfolio/res/app_colors.dart';

class FloatingIconBackground extends StatelessWidget {
  const FloatingIconBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        20,
            (index) => Positioned.fill(
          child: AnimatedIcon(
            index: index,
          ),
        ),
      ),
    );
  }
}

class AnimatedIcon extends StatefulWidget {
  final int index;

  const AnimatedIcon({
    super.key,
    required this.index,
  });

  @override
  State<AnimatedIcon> createState() => _AnimatedIconState();
}

class _AnimatedIconState extends State<AnimatedIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  late double startX;
  late double startY;
  late double endX;
  late double endY;
  late double size;
  late double opacity;
  late IconData icon;

  final List<IconData> programmingIcons = [
    Icons.code,
    Icons.terminal,
    Icons.computer,
    Icons.webhook,
    Icons.api,
    Icons.developer_mode,
    Icons.memory,
    Icons.language,
    Icons.data_object,
    Icons.storage,
    Icons.coffee,
    Icons.code_off_sharp,
    Icons.cloud,
    Icons.adb,
    Icons.cookie_outlined,
    Icons.html_outlined,
  ];

  @override
  void initState() {
    super.initState();

    // Initialize random parameters
    final random = Random();
    startX = random.nextDouble() * 2 - 1;
    startY = random.nextDouble() * 2 - 1;
    endX = random.nextDouble() * 2 - 1;
    endY = random.nextDouble() * 2 - 1;
    size = random.nextDouble() * 20 + 30; // Size between 10 and 30
    opacity = random.nextDouble() * 0.3 + 0.1; // Opacity between 0.1 and 0.4
    icon = programmingIcons[random.nextInt(programmingIcons.length)];

    // Initialize animation
    _controller = AnimationController(
      duration: Duration(seconds: random.nextInt(10) + 15), // Duration between 15-25 seconds
      vsync: this,
    );

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );

    // Add listener for continuous animation
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // Reset position and restart
        setState(() {
          startX = endX;
          startY = endY;
          endX = random.nextDouble() * 2 - 1;
          endY = random.nextDouble() * 2 - 1;
        });
        _controller.reset();
        _controller.forward();
      }
    });

    // Start animation with delay based on index
    Future.delayed(Duration(milliseconds: widget.index * 500), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final currentX = startX + (endX - startX) * _animation.value;
        final currentY = startY + (endY - startY) * _animation.value;

        return Align(
          alignment: Alignment(currentX, currentY),
          child: Icon(
            icon,
            size: size,
            color: AppColors.primary.withOpacity(opacity),
          ),
        );
      },
    );
  }
}