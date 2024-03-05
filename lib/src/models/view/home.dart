import "package:color_shift/data.dart";
import "package:color_shift/widgets.dart";

import "../model.dart";

/// The view model for the home page.
class HomeModel extends ViewModel {
  /// The title of the app.
  final String title = "Home";

  final state = ColorShiftState(
    holes: [
      for (final color in PuzzleColor.values)
        Hole(ball: color, ring: color),
    ],
  );

  TriangleOrientation orientation = TriangleOrientation.up;

  void swap(Hole other) {
    state.swap(other);
    orientation = orientation.next;
    notifyListeners();
  }

  // final Hole center = Hole(ring: PuzzleColor.blue, ball: PuzzleColor.red);
  // final Hole hole1 = Hole(ring: PuzzleColor.green, ball: PuzzleColor.yellow);
  // final Hole hole2 = Hole(ring: PuzzleColor.black, ball: PuzzleColor.purple);
  // final Hole hole3 = Hole(ring: PuzzleColor.orange, ball: PuzzleColor.brown);
  // List<Hole> get holes => [hole1, hole2, hole3];
}
