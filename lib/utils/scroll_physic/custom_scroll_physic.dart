import 'package:flutter/material.dart';

class CustomScrollPhysics extends ScrollPhysics {
  final PageController _controller;

  const CustomScrollPhysics(this._controller, {ScrollPhysics? parent})
      : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(_controller, parent: buildParent(ancestor!));
  }

  @override
  double applyBoundaryConditions(ScrollMetrics position, double value) {
    assert(() {
      if (value == position.pixels) {
        throw  FlutterError(
            '$runtimeType.applyBoundaryConditions() was called redundantly.\n'
            'The proposed new position, $value, is exactly equal to the current position of the '
            'given ${position.runtimeType}, ${position.pixels}.\n'
            'The applyBoundaryConditions method should only be called when the value is '
            'going to actually change the pixels, otherwise it is redundant.\n'
            'The physics object in question was:\n'
            '  $this\n'
            'The position object in question was:\n'
            '  $position\n');
      }
      return true;
    }());
    if (value < position.pixels &&
        position.pixels <= position.minScrollExtent) {
      // underscroll
      debugPrint("ONE");
      // _controller.jumpTo(position.viewportDimension + value);
      return  value - position.minScrollExtent;
    }
    if (position.maxScrollExtent <= position.pixels &&
        position.pixels < value) {
      // overscroll

      debugPrint("Two $value");
      _controller.jumpTo(position.viewportDimension +
          (value - position.viewportDimension * 1.5));
       return value - position.maxScrollExtent;
    }
    if (value < position.minScrollExtent &&
        position.minScrollExtent < position.pixels){ // hit top edge

      debugPrint("Three");
      return value - position.minScrollExtent;}
    if (position.pixels < position.maxScrollExtent &&
        position.maxScrollExtent < value) { // hit bottom edge

      debugPrint("Four");
      return value - position.maxScrollExtent;
    }


    debugPrint("Five");
    return 0.0;
    }

}
