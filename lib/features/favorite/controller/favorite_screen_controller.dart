import 'package:get/get.dart';
import 'package:sms_demo/core/models/message_model.dart';
import '../../../core/storage/local_storage.dart';

class FavoriteScreenController extends GetxController {
  RxList favoriteMessages = [].obs;

  @override
  void onInit() {
    loadMessages();
    super.onInit();
  }

  loadMessages(){
   List favorite = Prefs.read(Prefs.favoriteMessages)??[];
    for(var m in favorite){
       favoriteMessages.add(MessageModel.fromMap(m));
    }
    update();
  }

  void deleteMatchingEntry(var m) {
        favoriteMessages.remove(m);
        Prefs.write(Prefs.favoriteMessages, favoriteMessages);
      }

}