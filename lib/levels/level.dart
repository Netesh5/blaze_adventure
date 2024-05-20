import 'dart:async';

import 'package:blaze_adventure/actors/player.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World {
  late TiledComponent level;

  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load("Level - 1.tmx", Vector2.all(16));
    add(level);

    //Getting the layer data
    final spawnPointLayer = level.tileMap.getLayer<ObjectGroup>("Spawn");

    for (var spawnPoint in spawnPointLayer!.objects) {
      switch (spawnPoint.class_) {
        case "Player":
          final player = Player(
            character: "Ninja Frog",
            position: Vector2(
              spawnPoint.x,
              spawnPoint.y,
            ),
          );
          add(player);
          break;
        default:
      }
    }

    return super.onLoad();
  }
}
