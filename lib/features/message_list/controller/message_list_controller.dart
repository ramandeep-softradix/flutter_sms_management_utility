
import 'package:get/get.dart';
import 'package:sms_demo/core/storage/local_storage.dart';
import '../../../core/models/message_model.dart';

class MessageListController extends GetxController {
  String appName = Get.arguments;
  RxList messages = [].obs;
  List allMessages = [];

  @override
  void onInit() {
    allMessages = Prefs.read('messages')??[];
    for(var m in allMessages){
      if(m["package"] == appName){
        messages.add(MessageModel.fromMap(m));
      }
    }
    super.onInit();
  }


  void deleteMatchingEntry(String id) {
    for(var m in allMessages) {
      if(m["id"] == id){
        allMessages.remove(m);
        break;
      }
    }
    Prefs.write("messages", allMessages);
    update();
  }

}