import 'package:flutter/material.dart';

class ScrollPointerListener extends StatelessWidget {
  const ScrollPointerListener({
    super.key,
    this.onPointerCancel,
    this.onPointerUp,
    this.onPointerDown,
    required this.child,
  });

  final PointerCancelEventListener? onPointerCancel;
  final PointerUpEventListener? onPointerUp;
  final PointerDownEventListener? onPointerDown;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerCancel: onPointerCancel,
      onPointerUp: onPointerUp,
      onPointerDown: onPointerDown,
      child: child,
    );
  }
}
