import 'package:flutter/material.dart';

class ButtonPressEffectContainer extends StatefulWidget {
  final Widget child;
  final double height, width;
  final Function()? onTapFunction;
  const ButtonPressEffectContainer({
    super.key,
    required this.child,
    required this.height,
    required this.width,
    required this.onTapFunction,
  });

  @override
  State<ButtonPressEffectContainer> createState() =>
      _ButtonPressEffectContainerState();
}

class _ButtonPressEffectContainerState extends State<ButtonPressEffectContainer>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation scaleAnimation;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    scaleAnimation = TweenSequence<double>(<TweenSequenceItem<double>>[
      TweenSequenceItem<double>(
        tween: Tween(begin: 1.0, end: 0.95),
        weight: 50,
      ),
      TweenSequenceItem<double>(
        tween: Tween(begin: 0.95, end: 1.0),
        weight: 50,
      ),
    ]).animate(animationController);

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        animationController.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (animationController.status != AnimationStatus.completed) {
          animationController.reset();
        }
        animationController.forward();
        if (widget.onTapFunction != null) {
          widget.onTapFunction!();
        }
      },
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Container(
          height: widget.height,
          width: widget.width,
          child: Center(
            child: Transform.scale(
              scale: scaleAnimation.value,
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
