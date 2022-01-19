import 'package:elementary/elementary.dart';
import 'package:flutter/material.dart';
import 'package:playstation_games_presenter/ui/game_screen/game_screen_widget_model.dart';

class GameScreen extends ElementaryWidget<IGameWidgetModel> {
  const GameScreen({
    Key? key,
    WidgetModelFactory wmFactory = gameScreenWidgetModelFactory,
  }) : super(wmFactory, key: key);

  @override
  Widget build(IGameWidgetModel wm) {
    final data = wm.gameData;
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          delegate: _ClippedImageAppBar(
            maxHeight: 500,
            minHeight: 300,
            imagePath: data.image,
            onTapArrowBack: () => wm.onTapArrowBack(),
          ),
        ),
        SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate.fixed([
                SizedBox(
                  height: 40,
                  child: Text(
                    data.name,
                    style: wm.titleStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 450,
                  child: Text(
                    data.description,
                    style: wm.descriptionStyle,
                    textAlign: TextAlign.center,
                  ),
                ),
              ]),
            )),
      ],
    ));
  }
}

class _ClippedImageAppBar extends SliverPersistentHeaderDelegate {
  _ClippedImageAppBar({
    required this.maxHeight,
    required this.minHeight,
    required this.imagePath,
    required this.onTapArrowBack,
  });

  final double maxHeight;
  final double minHeight;
  final String imagePath;
  final Function onTapArrowBack;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ClipPath(
      clipper: _AppBarClipper(),
      child: Container(
        height: maxHeight,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(imagePath),
            fit: BoxFit.cover,
          ),
        ),
        alignment: Alignment.topLeft,
        child: SafeArea(
          minimum: const EdgeInsets.all(5),
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => onTapArrowBack(),
            iconSize: 28,
            color: Colors.white.withOpacity(0.7),
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}

class _AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height)
      ..lineTo(size.width / 2, size.height - 30)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width, 0)
      ..lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
