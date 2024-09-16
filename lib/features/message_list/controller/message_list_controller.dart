
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sms_demo/core/storage/local_storage.dart';
import '../../../core/models/message_model.dart';

class MessageListController extends GetxController {
  String appName = Get.arguments;
  RxList messages = [].obs;
  List allMessages = [];

  RxList tempMessages = [].obs;

  RxBool isSearching = false.obs;
  TextEditingController searchController = TextEditingController();

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

  searchingToggle(){
    isSearching.value = !isSearching.value;
    if (isSearching.value) {
      searchController.clear(); // Clear the search field
      tempMessages.assignAll(messages);
    }
    else{
      messages.assignAll(tempMessages);
      messages.refresh();
    }
    update();
  }


  searchMessage({required String query}){
      messages.assignAll(tempMessages);
      messages.assignAll(messages.where((mes) {
        return mes.message.trim().contains(query.toLowerCase()) || mes.title.toString().toLowerCase().contains(query.toLowerCase()) ;
      }).toList(),);
      messages.refresh();
      update();
  }

  void deleteMatchingEntry(String id) {
    for(var m in allMessages) {
      if(m["id"] == id){
        allMessages.remove(m);
        messages.remove(m);
        if(messages.isEmpty){
          List packageList = Prefs.read('packagesList')??[];
          packageList.remove(appName);
          Prefs.write("packagesList", packageList);
        }
        break;
      }
    }
    Prefs.write("messages", allMessages);
  }

}