import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:playstation_games_presenter/domain/game/game.dart';
import 'package:playstation_games_presenter/ui/game_list_screen/game_list_screen_widget_model.dart';

class GameListScreen extends ElementaryWidget<IGameListWidgetModel> {
  const GameListScreen({
    Key? key,
    WidgetModelFactory wmFactory = gameListScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IGameListWidgetModel wm) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Список игр'),
      ),
      body: EntityStateNotifierBuilder<Iterable<Game>>(
        listenableEntityState: wm.gameListState,
        loadingBuilder: (_, __) => const _LoadingWidget(),
        errorBuilder: (_, __, ___) => const _ErrorWidget(),
        builder: (_, games) => _GameList(
          games: games,
          nameStyle: wm.gameNameStyle,
          onTapGameWidget: (Game data) => wm.onTapGameWidget(data),
        ),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

class _ErrorWidget extends StatelessWidget {
  const _ErrorWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Error'),
    );
  }
}

class _GameList extends StatelessWidget {
  const _GameList(
      {Key? key,
      required this.games,
      required this.nameStyle,
      required this.onTapGameWidget})
      : super(key: key);

  final Iterable<Game>? games;
  final TextStyle nameStyle;
  final Function(Game) onTapGameWidget;

  @override
  Widget build(BuildContext context) {
    final games = this.games;

    if (games == null || games.isEmpty) {
      return const _EmptyList();
    }

    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          mainAxisExtent: 200,
        ),
        physics: const BouncingScrollPhysics(),
        itemCount: games.length,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        cacheExtent: 300,
        itemBuilder: (_, index) => _GameWidget(
              data: games.elementAt(index),
              nameStyle: nameStyle,
              onTap: onTapGameWidget,
            ));
  }
}

class _EmptyList extends StatelessWidget {
  const _EmptyList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Список пуст'),
    );
  }
}

class _GameWidget extends StatelessWidget {
  const _GameWidget(
      {Key? key,
      required this.data,
      required this.nameStyle,
      required this.onTap})
      : super(key: key);

  final Game data;
  final TextStyle nameStyle;
  final Function(Game) onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(data),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(
              image: NetworkImage(data.image),
              fit: BoxFit.cover,
            ),
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(15)),
              ),
              child: Center(
                child: Text(
                  data.name,
                  style: nameStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
