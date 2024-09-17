import 'package:get/get.dart';
import '../controller/favorite_screen_controller.dart';


class FavoriteScreenBinding implements Bindings{

  @override
  void dependencies() {
    Get.lazyPut<FavoriteScreenController>(() => FavoriteScreenController());
  }
}