import 'package:flutter/material.dart';
import 'package:playstation_games_presenter/res/theme/app_theme.dart';
import 'package:playstation_games_presenter/ui/game_list_screen/game_list_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Playstation Games',
      theme: AppTheme.light().themeData,
      debugShowCheckedModeBanner: false,
      home: const GameListScreen(),
    );
  }
}
