import 'package:flutter/material.dart';
import 'package:playstation_games_presenter/ui/app/app.dart';
import 'package:playstation_games_presenter/ui/app/app_dependencies.dart';

void main() {
  runApp(
    const AppDependencies(
      app: App(),
    ),
  );
}
