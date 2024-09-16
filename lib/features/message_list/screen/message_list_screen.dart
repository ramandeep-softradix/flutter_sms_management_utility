
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sms_demo/core/constants/app_strings.dart';
import '../controller/message_list_controller.dart';

class MessageListScreen extends GetView<MessageListController> {
  const MessageListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(preferredSize: Size(100.w, 50.h),
        child: Obx(()=>AppBar(
        title: controller.isSearching.value
            ? TextField(
          controller: controller.searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Search...',
            border: InputBorder.none,
          ),
          onChanged: (query) {
            controller.searchMessage(query:query);
          },
        )
            : Text(controller.appName),
        actions: [
          IconButton(
            icon: Icon(controller.isSearching.value ? Icons.close : Icons.search),
            onPressed: () {
              controller.searchingToggle();
            },
          ),
        ],
      )),),
      body: Container(
        padding:  EdgeInsets.symmetric(vertical: 16.0.h),
        alignment: Alignment.topLeft,
        child: Obx(()=>controller.messages.isNotEmpty?ListView.builder(
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: controller.messages.length, //messages.length,
          itemBuilder: (BuildContext context, int index) {
            return Slidable(

              key: ValueKey(controller.messages[index].id),
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                dismissible: DismissiblePane(onDismissed: () {
                  print("This is slidable actions onDismissed");
                  controller.deleteMatchingEntry(controller.messages[index].id);

                }),
                children: [
                  SlidableAction(
                    onPressed: (_){
                      print("This is slidable actions");
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
          },): Center(child: Text(ErrorMessages.noMessageFound,style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),)),)
      ),

    );
  }
}