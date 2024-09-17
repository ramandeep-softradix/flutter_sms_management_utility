import 'package:get/get.dart';
import '../../features/favorite/binding/favorite_screen_binding.dart';
import '../../features/favorite/screen/favorite_screen.dart';
import '../../features/home/binding/home_binding.dart';
import '../../features/home/screen/home_screen.dart';
import '../../features/message_list/binding/message_list_binding.dart';
import '../../features/message_list/screen/message_list_screen.dart';


class Routes {
  Routes._();

  static const String initial = "/";
  static const String messageList = "/messageList";
  static const String favoriteMessages = "/favoriteMessages";

}

List<GetPage> AppPages() => [

      GetPage(
        name: Routes.initial,
        page: () => const HomeScreen(),
        fullscreenDialog: true,
        binding: HomeScreenBinding(),
        transition: Transition.leftToRight,
        transitionDuration: const Duration(milliseconds: 300),
      ),

  GetPage(
    name: Routes.messageList,
    page: () => const MessageListScreen(),
    fullscreenDialog: true,
    binding: MessageListScreenBinding(),
    transition: Transition.leftToRight,
    transitionDuration: const Duration(milliseconds: 300),
  ),

  GetPage(
    name: Routes.favoriteMessages,
    page: () => const FavoriteScreen(),
    fullscreenDialog: true,
    binding: FavoriteScreenBinding(),
    transition: Transition.leftToRight,
    transitionDuration: const Duration(milliseconds: 300),
  ),

    ];
