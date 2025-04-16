import 'package:flutter/gestures.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class ScrollControllerOverride extends ScrollController {
  final ScrollOverrideMethod overrideMethod;

  ScrollControllerOverride({
    super.initialScrollOffset,
    super.keepScrollOffset,
    super.debugLabel,
    super.onAttach,
    super.onDetach,
    required this.overrideMethod,
  });

  @override
  ScrollPosition createScrollPosition(
      ScrollPhysics physics,
      ScrollContext context,
      ScrollPosition? oldPosition,
      ) {
    return CustomScrollBottomSheetScrollPosition(
      overrideMethod: overrideMethod,
      physics: physics.applyTo(const AlwaysScrollableScrollPhysics()),
      context: context,
      oldPosition: oldPosition,
    );
  }

}

class CustomScrollBottomSheetScrollPosition extends ScrollPositionWithSingleContext {
  CustomScrollBottomSheetScrollPosition({
    required this.overrideMethod,
    required super.physics,
    required super.context,
    super.initialPixels = 0.0,
    super.keepScrollOffset,
    super.oldPosition,
    super.debugLabel,
  });

  final ScrollOverrideMethod overrideMethod;

  @override
  bool applyViewportDimension(double viewportDimension) {
    if (overrideMethod.applyViewportDimension != null) {
      return overrideMethod.applyViewportDimension!.call(viewportDimension, super.applyViewportDimension);
    } else {
      return super.applyViewportDimension(viewportDimension);
    }
  }

  @override
  bool applyContentDimensions(double minScrollExtent, double maxScrollExtent) {
    if (overrideMethod.applyContentDimensions != null) {
      return overrideMethod.applyContentDimensions!.call(minScrollExtent, maxScrollExtent, super.applyContentDimensions);
    } else {
      return super.applyContentDimensions(minScrollExtent, maxScrollExtent);
    }
  }

  @override
  void beginActivity(ScrollActivity? newActivity) {
    if (overrideMethod.beginActivity != null) {
      overrideMethod.beginActivity?.call(newActivity, super.beginActivity);
    } else {
      super.beginActivity(newActivity);
    }
  }

  @override
  void applyUserOffset(double delta) {
    if (overrideMethod.applyUserOffset != null) {
      overrideMethod.applyUserOffset?.call(delta, super.applyUserOffset);
    } else {
      super.applyUserOffset(delta);
    }
  }

  @override
  void updateUserScrollDirection(ScrollDirection value) {
    if (overrideMethod.updateUserScrollDirection != null) {
      overrideMethod.updateUserScrollDirection?.call(value, super.updateUserScrollDirection);
    } else {
      super.updateUserScrollDirection(value);
    }
  }

  @override
  void goBallistic(double velocity) {
    if (overrideMethod.goBallistic != null) {
      overrideMethod.goBallistic?.call(velocity, super.goBallistic);
    } else {
      super.goBallistic(velocity);
    }
  }

  @override
  Drag drag(DragStartDetails details, VoidCallback dragCancelCallback) {
    if (overrideMethod.drag != null) {
      return overrideMethod.drag!.call(details, dragCancelCallback, super.drag);
    } else {
      return super.drag(details, dragCancelCallback);
    }
  }

  @override
  void didUpdateScrollPositionBy(double delta) {
    if (overrideMethod.didUpdateScrollPositionBy != null) {
      overrideMethod.didUpdateScrollPositionBy!.call(delta, super.didUpdateScrollPositionBy);
    } else {
      super.didUpdateScrollPositionBy(delta);
    }
  }

  @override
  bool recommendDeferredLoading(BuildContext context) {
    if (overrideMethod.recommendDeferredLoading != null) {
      return overrideMethod.recommendDeferredLoading!.call(context, super.recommendDeferredLoading);
    } else {
      return super.recommendDeferredLoading(context);
    }
  }

  @override
  void goIdle() {
    if (overrideMethod.goIdle != null) {
      overrideMethod.goIdle!.call(super.goIdle);
    } else {
      super.goIdle();
    }
  }

  @override
  void pointerScroll(double delta) {
    if (overrideMethod.pointerScroll != null) {
      overrideMethod.pointerScroll!.call(delta, super.pointerScroll);
    } else {
      super.pointerScroll(delta);
    }
  }

  @override
  ScrollHoldController hold(VoidCallback holdCancelCallback) {
    if (overrideMethod.hold != null) {
      return overrideMethod.hold!.call(holdCancelCallback, super.hold);
    } else {
      return super.hold(holdCancelCallback);
    }
  }

  @override
  void applyNewDimensions() {
    if (overrideMethod.applyNewDimensions != null) {
      overrideMethod.applyNewDimensions!.call(super.applyNewDimensions);
    } else {
      super.applyNewDimensions();
    }
  }

  @override
  void absorb(ScrollPosition other) {
    if (overrideMethod.absorb != null) {
      overrideMethod.absorb!.call(other, super.absorb);
    } else {
      super.absorb(other);
    }
  }

  @override
  double setPixels(double newPixels) {
    if (overrideMethod.setPixels != null) {
      return overrideMethod.setPixels!.call(newPixels, super.setPixels);
    } else {
      return super.setPixels(newPixels);
    }
  }

  @override
  double applyBoundaryConditions(double value) {
    if (overrideMethod.applyBoundaryConditions != null) {
      return overrideMethod.applyBoundaryConditions!.call(value, super.applyBoundaryConditions);
    } else {
      return super.applyBoundaryConditions(value);
    }
  }
}

class ScrollOverrideMethod {
  final void Function(double delta, void Function(double delta) superMethod)? applyUserOffset;
  final void Function(ScrollActivity? newActivity, void Function(ScrollActivity? superMethod))? beginActivity;
  final void Function(double velocity, void Function(double velocity) superMethod)? goBallistic;
  final Drag Function(DragStartDetails details, VoidCallback dragCancelCallback, Drag Function(DragStartDetails details, VoidCallback dragCancelCallback) superMethod)? drag;
  final bool Function(double viewportDimension, bool Function(double viewportDimension) superMethod)? applyViewportDimension;
  final bool Function(double minScrollExtent, double maxScrollExtent, bool Function(double minScrollExtent, double maxScrollExtent) superMethod)? applyContentDimensions;
  final void Function(ScrollDirection value, void Function(ScrollDirection value) superMethod)? updateUserScrollDirection;
  final void Function(double delta, void Function(double delta) superMethod)? didUpdateScrollPositionBy;
  final bool Function(BuildContext context, bool Function(BuildContext context) superMethod)? recommendDeferredLoading;
  final void Function(void Function() superMethod)? goIdle;
  final void Function(double delta, void Function(double delta) superMethod)? pointerScroll;
  final ScrollHoldController Function(VoidCallback holdCancelCallback, ScrollHoldController Function(VoidCallback holdCancelCallback) superMethod)? hold;
  final void Function(void Function() superMethod)? applyNewDimensions;
  final void Function(ScrollPosition other, void Function(ScrollPosition other) superMethod)? absorb;
  final double Function(double newPixels, double Function(double newPixels) superMethod)? setPixels;
  final double Function(double value, double Function(double value) superMethod)? applyBoundaryConditions;

  ScrollOverrideMethod({this.applyUserOffset,
    this.beginActivity,
    this.goBallistic,
    this.drag,
    this.applyViewportDimension,
    this.applyContentDimensions,
    this.updateUserScrollDirection,
    this.didUpdateScrollPositionBy,
    this.recommendDeferredLoading,
    this.goIdle,
    this.hold,
    this.pointerScroll,
    this.applyNewDimensions,
    this.absorb,
    this.setPixels,
    this.applyBoundaryConditions,
  });
}