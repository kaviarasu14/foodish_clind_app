import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class NewUser {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "phone_no")
  int? phone_no;

  NewUser({
    this.id,
    this.name,
    this.phone_no,
  });

  factory NewUser.fromJson(Map<String, dynamic> json) =>
      _$NewUserFromJson(json);
  Map<String, dynamic> toJson() => _$NewUserToJson(this);
}
