// ignore_for_file: use_super_parameters

import 'dart:async';

import 'package:blaze_adventure/blaze_adventure.dart';
import 'package:blaze_adventure/core/actors_setting/actor_setting.dart';
import 'package:blaze_adventure/core/enums/player_state.dart';
import 'package:flame/components.dart';

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<BlazeAdventure> {
  late final SpriteAnimation idleAnimation;
  late final SpriteAnimation jumpAnimation;
  late final SpriteAnimation hitAnimation;
  late final SpriteAnimation runAnimation;
  late final SpriteAnimation doubleJumpAnimation;
  late final SpriteAnimation wallJumpAnimation;
  late final SpriteAnimation fallAnimation;

  final String character;

  Player({required this.character, position}) : super(position: position);
  @override
  FutureOr<void> onLoad() {
    _loadAllAnimation();
    return super.onLoad();
  }

  void _loadAllAnimation() {
    idleAnimation = characterAnimation(state: "Idle");
    jumpAnimation = characterAnimation(state: "Jump");
    runAnimation = characterAnimation(state: "Run");
    hitAnimation = characterAnimation(state: "Hit");
    wallJumpAnimation = characterAnimation(state: "Wall Jump");
    doubleJumpAnimation = characterAnimation(state: "Double Jump");
    fallAnimation = characterAnimation(state: "Fall");

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

  SpriteAnimation characterAnimation({required String state}) {
    return SpriteAnimation.fromFrameData(
      game.images.fromCache("Main Characters/$character/$state (32x32).png"),
      SpriteAnimationData.sequenced(
        amount: ActorSetting.ninjaFrogIdelAmount,
        stepTime: ActorSetting.ninjaFrogStepTime,
        textureSize: Vector2.all(32),
      ),
    );
  }
}
