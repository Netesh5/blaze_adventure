import 'dart:async';

import 'package:blaze_adventure/actors/player.dart';
import 'package:blaze_adventure/levels/level.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class BlazeAdventure extends FlameGame with HasKeyboardHandlerComponents {
  Player player = Player();

  @override
  Color backgroundColor() => const Color(0xff211F30);

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    final world = Level(levelName: "Level-1", player: player);
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
