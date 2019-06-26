import 'package:flutter/material.dart';

class ImplicitSlider extends StatefulWidget {
  final Offset beginOffset;
  final Offset endOffset;
  final Duration duration;
  final Curve curve;

  final Widget child;
  final bool visible;

  ImplicitSlider({
    this.beginOffset = const Offset(0, 1),
    this.endOffset = const Offset(0, 0),
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.easeOutBack,
    @required this.child,
    @required this.visible,
  });

  @override
  _ImplicitSliderState createState() => _ImplicitSliderState();
}

class _ImplicitSliderState extends State<ImplicitSlider>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _visibilityAnimation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: widget.duration);

    _visibilityAnimation =
        Tween<Offset>(begin: widget.beginOffset, end: widget.endOffset).animate(
            CurvedAnimation(curve: widget.curve, parent: _animationController));

    if (widget.visible) {
      _animationController.forward(from: _animationController.upperBound);
    }
  }

  @override
  void didUpdateWidget(ImplicitSlider oldWidget) {
    if (widget.visible != oldWidget.visible) {
      if (widget.visible) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SlideTransition(
      position: _visibilityAnimation,
      child: widget.child,
    ));
  }
}
