import 'package:playstation_games_presenter/data/dto/game/game_data.dart';
import 'package:playstation_games_presenter/domain/game/game.dart';

Game mapGame(GameData data) {
  return Game(
    name: data.name,
    description: data.description,
    image: data.image,
  );
}
