import "package:flutter/material.dart";

import "package:color_shift/data.dart";
import "package:color_shift/models.dart";
import "package:color_shift/widgets.dart";

class StateEditor extends ReactiveWidget<StateBuilder> {
  @override
  StateBuilder createModel() => StateBuilder();

  @override
  Widget build(BuildContext context, StateBuilder model) => model.steps == null ? PuzzleEditor(model) : StepsList(model);
  
}

class PuzzleEditor extends StatelessWidget {
  final StateBuilder model;
  const PuzzleEditor(this.model);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Editor"),
      actions: [
        IconButton(
          icon: const Icon(Icons.restore), 
          onPressed: model.reset,
        ),
        IconButton(
          icon: const Icon(Icons.code), 
          onPressed: () => showDialog<void>(
            context: context, 
            builder: (context) => AlertDialog(
              title: const Text("Puzzle hash"), 
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("This is the hash for your current state. Copy it to re-use later."),
                  const SizedBox(height: 24),
                  SelectableText(model.state.hash()),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () => context.pop(), 
                  child: const Text("Okay"),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
    body: Center(child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const Spacer(),
          Text(
            "Enter the ball color for each ring",
            style: context.textTheme.titleLarge,
          ),
          const SizedBox(height: 48),
          SizedBox(height: 200, width: 200, child: Triangle(
            orientation: TriangleOrientation.up,
            centerHole: model.currentHole,
            holes: model.currentNeighbors,
            onPressed: (_) {},
          ),),
          const Spacer(),
          Text(
            "Ring: ${model.currentHole.ring}, Ball: ${model.currentHole.ball}",
            style: context.textTheme.titleMedium,
          ),
          const SizedBox(height: 24),
          if (model.errorText != null) Text(
            model.errorText!, 
            style: context.textTheme.bodyLarge?.copyWith(color: Colors.red),
            textAlign: TextAlign.center,
          ),
          if (model.isLoading) const Text("Loading..."),
          const SizedBox(height: 24),
          Wrap(
            alignment: WrapAlignment.center,
            runAlignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: 24,
            runSpacing: 12,
            children: [
              for (final color in PuzzleColor.values) InkWell(
                onTap: () => model.setColor(color), 
                child: Container(
                  height: 72, 
                  width: 72, 
                  decoration: BoxDecoration(
                    color: color.flutterColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    color.displayName,
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelLarge?.copyWith(
                      color: ThemeData.estimateBrightnessForColor(color.flutterColor) == Brightness.light 
                        ? Colors.black : Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
        ],
      ),
    ),),
    persistentFooterButtons: [
      TextButton(
        onPressed: model.currentIndex == 0 ? null : model.prev,
        child: const Text("Back"),
      ),
      TextButton(
        onPressed: model.isLastPage ? null : model.next,
        child: const Text("Next"),
      ),
      ElevatedButton(
        onPressed: model.isReady ? model.save : null,
        child: const Text("Solve"),
      ),
    ],
  );
}

class StepsList extends StatelessWidget {
  final StateBuilder model;
  const StepsList(this.model);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Solution"), 
      leading: IconButton(
        icon: const Icon(Icons.arrow_back), 
        onPressed: model.clearSolution,
      ),
    ),
    body: Center(child: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        for (final (index, step) in model.steps!.enumerate)
          Text("Step ${index + 1}: $step", style: context.textTheme.bodyLarge),
      ],
    ),),
  );
}
