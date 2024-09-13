import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:notifications/notifications.dart';
import 'package:sms_demo/core/models/message_model.dart';
import 'package:sms_demo/core/storage/local_storage.dart';
import 'package:sms_demo/pages/message_list.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}


class _HomeState extends State<Home> {
  List messages = [];
  List packageList = [];
  late Notifications _notifications;
  late StreamSubscription<NotificationEvent> _subscription;


  @override
  void initState() {
    messages = Prefs.read('messages')??[];
    packageList = Prefs.read('packagesList')??[];
    startListening();
    super.initState();
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
    setState(() {});
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

  void deleteMatchingEntry(  String targetEntry) {
    messages.removeWhere((value) => value.toString() == targetEntry.toString() );
    packageList.remove(targetEntry);
    Prefs.write("messages", messages);
    Prefs.write("packagesList", packageList);
    setState(() {});
    Navigator.pop(context);
  }

  clearAllData(){
    messages.clear();
    packageList.clear();
    Prefs.write("messages", messages);
    Prefs.write("packagesList", packageList);
    setState(() {});
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Applications List", ),
         actions: [
           packageList.isNotEmpty?Padding(
             padding: const EdgeInsets.only(right: 10),
             child: InkWell(
               onTap: (){
                 showDialog(
                   context: context,
                   builder: (BuildContext context) {
                     return AlertDialog(
                       title: const Text("Alert"),
                       content: const Text("You want to Delete All applications messages"),
                       actions: [
                         InkWell(
                             onTap: (){
                               Navigator.pop(context);
                             },
                             child: const Icon(Icons.cancel)),
                         const SizedBox(width: 10,),
                         InkWell(
                             onTap: (){
                               clearAllData();
                             },
                             child: const Icon(Icons.delete, color: Colors.red,))
                       ],
                     );
                   },);
               },
               child: Icon(Icons.delete, color: Colors.red,),
             ),
           ):SizedBox()
          ],
      ),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          alignment: Alignment.topLeft,
          child: GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,  // 3 items per row
              crossAxisSpacing: 10.0,  // Horizontal space between items
              mainAxisSpacing: 10.0,   // Vertical space between items
              childAspectRatio: 2,   // Aspect ratio for each item (1.0 makes it a square)
            ),
            itemCount: packageList.length,  // Number of items in the grid
            itemBuilder: (context, index) {
              return InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=> MessageList(appName:packageList[index].toString().trim(),)));
                },
                onLongPress: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text("Alert"),
                        content: Text("You want to Delete All messages: ${packageList[index].toString().trim()}"),
                        actions: [
                          InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.cancel)),
                          SizedBox(width: 10,),
                          InkWell(
                              onTap: (){
                                deleteMatchingEntry(packageList[index].toString().trim());
                              },
                              child: const Icon(Icons.delete, color: Colors.red,))
                        ],
                      );
                    },);},
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),  // Shadow color
                        spreadRadius: 2,  // Spread radius
                        blurRadius: 4,    // Blur radius
                        //offset: const Offset(0, 0),  // Offset in x and y directions
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(packageList[index].toString().trim(), style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),),
                ),
              );
            },
          )

      )
    );
  }
}
