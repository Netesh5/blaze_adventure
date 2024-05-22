// ignore_for_file: use_super_parameters, constant_pattern_never_matches_value_type

import 'dart:async';

import 'package:blaze_adventure/blaze_adventure.dart';
import 'package:blaze_adventure/core/actors_setting/actor_setting.dart';
import 'package:blaze_adventure/core/enums/player_direction.dart';
import 'package:blaze_adventure/core/enums/player_state.dart';
import 'package:flame/components.dart';

import 'package:flutter/services.dart';

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<BlazeAdventure>, KeyboardHandler {
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation jumpAnimation;
  late final SpriteAnimation hitAnimation;
  late final SpriteAnimation runAnimation;
  late final SpriteAnimation doubleJumpAnimation;
  late final SpriteAnimation wallJumpAnimation;
  late final SpriteAnimation fallAnimation;

  final String character;

  double speed = 100;
  double jump = 10;
  Vector2 velocity = Vector2.zero();

  bool isFacingRight = true;

  PlayerDirection playerDirection = PlayerDirection.left;

  Player({required this.character, position}) : super(position: position);
  @override
  FutureOr<void> onLoad() {
    _loadAllAnimation();
    return super.onLoad();
  }

  @override
  void update(double dt) {
    updatePlayerMovemnet(dt);
    super.update(dt);
  }

  void _loadAllAnimation() {
    idleAnimation = characterAnimation(
        state: "Idle", amount: ActorSetting.ninjaFrogIdelAmount);
    jumpAnimation = characterAnimation(
        state: "Jump", amount: ActorSetting.ninjaFrogJumpAmount);
    runAnimation = characterAnimation(
        state: "Run", amount: ActorSetting.ninjaFrogRunningAmount);
    hitAnimation = characterAnimation(
        state: "Hit", amount: ActorSetting.ninjaFrogHitAmount);
    wallJumpAnimation = characterAnimation(
        state: "Wall Jump", amount: ActorSetting.ninjaFrogWallJumpAmount);
    doubleJumpAnimation = characterAnimation(
        state: "Double Jump", amount: ActorSetting.ninjaFrogDoubleJumpAmount);
    fallAnimation = characterAnimation(
        state: "Fall", amount: ActorSetting.ninjaFrogFallAmount);

//List out all Animation Available
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runAnimation,
      PlayerState.doubleJump: doubleJumpAnimation,
      PlayerState.fall: fallAnimation,
      PlayerState.hit: hitAnimation,
      PlayerState.jump: jumpAnimation,
      PlayerState.wallJump: wallJumpAnimation,
    };

//Set Current Animation

    current = PlayerState.running;
  }

  SpriteAnimation characterAnimation(
      {required String state, required int amount}) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache("Main Characters/$character/$state (32x32).png"),
      SpriteAnimationData.sequenced(
        amount: amount,
        stepTime: ActorSetting.ninjaFrogStepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }

  void updatePlayerMovemnet(double dt) {
    double dx = 0.0;
    double dy = 0.0;
    switch (playerDirection) {
      case PlayerDirection.left:
        if (isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = false;
        }
        dx -= speed;
        current = PlayerState.running;
        break;
      case PlayerDirection.right:
        if (!isFacingRight) {
          flipHorizontallyAroundCenter();
          isFacingRight = true;
        }
        dx += speed;
        current = PlayerState.running;
        break;
      case PlayerDirection.jump:
        dy += jump;
        current = PlayerState.jump;
        break;
      case PlayerDirection.none:
        current = PlayerState.idle;
        break;
      default:
    }
    velocity = Vector2(dx, 0);
    position += velocity * dt;
  }

  @override
  bool onKeyEvent(KeyEvent event, Set<LogicalKeyboardKey> keysPressed) {
    final isLeftKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyA) ||
        keysPressed.contains(LogicalKeyboardKey.arrowLeft);
    final isRightKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyD) ||
        keysPressed.contains(LogicalKeyboardKey.arrowRight);
    final isJumpKeyPressed = keysPressed.contains(LogicalKeyboardKey.keyW) ||
        keysPressed.contains(LogicalKeyboardKey.arrowUp);

    if (isJumpKeyPressed && isRightKeyPressed) {
      playerDirection = PlayerDirection.none;
    } else if (isLeftKeyPressed) {
      playerDirection = PlayerDirection.left;
    } else if (isRightKeyPressed) {
      playerDirection = PlayerDirection.right;
    } else {
      playerDirection = PlayerDirection.none;
    }

    return super.onKeyEvent(event, keysPressed);
  }
}
