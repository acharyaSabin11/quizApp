import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/utilities/dimensions.dart';

class BounceBackForthImage extends StatefulWidget {
  final String path;
  final Duration duration;
  final double imageHeight;
  final double xPos, yPos, xNeg, yNeg;
  bool stopAnimation;
  BounceBackForthImage({
    super.key,
    required this.path,
    required this.duration,
    required this.imageHeight,
    this.xPos = 0,
    this.yPos = 0,
    this.xNeg = 0,
    this.yNeg = 0,
    this.stopAnimation = false,
  });

  @override
  State<BounceBackForthImage> createState() => _BounceBackForthImageState();
}

class _BounceBackForthImageState extends State<BounceBackForthImage>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _offsetAnimation = TweenSequence(<TweenSequenceItem<Offset>>[
      TweenSequenceItem<Offset>(
        tween: Tween<Offset>(
            begin: const Offset(0, 0), end: Offset(widget.xPos, widget.yPos)),
        weight: 25,
      ),
      TweenSequenceItem<Offset>(
        tween: Tween<Offset>(
            begin: Offset(widget.xPos, widget.yPos), end: const Offset(0, 0)),
        weight: 25,
      ),
      TweenSequenceItem<Offset>(
        tween: Tween<Offset>(
            begin: const Offset(0, 0), end: Offset(widget.xNeg, widget.yNeg)),
        weight: 25,
      ),
      TweenSequenceItem<Offset>(
        tween: Tween<Offset>(
            begin: Offset(widget.xNeg, widget.yNeg), end: const Offset(0, 0)),
        weight: 25,
      ),
    ]).animate(_animationController);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.reset();
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.stopAnimation == false) {
      _animationController.forward();
    } else {
      _animationController.stop();
    }
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, value) {
          return Transform.translate(
            offset: _offsetAnimation.value,
            child: Image.asset(
              widget.path,
              height: widget.imageHeight,
            ),
          );
        });
  }
}
