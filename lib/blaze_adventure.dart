import 'dart:async';

import 'package:blaze_adventure/levels/level.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';

class BlazeAdventure extends FlameGame {
  @override
  final world = Level();
  @override
  FutureOr<void> onLoad() {
    add(CameraComponent(world: world));
    return super.onLoad();
  }
}
