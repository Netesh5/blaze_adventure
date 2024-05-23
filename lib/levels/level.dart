import 'dart:async';

import 'package:blaze_adventure/actors/player.dart';
import 'package:blaze_adventure/component/collision_block.dart';
import 'package:flame/components.dart';
import 'package:flame_tiled/flame_tiled.dart';

class Level extends World {
  late TiledComponent level;
  final String levelName;
  final Player player;
  Level({required this.levelName, required this.player});

  List<CollisionBlock> collisionBlocks = [];
  @override
  FutureOr<void> onLoad() async {
    level = await TiledComponent.load("$levelName.tmx", Vector2.all(16));
    add(level);

    //Getting the layer data
    final spawnPointLayer = level.tileMap.getLayer<ObjectGroup>("Spawn");

    if (spawnPointLayer != null) {
      for (var spawnPoint in spawnPointLayer.objects) {
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
    }

    final collisionLayer = level.tileMap.getLayer<ObjectGroup>("Collision");
    if (collisionLayer != null) {
      for (var collision in collisionLayer.objects) {
        switch (collision.class_) {
          case "Platform":
            final platform = CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
              isPlatform: true,
            );
            collisionBlocks.add(platform);
            add(platform);
            break;
          default:
            final block = CollisionBlock(
              position: Vector2(collision.x, collision.y),
              size: Vector2(collision.width, collision.height),
            );
            collisionBlocks.add(block);
            add(block);
        }
        player.collisionBlock = collisionBlocks;
      }
    }

    return super.onLoad();
  }
}
