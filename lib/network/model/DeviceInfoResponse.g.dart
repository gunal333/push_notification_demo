// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'DeviceInfoResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeviceInfoResponse _$DeviceInfoResponseFromJson(Map<String, dynamic> json) =>
    DeviceInfoResponse(
      id: json['id'] as String?,
      customerId: json['customerId'] as String?,
      customerDeviceEndpoint: json['customerDeviceEndpoint'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$DeviceInfoResponseToJson(DeviceInfoResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'token': instance.token,
      'customerDeviceEndpoint': instance.customerDeviceEndpoint,
      'customerId': instance.customerId,
    };
