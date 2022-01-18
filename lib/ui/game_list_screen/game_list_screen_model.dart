import 'package:elementary/elementary.dart';
import 'package:playstation_games_presenter/data/repository/game_repository.dart';
import 'package:playstation_games_presenter/domain/game/game.dart';

class GameListScreenModel extends ElementaryModel {
  GameListScreenModel(this._gameRepository, ErrorHandler errorHandler)
      : super(errorHandler: errorHandler);

  final GameRepository _gameRepository;

  Future<Iterable<Game>> loadGames() async {
    try {
      final result = await _gameRepository.getAllGames();
      return result;
    } on Exception catch (error) {
      handleError(error);
      rethrow;
    }
  }
}
