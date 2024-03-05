import "package:flutter/material.dart";

enum PuzzleColor {
  red(displayName: "Red"),
  pink(displayName: "Pink"),
  orange(displayName: "Orange"),
  yellow(displayName: "Yellow"),
  lightGreen(displayName: "Light Green"),
  green(displayName: "Green"),
  teal(displayName: "Teal"),
  darkGreen(displayName: "Dark Green"),
  seaGreen(displayName: "Turquoise"),
  lightBlue(displayName: "Light Blue"),
  blue(displayName: "Blue"),
  darkBlue(displayName: "Dark Blue"),
  purple(displayName: "Purple"),
  lightPurple(displayName: "Light Purple"),
  lightGrey(displayName: "Light grey"),
  darkGrey(displayName: "Dark grey"),
  black(displayName: "Black"),
  brown(displayName: "Brown"),
  white(displayName: "White"),
  clear(displayName: "Clear"),
  ;
  
  final String displayName;
  const PuzzleColor({required this.displayName});

  @override
  String toString() => displayName;

  Set<PuzzleColor> get ringNeighbors => switch(this) {
    PuzzleColor.red => {PuzzleColor.blue, PuzzleColor.orange, PuzzleColor.clear},
    PuzzleColor.pink => {PuzzleColor.lightBlue, PuzzleColor.lightGrey, PuzzleColor.lightGreen},
    PuzzleColor.orange => {PuzzleColor.darkGreen, PuzzleColor.white, PuzzleColor.red},
    PuzzleColor.yellow => {PuzzleColor.green, PuzzleColor.brown, PuzzleColor.clear},
    PuzzleColor.lightGreen => {PuzzleColor.teal, PuzzleColor.seaGreen, PuzzleColor.pink},
    PuzzleColor.green => {PuzzleColor.black, PuzzleColor.yellow, PuzzleColor.darkGrey},
    PuzzleColor.seaGreen => {PuzzleColor.lightGreen, PuzzleColor.lightPurple, PuzzleColor.black},
    PuzzleColor.lightBlue => {PuzzleColor.pink, PuzzleColor.brown, PuzzleColor.black},
    PuzzleColor.blue => {PuzzleColor.red, PuzzleColor.lightGrey, PuzzleColor.brown},
    PuzzleColor.teal => {PuzzleColor.darkGreen, PuzzleColor.lightGreen, PuzzleColor.darkBlue},
    PuzzleColor.darkGreen => {PuzzleColor.teal, PuzzleColor.orange, PuzzleColor.lightGrey},
    PuzzleColor.darkBlue => {PuzzleColor.white, PuzzleColor.teal, PuzzleColor.lightPurple},
    PuzzleColor.purple => {PuzzleColor.darkGrey, PuzzleColor.white, PuzzleColor.clear},
    PuzzleColor.lightPurple => {PuzzleColor.darkGrey, PuzzleColor.darkBlue, PuzzleColor.seaGreen},
    PuzzleColor.lightGrey => {PuzzleColor.blue, PuzzleColor.darkGreen, PuzzleColor.pink},
    PuzzleColor.darkGrey => {PuzzleColor.purple, PuzzleColor.lightPurple, PuzzleColor.green},
    PuzzleColor.white => {PuzzleColor.purple, PuzzleColor.orange, PuzzleColor.darkBlue},
    PuzzleColor.black => {PuzzleColor.lightBlue, PuzzleColor.seaGreen, PuzzleColor.green},
    PuzzleColor.brown => {PuzzleColor.blue, PuzzleColor.lightBlue, PuzzleColor.yellow},
    PuzzleColor.clear => {PuzzleColor.purple, PuzzleColor.red, PuzzleColor.yellow},
  };

  Color get flutterColor => switch (this) {
    PuzzleColor.red => Colors.red.shade800,
    PuzzleColor.pink => Colors.pink,
    PuzzleColor.orange => Colors.orange,
    PuzzleColor.yellow => Colors.yellow,
    PuzzleColor.lightGreen => Colors.lightGreen.shade300,
    PuzzleColor.green => Colors.green.shade400,
    PuzzleColor.darkGreen => Colors.green.shade800,
    PuzzleColor.seaGreen => Colors.greenAccent,
    PuzzleColor.lightBlue => Colors.cyan,
    PuzzleColor.blue => Colors.blue,
    PuzzleColor.teal => Colors.teal,
    PuzzleColor.darkBlue => Colors.indigo,
    PuzzleColor.purple => Colors.purple,
    PuzzleColor.lightPurple => Colors.deepPurple.shade100,
    PuzzleColor.lightGrey => Colors.grey.shade500,
    PuzzleColor.darkGrey => Colors.blueGrey.shade700,
    PuzzleColor.white => Colors.lime.shade100,
    PuzzleColor.black => Colors.black,
    PuzzleColor.brown => Colors.brown,
    PuzzleColor.clear => Colors.grey.shade300,
  };

  static void validate() {
    for (final color1 in values) {
      for (final color2 in color1.ringNeighbors) {
        if (!color2.ringNeighbors.contains(color1)) {
          throw StateError("Error with colors: $color1 is not a neighbor of $color2");
        }
      }
    }
  }
}

class Hole {
  final PuzzleColor ring;
  PuzzleColor ball;

  Hole({required this.ring, required this.ball});
  Hole.from(Hole other) : 
    ring = other.ring,
    ball = other.ball;

  @override
  String toString() => "$ring($ball)";
}
