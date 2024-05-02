import 'package:push_notification_demo/network/model/DeviceInfoRequest.dart';
import 'package:push_notification_demo/network/model/DeviceInfoResponse.dart';
import 'package:retrofit/retrofit.dart';
import "package:dio/dio.dart";

part 'deviceInfo_api.g.dart';

@RestApi()
abstract class DeviceInfoApi{
    factory DeviceInfoApi(Dio dio)= _DeviceInfoApi;

  @POST("/device-info")
  Future<DeviceInfoResponse> updateDeviceInfo(
    @Body() DeviceInfoRequest updateDeviceInfo, [
    @CancelRequest() CancelToken? cancelToken, 
  ]);
}
