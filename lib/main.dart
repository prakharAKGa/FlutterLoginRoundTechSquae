import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:round_tech_square/app/modules/auth/bindings/login_binding.dart';
import 'package:round_tech_square/app/routes/routes.dart';
import 'package:round_tech_square/app/routes/routes_name.dart';
import 'package:round_tech_square/app/shared/app_theme.dart';

void main() {


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Round Tech Square',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: RoutesName.loginScreen,
      getPages: AppRoutes.appRoutes(),
      initialBinding: LoginBinding(),
    );
  }
}