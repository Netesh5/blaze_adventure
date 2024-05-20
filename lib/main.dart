import 'package:blaze_adventure/blaze_adventure.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Flame.device.fullScreen();
  Flame.device.setLandscape();
  BlazeAdventure blazeAdventure = BlazeAdventure();
  runApp(
    GameWidget(
      game: kDebugMode ? blazeAdventure : BlazeAdventure(),
    ),
  );
}
