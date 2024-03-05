import "package:color_shift/data.dart";
import "package:flutter/material.dart";

enum TriangleOrientation {
  up, down;

  TriangleOrientation get next => switch (this) {
    up => down,
    down => up,
  };
}

enum TrianglePosition {
  topLeft, 
  topCenter, 
  topRight, 
  center,
  bottomLeft, 
  bottomCenter,
  bottomRight,
}

class Triangle extends StatelessWidget {
  final Hole centerHole;
  final List<Hole> holes;
  final void Function(Hole) onPressed;
  final TriangleOrientation orientation;
  const Triangle({
    required this.centerHole, 
    required this.holes,
    required this.orientation,
    required this.onPressed,
  });
 
  @override
  Widget build(BuildContext context) => switch (orientation) {
    TriangleOrientation.up => Column(children: [
      Expanded(child: Row(children: [const Spacer(), HoleWidget(hole: holes[0], onPressed: onPressed), const Spacer()])),
      const Spacer(),
      Expanded(child: Row(children: [const Spacer(), HoleWidget(hole: centerHole, onPressed: onPressed), const Spacer()])),
      const Spacer(),
      Expanded(child: Row(children: [HoleWidget(hole: holes[1], onPressed: onPressed), const Spacer(), HoleWidget(hole: holes[2], onPressed: onPressed)])),
    ],),
    TriangleOrientation.down => Column(children: [
      Expanded(child: Row(children: [HoleWidget(hole: holes[0], onPressed: onPressed), const Spacer(), HoleWidget(hole: holes[1], onPressed: onPressed)])),
      const Spacer(),
      Expanded(child: Row(children: [const Spacer(), HoleWidget(hole: centerHole, onPressed: onPressed), const Spacer()])),
      const Spacer(),
      Expanded(child: Row(children: [const Spacer(), HoleWidget(hole: holes[2], onPressed: onPressed), const Spacer()])),
    ],),
  };
}

class HoleWidget extends StatelessWidget {
  static const radius = 72.0;

  final Hole hole;
  final void Function(Hole) onPressed;
  HoleWidget({required this.hole, required this.onPressed}) : 
    super(key: ValueKey("${hole.ring},${hole.ball}"));

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () => onPressed(hole),
    child: Container(
      width: radius, 
      height: radius,
      foregroundDecoration: const ShapeDecoration(
        shape: CircleBorder(
          side: BorderSide(
            width: 2,
          ),
        ),
      ),
      decoration: ShapeDecoration(
        color: hole.ball.flutterColor,
        shape: CircleBorder(
          side: BorderSide(
            color: hole.ring.flutterColor, 
            width: 8,
          ),
        ),
      ),
    ),
  );
}
