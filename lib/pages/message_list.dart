
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:sms_demo/core/models/message_model.dart';
import 'package:sms_demo/core/storage/local_storage.dart';

class MessageList extends StatefulWidget {
 final String appName;
   const MessageList({super.key, required this.appName});

  @override
  State<MessageList> createState() => _MessageListState();
}

class _MessageListState extends State<MessageList> {
  List<MessageModel> allMessages = [];
  List<MessageModel> messages = [];

  @override
  void initState() {
   List  allMessages = Prefs.read('messages')??[];
    for(var m in allMessages){
    MessageModel message =  MessageModel.fromMap(m);
      if(message.package == widget.appName){
        messages.add(message);
      }
    }
    super.initState();
  }

  void deleteMatchingEntry(String id) {
    messages.removeWhere((value) => value.id == id.toString() );
    Prefs.write("messages", messages);
    setState(() {});
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title:Text(widget.appName)),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        alignment: Alignment.topLeft,
        child: messages.isNotEmpty?ListView.builder(
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: messages.length, //messages.length,
          itemBuilder: (BuildContext context, int index) {
            return Slidable(
                  key: const ValueKey(0),
                  startActionPane: ActionPane(
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(onDismissed: () {
                      print("This is lideafer fdasjfkl");
                      //deleteMatchingEntry(messages[index].id);

                    }),
                    children: [
                      SlidableAction(
                        onPressed: (_){

                        },
                        backgroundColor: Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: ListTile(
                   horizontalTitleGap: 1,
                    title: Text(messages[index].title,style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600,),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(messages[index].message, style: const TextStyle(fontSize: 13)),
                        const SizedBox(height: 4,),
                        Text(messages[index].package.trim(), style: const TextStyle(fontSize: 10)),
                      ],
                    ),
                    trailing: Text(messages[index].timeStamp),
                  ),
              );
          },):const Text("No messages found!",style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),),
      ),

    );;
  }
}
