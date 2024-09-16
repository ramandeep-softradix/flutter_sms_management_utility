
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:sms_demo/core/constants/app_strings.dart';
import '../controller/message_list_controller.dart';


class MessageListScreen extends GetView<MessageListController> {
  const MessageListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title:Text(controller.appName)),
      body: Container(
        padding:  EdgeInsets.symmetric(vertical: 16.0.h),
        alignment: Alignment.topLeft,
        child: controller.messages.isNotEmpty?ListView.builder(
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: controller.messages.length, //messages.length,
          itemBuilder: (BuildContext context, int index) {
            return Slidable(
              key: const ValueKey(0),
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                dismissible: DismissiblePane(onDismissed: () {
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
                title: Text(controller.messages[index].title,style:  TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(controller.messages[index].message, style:  TextStyle(fontSize: 13.sp)),
                     SizedBox(height: 4.h,),
                    Text(controller.messages[index].package.trim(), style:  TextStyle(fontSize: 10.sp)),
                  ],
                ),
                trailing: Text(controller.messages[index].timeStamp),
              ),
            );
          },): Text(ErrorMessages.noMessageFound,style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),),
      ),

    );
  }
}