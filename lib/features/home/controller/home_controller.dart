import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notifications/notifications.dart';
import 'package:sms_demo/core/storage/local_storage.dart';

class HomeScreenController extends GetxController {

  List messages = [];
  List packageList = [];
  late Notifications _notifications;
  late StreamSubscription<NotificationEvent> _subscription;

 @override
  void onInit() {
   messages = Prefs.read('messages')??[];
   packageList = Prefs.read('packagesList')??[];
   startListening();
    super.onInit();
  }



  void onData(NotificationEvent event) {
    String formattedDate = DateFormat('h:mm a - dd-MM-yyyy').format(event.timeStamp!);
    messages.add({
      "id":event.timeStamp.toString(), // This field is always get unique time so i make it id.
      "title":event.title, // String
      "message":event.message,  // String
      "timeStamp":formattedDate,  // String
      "package":event.packageName.toString(),  // String
    }
    );
    if(!packageList.contains(event.packageName.toString())){
      packageList.add(event.packageName.toString());
      Prefs.write("packagesList", packageList);
    }
    Prefs.write('messages', messages);
    // print(event);
  }


  void startListening() {
    _notifications = Notifications();
    try {
      _subscription = _notifications.notificationStream!.listen(onData);
    } on NotificationException catch (exception) {
      if (kDebugMode) {
        print("Error: $exception");
      }
    }
  }

  void stopListening() {
    _subscription.cancel();
  }

  void deleteMatchingEntry( String targetEntry) {
    messages.removeWhere((value) => value.toString() == targetEntry.toString() );
    packageList.remove(targetEntry);
    Prefs.write("messages", messages);
    Prefs.write("packagesList", packageList);
    Get.back();
  }

  clearAllData(){
    messages.clear();
    packageList.clear();
    Prefs.write("messages", messages);
    Prefs.write("packagesList", packageList);
    Get.back();
  }

}