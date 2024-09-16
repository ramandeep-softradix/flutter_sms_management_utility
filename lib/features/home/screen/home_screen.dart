
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sms_demo/core/constants/app_strings.dart';
import 'package:sms_demo/core/routes/routes.dart';
import '../controller/home_controller.dart';

class HomeScreen extends GetView<HomeScreenController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text(CommonStrings.applicationList),
          actions: [
            controller.packageList.isNotEmpty?Padding(
              padding:  EdgeInsets.only(right: 10.w),
              child: InkWell(
                onTap: (){
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text(CommonStrings.alert),
                        content: const Text(CommonStrings.deleteAllAppsMessages),
                        actions: [
                          InkWell(
                              onTap: (){
                                Navigator.pop(context);
                              },
                              child: const Icon(Icons.cancel)),
                           SizedBox(width: 10.w),
                          InkWell(
                              onTap: (){
                                controller.clearAllData();
                              },
                              child: const Icon(Icons.delete, color: Colors.red,))
                        ],
                      );
                    },);
                },
                child: const Icon(Icons.delete, color: Colors.red,),
              ),
            ):const SizedBox()
          ],
        ),
        body: Container(
            padding:  EdgeInsets.symmetric(vertical: 16.0.h),
            alignment: Alignment.topLeft,
            child: GridView.builder(
              padding:  EdgeInsets.symmetric(horizontal: 15.w, vertical: 8.h),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,  // 3 items per row
                crossAxisSpacing: 10.0,  // Horizontal space between items
                mainAxisSpacing: 10.0,   // Vertical space between items
                childAspectRatio: 2,   // Aspect ratio for each item (1.0 makes it a square)
              ),
              itemCount: controller.packageList.length,  // Number of items in the grid
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                    Get.toNamed(Routes.messageList, arguments: controller.packageList[index].toString().trim());
                  },
                  onLongPress: (){
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text(CommonStrings.alert),
                          content: Text("${CommonStrings.deleteAllMessages}: ${controller.packageList[index].toString().trim()}"),
                          actions: [
                            InkWell(
                                onTap: (){
                                  Navigator.pop(context);
                                },
                                child: const Icon(Icons.cancel)),
                             SizedBox(width: 10.w,),
                            InkWell(
                                onTap: (){
                                  controller.deleteMatchingEntry(controller.packageList[index].toString().trim());
                                },
                                child: const Icon(Icons.delete, color: Colors.red,))
                          ],
                        );
                      },);},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
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
                    child: Text(controller.packageList[index].toString().trim(), style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500),),
                  ),
                );
              },
            )

        )
    );
  }
}