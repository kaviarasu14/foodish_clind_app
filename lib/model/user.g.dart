// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewUser _$NewUserFromJson(Map<String, dynamic> json) => NewUser(
      id: json['id'] as String?,
      name: json['name'] as String?,
      phone_no: (json['phone_no'] as num?)?.toInt(),
    );

Map<String, dynamic> _$NewUserToJson(NewUser instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'phone_no': instance.phone_no,
    };
