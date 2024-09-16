import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'core/constants/app_strings.dart';
import 'core/routes/routes.dart';

Future<void> main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      child: GetMaterialApp(
        theme: ThemeData(
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        title: CommonStrings.appName,
        locale: const Locale('en', 'US'),
        //themeMode: ThemeMode.dark,
        getPages: AppPages(),
        initialRoute: Routes.initial,
      ),
    );
  }
}
