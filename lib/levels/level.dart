import 'dart:async';

import 'package:blaze_adventure/actors/player.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World {
  late TiledComponent level;
  final String levelName;
  final Player player;
  Level({required this.levelName, required this.player});
  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load("$levelName.tmx", Vector2.all(16));
    add(level);

    //Getting the layer data
    final spawnPointLayer = level.tileMap.getLayer<ObjectGroup>("Spawn");

    for (var spawnPoint in spawnPointLayer!.objects) {
      switch (spawnPoint.class_) {
        case "Player":
          player.position = Vector2(
            spawnPoint.x,
            spawnPoint.y,
          );
          add(player);
          break;
        default:
      }
    }

    return super.onLoad();
  }
}
