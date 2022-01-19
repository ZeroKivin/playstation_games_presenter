import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:playstation_games_presenter/data/api/game/game_client.dart';
import 'package:playstation_games_presenter/data/repository/game_repository.dart';
import 'package:playstation_games_presenter/ui/app/app.dart';
import 'package:playstation_games_presenter/ui/game_list_screen/game_list_screen_model.dart';
import 'package:playstation_games_presenter/ui/game_screen/game_screen_madel.dart';
import 'package:playstation_games_presenter/utils/error/default_error_handler.dart';
import 'package:provider/provider.dart';

class AppDependencies extends StatefulWidget {
  const AppDependencies({
    Key? key,
    required this.app,
  }) : super(key: key);

  final App app;

  @override
  _AppDependenciesState createState() => _AppDependenciesState();
}

class _AppDependenciesState extends State<AppDependencies> {
  late final ThemeWrapper _themeWrapper;
  late final DefaultErrorHandler _defaultErrorHandler;
  late final Dio _http;
  late final GameClient _gameClient;
  late final GameRepository _gameRepository;
  late final GameListScreenModel _gameListScreenModel;
  late final GameScreenModel _gameScreenModel;

  @override
  void initState() {
    super.initState();

    _themeWrapper = ThemeWrapper();
    _defaultErrorHandler = DefaultErrorHandler();
    _http = Dio();
    _gameClient = GameClient(_http);
    _gameRepository = GameRepository(_gameClient);
    _gameListScreenModel = GameListScreenModel(
      _gameRepository,
      _defaultErrorHandler,
    );
    _gameScreenModel = GameScreenModel();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ThemeWrapper>(
          create: (_) => _themeWrapper,
        ),
        Provider<GameListScreenModel>(
          create: (_) => _gameListScreenModel,
        ),
        Provider<GameScreenModel>(
          create: (_) => _gameScreenModel,
        )
      ],
      child: widget.app,
    );
  }
}
