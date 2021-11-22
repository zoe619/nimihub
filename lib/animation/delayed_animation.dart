import 'dart:async';

import 'package:flutter/material.dart';

class DelayedAnimation extends StatefulWidget {
  final Widget child;
  final int delayedDuration;
  final double animOffsetX;
  final double animOffsetY;
  final int animDuration;

  const DelayedAnimation(
      {Key key,
      this.delayedDuration,
      this.animOffsetX,
      this.animOffsetY,
      this.animDuration,
      this.child})
      : super(key: key);
  @override
  _DelayedAnimationState createState() => _DelayedAnimationState();
}

class _DelayedAnimationState extends State<DelayedAnimation>
    with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<Offset> animationOffset;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: widget.animDuration));
    final curve =
        CurvedAnimation(curve: Curves.decelerate, parent: animationController);
    animationOffset = Tween<Offset>(
            begin: Offset(widget.animOffsetX, widget.animOffsetY),
            end: Offset.zero)
        .animate(curve);

    if (widget.delayedDuration == null) {
      animationController.forward();
    } else {
      Timer(Duration(milliseconds: widget.delayedDuration), () {
        animationController.forward();
      });
    }
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      child: SlideTransition(
        position: animationOffset,
        child: widget.child,
      ),
      opacity: animationController,
    );
  }
}
