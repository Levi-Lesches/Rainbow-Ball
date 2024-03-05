import "hole.dart";
import "package:a_star/a_star.dart";

class ColorShiftTransition extends AStarTransition<ColorShiftState> {
  final PuzzleColor destination;
  ColorShiftTransition(super.parent, {required this.destination});

  @override
  String toString() => "Swap the hole with the $destination ring.";
}

class ColorShiftState extends AStarState<ColorShiftState> {
  final List<Hole> holes;
  ColorShiftState({required this.holes, super.depth = 0, super.transition});  
  factory ColorShiftState.from(ColorShiftState other, {required PuzzleColor ringColor}) => ColorShiftState(
    holes: [
      for (final hole in other.holes) Hole.from(hole),
    ],
    depth: other.depth + 1,
    transition: ColorShiftTransition(other, destination: ringColor),
  );

  Hole getRing(PuzzleColor color) => holes.firstWhere((x) => x.ring == color);
  Hole getBall(PuzzleColor color) => holes.firstWhere((x) => x.ball == color);
  Hole get clearHole => getBall(PuzzleColor.clear);
  Set<PuzzleColor> get neighborColors => clearHole.ring.ringNeighbors;
  List<Hole> getNeighborHoles(Hole hole) => [
    for (final ringColor in hole.ring.ringNeighbors)
      getRing(ringColor),
  ];

  void swap(Hole other) {
    final clear = clearHole;
    final otherColor = other.ball;
    other.ball = clear.ball;
    clear.ball = otherColor;
  }

  @override
  double calculateHeuristic() {
    var result = 0.0;
    for (final hole in holes) {
      if (hole.ball != hole.ring) result++;
      // if (hole.ball != hole.ring && !hole.ring.ringNeighbors.contains(hole.ball)) result++;
    }
    return result;
  }

  @override
  Iterable<ColorShiftState> getNeighbors() sync* {
    for (final color in neighborColors) {
      final copyState = ColorShiftState.from(this, ringColor: color);
      final hole = copyState.getRing(color);
      copyState.swap(hole);
      copyState.finalize();
      yield copyState;
    }
  }

  @override
  String hash() => [
    for (final color in PuzzleColor.values)
      "${color.index}:${getRing(color).ball.index}",
  ].join(",");

  int desperate = 0;
  @override
  bool isGoal() => holes.every((hole) => hole.ring == hole.ball)
    || heuristic! < desperate;
}
