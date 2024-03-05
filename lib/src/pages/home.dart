import "package:flutter/material.dart";

import "package:color_shift/models.dart";
import "package:color_shift/widgets.dart";

/// The home page.
class HomePage extends ReactiveWidget<HomeModel> {
  @override
  HomeModel createModel() => HomeModel();

  @override
  Widget build(BuildContext context, HomeModel model) => Scaffold(
    appBar: AppBar(title: Text(model.title)),
    body: Center(child: 
      SizedBox(
        height: 500, 
        width: 500, 
        child: Triangle(
          onPressed: model.swap,
          centerHole: model.state.clearHole,
          holes: model.state.getNeighborHoles(model.state.clearHole),
          orientation: model.orientation,
        ),
      ), 
    ),
  );
}
