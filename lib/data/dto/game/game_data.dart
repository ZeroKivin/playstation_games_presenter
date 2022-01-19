import 'package:json_annotation/json_annotation.dart';

part 'game_data.g.dart';

@JsonSerializable()
class GameData {
  const GameData({
    required this.name,
    required this.description,
    required this.image,
  });

  final String name;
  final String description;
  final String image;

  factory GameData.fromJson(Map<String, dynamic> json) =>
      _$GameDataFromJson(json);

  Map<String, dynamic> toJson() => _$GameDataToJson(this);
}
