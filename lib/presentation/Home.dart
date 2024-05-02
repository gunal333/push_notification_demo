import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:push_notification_demo/config/config.dart';
import 'package:push_notification_demo/local_notifcation_service/LocalNotificationService.dart';
import 'package:push_notification_demo/network/endpoints/deviceInfo_api.dart';
import 'package:push_notification_demo/network/model/DeviceInfoRequest.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _customerIdController = TextEditingController();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? deviceToken = "";
  bool isRequestSubmitted = false;
  bool isSubscribed = false;

  var cfg = Config();

  @override
  void initState() {
    super.initState();
    LocalNotificationService.initialize();
    _firebaseMessaging.getToken().then((token) => {
      setState((){
        deviceToken = token;
      }),
      print("The token is $token")
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) { 
         if (message.notification != null) {
        LocalNotificationService.display(message);
      }
      print("Message received: ${message.notification?.body}");
    });
  }

  @override
  Widget build(BuildContext context) {
    final DeviceInfoApi client = DeviceInfoApi(
      Dio(
        BaseOptions(
            contentType: "application/json", baseUrl: cfg.get("BASE_URL")),
      ),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        leading: isSubscribed ? GestureDetector(onTap: () {
          setState(() {
            isSubscribed = false;
          });
        }, child: const Icon(Icons.arrow_back_ios,)): null,
        title: const Text("Subscribe to push notifications"),
        centerTitle: true,
      ),
      body: Center(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
          isSubscribed ?
          const Center(child: Text("You have been successfully subscribed to push notifications !",style: TextStyle(color: Colors.black,fontSize: 20),))
          :
           Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 40),
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  width: double.infinity,
                  child: Column(
                    children: [
                      const Text("Customer Id",style: TextStyle(fontSize: 20),),
                      Semantics(
                          explicitChildNodes: true,
                          child: TextFormField(        
                            onChanged: (value){
                              print("The text is ${_customerIdController.text}");
                            },                
                            decoration: const InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.transparent),
                              ),
                              filled: true,
                              fillColor: Color(0xFFF0F0F0),
                            ),
                            controller: _customerIdController,
                          )),
                    ],
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_customerIdController.text.isNotEmpty && !isRequestSubmitted) {    
                        setState(() {
                          isRequestSubmitted = true;
                        });
                        print("The token is $deviceToken");   
                        try{                 
                        var response = await client.updateDeviceInfo(DeviceInfoRequest(token: deviceToken, customerId:_customerIdController.text)); 
                        setState(() {
                          isSubscribed = true;
                        });
                        } on DioException catch(e) {
                          SnackBar snackBar;
                          if(e.response?.statusCode == 400)
                          {
                              snackBar = const SnackBar(content: Text("CustomerId already exist") );
                          }
                          else{
                             snackBar = const SnackBar(content: Text("Something went wrong") );
                          }
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        }
                        finally{
                          setState(() {
                          isRequestSubmitted = false;
                        });
                        }
                        
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      backgroundColor: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                    child: const Text("Subscribe to push notifications" ,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),))
              ],
            ),
          ),
        ),
      )),
    );
  }
}
