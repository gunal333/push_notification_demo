// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DeviceInfoRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceInfoRequest _$DeviceInfoRequestFromJson(Map<String, dynamic> json) =>
    DeviceInfoRequest(
      token: json['token'] as String?,
      customerId: json['customerId'] as String?,
    );

Map<String, dynamic> _$DeviceInfoRequestToJson(DeviceInfoRequest instance) =>
    <String, dynamic>{
      'token': instance.token,
      'customerId': instance.customerId,
    };
