import 'package:gs_diamond/features/authentication/presentation/screen/login_screen.dart';
import 'package:gs_diamond/features/authentication/presentation/screen/otp_screen.dart';
import 'package:gs_diamond/features/home/presentation/screen/home_screen.dart';
import 'package:gs_diamond/features/splash/presentation/screen/splash_screen.dart';
import 'package:gs_diamond/core/constants/app_route_constant.dart';
import 'package:velocity_x/velocity_x.dart';

class Routes {
  static VxNavigator routerDelegate = VxNavigator(routes: {
    AppRouteConstants.initialScreen: (uri, params) {
      return VxRoutePage(pageName: "/splash", child: const Splash());
    },
    AppRouteConstants.loginScreen: (uri, params) {
      return VxRoutePage(pageName: "/login", child: const Login());
    },
    AppRouteConstants.otpScreen: (uri, params) {
      return VxRoutePage(pageName: "/otp", child: const Otp());
    },
    AppRouteConstants.homeScreen: (uri, params) {
      return VxRoutePage(pageName: "/home", child: const Home());
    }
  });
}
