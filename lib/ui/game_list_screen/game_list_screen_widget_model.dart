import 'package:dio/dio.dart';
import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:playstation_games_presenter/domain/game/game.dart';
import 'package:playstation_games_presenter/res/theme/app_typography.dart';
import 'package:playstation_games_presenter/ui/game_list_screen/game_list_screen.dart';
import 'package:playstation_games_presenter/ui/game_list_screen/game_list_screen_model.dart';
import 'package:playstation_games_presenter/ui/game_screen/game_screen.dart';
import 'package:provider/provider.dart';

GameListScreenWidgetModel gameListScreenWidgetModelFactory(
    BuildContext context) {
  final model = context.read<GameListScreenModel>();
  final theme = context.read<ThemeWrapper>();
  return GameListScreenWidgetModel(model, theme);
}

class GameListScreenWidgetModel
    extends WidgetModel<GameListScreen, GameListScreenModel>
    implements IGameListWidgetModel {
  GameListScreenWidgetModel(GameListScreenModel model, this._themeWrapper)
      : super(model);

  final ThemeWrapper _themeWrapper;
  late TextStyle _gameNameStyle;
  final _gameListState = EntityStateNotifier<Iterable<Game>>();

  @override
  ListenableState<EntityState<Iterable<Game>>> get gameListState =>
      _gameListState;

  @override
  TextStyle get gameNameStyle => _gameNameStyle;

  @override
  void onTapGameWidget(Game data) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => const GameScreen(),
      settings: RouteSettings(arguments: data),
    ));
  }

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _loadGameList();
    _gameNameStyle =
        _themeWrapper.getTextTheme(context).subtitle1 ?? AppTypography.subtitle;
  }

  @override
  void onErrorHandle(Object error) {
    super.onErrorHandle(error);

    if (error is DioError &&
        (error.type == DioErrorType.connectTimeout ||
            error.type == DioErrorType.receiveTimeout)) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Connection troubles')));
    }
  }

  Future<void> _loadGameList() async {
    final previousData = _gameListState.value?.data;
    _gameListState.loading(previousData);

    try {
      final result = await model.loadGames();
      _gameListState.content(result);
    } on Exception catch (error) {
      _gameListState.error(error, previousData);
    }
  }
}

abstract class IGameListWidgetModel extends IWidgetModel {
  ListenableState<EntityState<Iterable<Game>>> get gameListState;

  TextStyle get gameNameStyle;

  void onTapGameWidget(Game data);
}
