import 'package:elementary/elementary.dart';
import 'package:flutter/cupertino.dart';
import 'package:playstation_games_presenter/domain/game/game.dart';
import 'package:playstation_games_presenter/res/theme/app_typography.dart';
import 'package:playstation_games_presenter/ui/game_screen/game_screen.dart';
import 'package:playstation_games_presenter/ui/game_screen/game_screen_madel.dart';
import 'package:provider/provider.dart';

GameScreenWidgetModel gameScreenWidgetModelFactory(BuildContext context) {
  final model = context.read<GameScreenModel>();
  final theme = context.read<ThemeWrapper>();
  return GameScreenWidgetModel(model, theme);
}

class GameScreenWidgetModel extends WidgetModel<GameScreen, GameScreenModel>
    implements IGameWidgetModel {
  GameScreenWidgetModel(GameScreenModel model, this._themeWrapper)
      : super(model);

  final ThemeWrapper _themeWrapper;
  late TextStyle _titleStyle;
  late TextStyle _descriptionStyle;
  late Game _gameData;

  @override
  TextStyle get descriptionStyle => _descriptionStyle;

  @override
  TextStyle get titleStyle => _titleStyle;

  @override
  Game get gameData => _gameData;

  @override
  void onTapArrowBack() {
    Navigator.of(context).pop();
  }

  @override
  void initWidgetModel() {
    super.initWidgetModel();

    _titleStyle =
        _themeWrapper.getTextTheme(context).headline3 ?? AppTypography.title;
    _descriptionStyle =
        _themeWrapper.getTextTheme(context).bodyText1 ?? AppTypography.body;
    _gameData = ModalRoute.of(context)?.settings.arguments as Game;
  }
}

abstract class IGameWidgetModel extends IWidgetModel {
  TextStyle get descriptionStyle;

  TextStyle get titleStyle;

  Game get gameData;

  void onTapArrowBack();
}
