import 'package:json_annotation/json_annotation.dart';
part 'food.g.dart';

@JsonSerializable()
class Food {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "description")
  String? description;

  @JsonKey(name: "category")
  String? category;

  @JsonKey(name: "image")
  String? image;

  @JsonKey(name: "price")
  double? price;

  @JsonKey(name: "shop")
  String? shop;

  @JsonKey(name: "offer")
  bool? offer;

  Food({
    this.id,
    this.name,
    this.description,
    this.category,
    this.image,
    this.offer,
    this.price,
    this.shop,
  });

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
  Map<String, dynamic> toJson() => _$FoodToJson(this);
}
