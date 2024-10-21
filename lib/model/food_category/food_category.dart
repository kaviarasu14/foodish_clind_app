import 'package:json_annotation/json_annotation.dart';
part 'food_category.g.dart';

@JsonSerializable()
class FoodCategory {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  FoodCategory({
    this.id,
    this.name,
  });

  factory FoodCategory.fromJson(Map<String, dynamic> json) =>
      _$FoodCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$FoodCategoryToJson(this);
}
