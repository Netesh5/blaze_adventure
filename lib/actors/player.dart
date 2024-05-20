import 'dart:async';

import 'package:blaze_adventure/blaze_adventure.dart';
import 'package:blaze_adventure/core/actors_setting/actor_setting.dart';
import 'package:flame/components.dart';

class Player extends SpriteAnimationGroupComponent
    with HasGameRef<BlazeAdventure> {
  late final SpriteAnimation idleAnimation;
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
  }
}
