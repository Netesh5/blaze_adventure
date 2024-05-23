import 'package:blaze_adventure/actors/player.dart';

class CheckCollisionDetection {
  static bool checkCollision(Player player, block) {
    final playerX = player.x;
    final playerY = player.y;
    final playerWidth = player.width;
    final playerHeight = player.height;

    final blockX = block.x;
    final blockY = block.y;
    final blockWidth = block.width;
    final blockHeigth = block.height;

    final fixedX = player.scale.x < 0 ? playerX - playerWidth : playerX;

    return (playerY < blockY + blockHeigth &&
        playerY + playerHeight > blockY &&
        fixedX < blockX + blockWidth &&
        fixedX + playerWidth > blockX);
  }
}
