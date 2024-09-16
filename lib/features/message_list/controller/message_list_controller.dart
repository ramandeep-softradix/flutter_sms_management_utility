import 'package:get/get.dart';
import 'package:sms_demo/core/storage/local_storage.dart';
import '../../../core/models/message_model.dart';

class MessageListController extends GetxController {
  String appName = Get.arguments;
  List<MessageModel> allMessages = [];
  List<MessageModel> messages = [];


  @override
  void onInit() {
    List  allMessages = Prefs.read('messages')??[];
    for(var m in allMessages){
      MessageModel message =  MessageModel.fromMap(m);
      if(message.package == appName){
        messages.add(message);
      }
    }
    super.onInit();
  }



  void deleteMatchingEntry(String id) {
    messages.removeWhere((value) => value.id == id.toString() );
    Prefs.write("messages", messages);
  }

}