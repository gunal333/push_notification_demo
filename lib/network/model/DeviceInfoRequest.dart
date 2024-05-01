import "package:json_annotation/json_annotation.dart";

part 'DeviceInfoRequest.g.dart';

@JsonSerializable()
class DeviceInfoRequest {
  @JsonKey(name: "token")
  late String? token;

  @JsonKey(name: "customerId")
  late String? customerId;

   DeviceInfoRequest({
    required this.token,
    required this.customerId,
  });

  factory DeviceInfoRequest.fromJson(Map<String, dynamic> json) =>
      _$DeviceInfoRequestFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceInfoRequestToJson(this);
}