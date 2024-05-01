import "package:json_annotation/json_annotation.dart";

part 'DeviceInfoResponse.g.dart';

@JsonSerializable()
class DeviceInfoResponse {
  @JsonKey(name: "id")
  late String? id;
  
  @JsonKey(name: "token")
  late String? token;
  
  @JsonKey(name: "customerDeviceEndpoint")
  late String? customerDeviceEndpoint;

  @JsonKey(name: "customerId")
  late String? customerId;

   DeviceInfoResponse({
    required this.id,
    required this.customerId,
    required this.customerDeviceEndpoint,
    required this.token
  });

  factory DeviceInfoResponse.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoResponseFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceInfoResponseToJson(this);
}