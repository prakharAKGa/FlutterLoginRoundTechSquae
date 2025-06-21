import 'package:get/get.dart';
import 'package:round_tech_square/app/modules/auth/bindings/login_binding.dart';
import 'package:round_tech_square/app/modules/auth/views/login_view.dart';
import 'package:round_tech_square/app/modules/home/bindings/home_binding.dart';
import 'package:round_tech_square/app/modules/home/view/home_view.dart';
import 'package:round_tech_square/app/routes/routes.dart';

class AppRoutes {
  static List<GetPage> appRoutes() => [
        GetPage(
          name: RoutesName.loginScreen,
          page: () => LoginView(),
          binding: LoginBinding(),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 250),
        ),
        GetPage(
          name: RoutesName.homeScreen,
          page: () => HomeView(),
          binding: HomeBinding(),
          transition: Transition.leftToRight,
          transitionDuration: const Duration(milliseconds: 250),
        ),
       
      ];
}