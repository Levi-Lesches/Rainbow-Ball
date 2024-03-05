import "package:go_router/go_router.dart";
export "package:go_router/go_router.dart";

import "src/pages/home.dart";
import "src/pages/state_editor.dart";

/// Contains all the routes for this app.
class Routes {
  /// The route for the home page.
  static const home = "/";
  static const editor = "/editor";
}

/// The router for the app.
final router = GoRouter(
  initialLocation: Routes.editor,
  routes: [
    GoRoute(
      path: Routes.home,
      name: Routes.home,
      builder: (_, __) => HomePage(),
    ),
    GoRoute(
      path: Routes.editor,
      name: Routes.editor,
      builder: (_, __) => StateEditor(),
    ),
  ],
);
