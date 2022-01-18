import 'package:dio/dio.dart';
import 'package:playstation_games_presenter/data/dto/game/game_data.dart';
import 'package:playstation_games_presenter/utils/urls.dart';
import 'package:retrofit/http.dart';

part 'game_client.g.dart';

@RestApi()
abstract class GameClient {
  factory GameClient(Dio dio, {String baseUrl}) = _GameClient;

  @GET(AppUrls.all)
  Future<List<GameData>> getAll();

  @GET(AppUrls.game)
  Future<GameData> getGame(@Query('id') String id);
}
