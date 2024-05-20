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
  @override
  FutureOr<void> onLoad() {
    _loadAllAnimation();
    return super.onLoad();
  }

  void _loadAllAnimation() {
    idleAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache("Main Characters/Ninja Frog/Idle (32x32).png"),
      SpriteAnimationData.sequenced(
        amount: ActorSetting.ninjaFrogAmount,
        stepTime: ActorSetting.ninjaFrogStepTime,
        textureSize: Vector2.all(32),
      ),
    );

    jumpAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache("Main Characters/Ninja Frog/Jump (32x32).png"),
      SpriteAnimationData.sequenced(
        amount: ActorSetting.ninjaFrogAmount,
        stepTime: ActorSetting.ninjaFrogStepTime,
        textureSize: Vector2.all(32),
      ),
    );

    runAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache("Main Characters/Ninja Frog/Run (32x32).png"),
      SpriteAnimationData.sequenced(
        amount: ActorSetting.ninjaFrogAmount,
        stepTime: ActorSetting.ninjaFrogStepTime,
        textureSize: Vector2.all(32),
      ),
    );

    hitAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache("Main Characters/Ninja Frog/Hit (32x32).png"),
      SpriteAnimationData.sequenced(
        amount: ActorSetting.ninjaFrogAmount,
        stepTime: ActorSetting.ninjaFrogStepTime,
        textureSize: Vector2.all(32),
      ),
    );

    wallJumpAnimation = SpriteAnimation.fromFrameData(
      game.images.fromCache("Main Characters/Ninja Frog/Wall Jump (32x32).png"),
      SpriteAnimationData.sequenced(
        amount: ActorSetting.ninjaFrogAmount,
        stepTime: ActorSetting.ninjaFrogStepTime,
        textureSize: Vector2.all(32),
      ),
    );

    doubleJumpAnimation = SpriteAnimation.fromFrameData(
      game.images
          .fromCache("Main Characters/Ninja Frog/Double Jump (32x32).png"),
      SpriteAnimationData.sequenced(
        amount: ActorSetting.ninjaFrogAmount,
        stepTime: ActorSetting.ninjaFrogStepTime,
        textureSize: Vector2.all(32),
      ),
    );

//List out all Animation Available
    animations = {
      PlayerState.idle: idleAnimation,
      PlayerState.running: runAnimation,
    };

//Set Current Animation

    current = PlayerState.running;
  }
}
