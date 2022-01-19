import 'package:playstation_games_presenter/data/api/game/game_client.dart';
import 'package:playstation_games_presenter/data/repository/game_mappers.dart';
import 'package:playstation_games_presenter/domain/game/game.dart';

class GameRepository {
  GameRepository(this._client);

  final GameClient _client;

  Future<Iterable<Game>> getAllGames() =>
      _client.getAll().then((value) => value.map(mapGame));
}
