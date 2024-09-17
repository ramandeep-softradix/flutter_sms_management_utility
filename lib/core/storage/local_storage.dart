import 'dart:convert';
import 'package:get_storage/get_storage.dart';
class Prefs {

  static const favoriteMessages = "favoriteMessages";
  static const messages = "messages";
  static const packageList = "packageList";


  static read(String key) {
    var box = GetStorage();
    return box.read(key);
  }

  static write(String key, value) {
    var box = GetStorage();
    box.write(key, value);
  }

  static readObj(String key) {
    var box = GetStorage();
    var data = box.read(key);
    return data != null ? json.decode(data) : null;
  }

  static writeObj(String key, value) {
    var box = GetStorage();
    box.write(key, json.encode(value));
  }

  static erase() {
    var box = GetStorage();
    box.remove("messages");
  }
}