import 'dart:async';

import 'package:blaze_adventure/levels/level.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class BlazeAdventure extends FlameGame {
  @override
  final world = Level();

  @override
  Color backgroundColor() => const Color(0xff211F30);

  @override
  FutureOr<void> onLoad() {
    addAll(
      [
        CameraComponent.withFixedResolution(
          width: 640,
          height: 360,
          world: world,
        )..viewfinder.anchor = Anchor.topLeft,
        world,
      ],
    );
    return super.onLoad();
  }
}
