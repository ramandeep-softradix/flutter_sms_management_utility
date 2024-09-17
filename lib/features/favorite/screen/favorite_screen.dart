import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:sms_demo/core/constants/app_strings.dart';
import '../controller/favorite_screen_controller.dart';


class FavoriteScreen extends GetView<FavoriteScreenController> {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
     appBar: AppBar(title: const Text(CommonStrings.favoriteMessages),),
      body: Container(
          padding:  EdgeInsets.symmetric(vertical: 16.0.h),
          alignment: Alignment.topLeft,
          child: Obx(()=>controller.favoriteMessages.isNotEmpty?ListView.builder(
            physics: const ScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: controller.favoriteMessages.length, //messages.length,
            itemBuilder: (BuildContext context, int index) {
              return Slidable(
                key: ValueKey(controller.favoriteMessages[index].id),
                startActionPane: ActionPane(
                  motion: const ScrollMotion(),
                  dismissible: DismissiblePane(onDismissed: () {
                    controller.deleteMatchingEntry(controller.favoriteMessages[index]);
                  }),
                  children: [
                    SlidableAction(
                      onPressed: (_){},
                      backgroundColor: Color(0xFFFE4A49),
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: CommonStrings.delete,
                    ),
                  ],
                ),
                child: ListTile(
                  horizontalTitleGap: 1,
                  title: Text(controller.favoriteMessages[index].title,style:  TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(controller.favoriteMessages[index].message, style:  TextStyle(fontSize: 13.sp)),
                      SizedBox(height: 4.h,),
                      Text(controller.favoriteMessages[index].package.trim(), style:  TextStyle(fontSize: 10.sp)),
                    ],
                  ),
                  trailing: Text(controller.favoriteMessages[index].timeStamp),
                ),
              );
            },): Center(child: Text(ErrorMessages.noMessageFound,style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w600),)),)
      ),

    );
  }
}