import "package:flutter/material.dart";

import "package:color_shift/data.dart";
import "package:color_shift/models.dart";
import "package:color_shift/pages.dart";
import "package:color_shift/services.dart";

Future<void> main() async {
  PuzzleColor.validate();
  await services.init();
  await models.init();
  runApp(const ColorShiftApp());
}

/// The main app widget.
class ColorShiftApp extends StatelessWidget {
  /// A const constructor.
  const ColorShiftApp();

  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: "Flutter Demo",
    theme: ThemeData(
      useMaterial3: true,
    ),
    routerConfig: router,
  );
}
