import "package:a_star/a_star.dart";

import "package:color_shift/data.dart";
import "package:color_shift/models.dart";

class StateBuilder extends BuilderModel<ColorShiftState> {
  late ColorShiftState state;
  int currentIndex = 0;
  String? errorText;
  bool isLoading = false;
  List<String>? steps;

  StateBuilder() { reset(); }

  late final allColors = Set<PuzzleColor>.from(PuzzleColor.values);

  @override
  bool get isReady => errorText == null;

  @override
  ColorShiftState get value => state;

  Hole get currentHole => state.holes[currentIndex];
  List<Hole> get currentNeighbors => state.getNeighborHoles(currentHole);
  bool get isLastPage => currentIndex == state.holes.length - 1;

  void next() {
    currentIndex++;
    notifyListeners();
  }

  void prev() {
    currentIndex--;
    notifyListeners();
  }

  void setColor(PuzzleColor color) {
    state.holes[currentIndex].ball = color;
    final ballToRing = <PuzzleColor, PuzzleColor>{};
    for (final hole in state.holes) {
      final ball = hole.ball;
      final ring = ballToRing[ball];
      if (ring != null) {
        errorText = "The $ring and ${hole.ring} rings are both set to $ball";
        notifyListeners();
        return;
      }
      ballToRing[ball] = hole.ring;
    }
    errorText = null;
    notifyListeners();
  }
  
  void save() { 
    state.finalize();
    state.desperate = 0;
    ColorShiftState? result;
    while (result == null) {
      isLoading = true;
      notifyListeners();
      result = aStar(state, limit: 10000000);  // 10 million
      isLoading = false;
      if (result == null) {
        if (state.desperate >= 20) {
          break;
        } else {
          state.desperate++;
          continue;
        }
      }
    }
    if (result == null) {
      errorText = "Could not solve the puzzle";
      notifyListeners();
      return;
    }
    final path = result.reconstructPath();
    if (path.isEmpty) {
      errorText = state.heuristic! == 0 ? "The puzzle is already solved!" : "You must make an illegal move to solve";
      notifyListeners();
      return;
    }
    steps = [
      for (final step in path)
        step.toString(),
    ];
    notifyListeners();
  }

  void clearSolution() {
    steps = null;
    notifyListeners();
  }

  void reset() {
    currentIndex = 0;
    errorText = null;
    isLoading = false;
    steps = null;
    state = ColorShiftState(holes: [
      for (final color in PuzzleColor.values)
        Hole(ring: color, ball: color),
    ],);
    notifyListeners();
  }
}
