import 'dart:async';
import 'dart:io';

import 'package:blaze_adventure/actors/player.dart';
import 'package:blaze_adventure/core/enums/player_direction.dart';
import 'package:blaze_adventure/levels/level.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class BlazeAdventure extends FlameGame with HasKeyboardHandlerComponents {
  Player player = Player();
  late JoystickComponent joystickComponent;

  bool showJoyStick = Platform.isAndroid || Platform.isIOS ? true : false;

  @override
  Color backgroundColor() => const Color(0xff211F30);

  @override
  FutureOr<void> onLoad() async {
    await images.loadAllImages();
    final world = Level(levelName: "Level-3", player: player);
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
    if (showJoyStick) {
      addJoyStick();
    }

    return super.onLoad();
  }

  @override
  void update(double dt) {
    if (showJoyStick) {
      updateJoyStick();
    }
    super.update(dt);
  }

  void addJoyStick() {
    joystickComponent = JoystickComponent(
      knob: SpriteComponent(
        sprite: Sprite(
          images.fromCache("joystick/knob.png"),
        ),
      ),
      background: SpriteComponent(
        sprite: Sprite(
          images.fromCache(
            "joystick/background.png",
          ),
        ),
      ),
      margin: const EdgeInsets.only(
        left: 20,
        bottom: 20,
      ),
    );
    add(joystickComponent);
  }

  void updateJoyStick() {
    switch (joystickComponent.direction) {
      case JoystickDirection.left:
        player.playerDirection = PlayerDirection.left;
        break;
      case JoystickDirection.right:
        player.playerDirection = PlayerDirection.right;
        break;
      case JoystickDirection.up:
        player.playerDirection = PlayerDirection.jump;
        break;
      default:
        player.playerDirection = PlayerDirection.none;
        break;
    }
  }
}
