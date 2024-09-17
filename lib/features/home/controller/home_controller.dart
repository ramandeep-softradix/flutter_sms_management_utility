import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:notifications/notifications.dart';
import 'package:sms_demo/core/routes/routes.dart';
import 'package:sms_demo/core/storage/local_storage.dart';

class HomeScreenController extends GetxController {

  RxList messages = [].obs;
  RxList packageList = [].obs;
  late Notifications _notifications;
  late StreamSubscription<NotificationEvent> _subscription;



 @override
  void onInit() {
   messages.value = Prefs.read(Prefs.messages)??[];
   packageList.value = Prefs.read(Prefs.packageList)??[];
   startListening();
    super.onInit();
  }



  void onData(NotificationEvent event) {
    String formattedDate = DateFormat('h:mm a - dd-MM-yyyy').format(event.timeStamp!);
    print("This is message ID: ${event.timeStamp.toString()}");
    messages.add({
      "id":event.timeStamp.toString().replaceAll(" ", ""), // This field is always get unique time so i make it id.
      "title":event.title, // String
      "message":event.message,  // String
      "timeStamp":formattedDate,  // String
      "package":event.packageName.toString(),
      "tagList":[]// String
    }
    );
    if(!packageList.contains(event.packageName.toString())){
      packageList.add(event.packageName.toString());
      Prefs.write(Prefs.packageList, packageList);
    }
    Prefs.write(Prefs.messages, messages);
    // print(event);
  }


  void startListening() {
    _notifications = Notifications();
     try {
       if(_notifications.notificationStream!.isBroadcast) {
         _subscription = _notifications.notificationStream!.listen(onData);
       }
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
    Prefs.write(Prefs.messages, messages);
    Prefs.write(Prefs.packageList, packageList);
    update();
    Get.back();
  }

  clearAllData(){
    messages.clear();
    packageList.clear();
    Prefs.write(Prefs.messages, messages);
    Prefs.write(Prefs.packageList, packageList);
    Get.back();
  }

  goToMessageListScree({required index}){
    Get.toNamed(Routes.messageList, arguments: packageList[index].toString().trim())?.then((value) async {
     packageList.refresh();
    });
  }

}