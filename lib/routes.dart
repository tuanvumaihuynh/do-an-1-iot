import 'package:do_an_1_iot/ui/screens/control_device/control_device_screen.dart';
import 'package:do_an_1_iot/ui/screens/manage_device/manage_device_screen.dart';
import 'package:do_an_1_iot/ui/screens/manage_room/manage_room_screen.dart';
import 'package:do_an_1_iot/ui/screens/signin/sign_in_screen.dart';
import 'package:do_an_1_iot/ui/screens/signup/sign_up_screen.dart';
import 'package:do_an_1_iot/ui/screens/verification/verification_screen.dart';
import 'package:do_an_1_iot/ui/screens/manage_home/manage_home_screen.dart';
import 'package:do_an_1_iot/ui/screens/profile_setting/profile_setting.dart';
import 'package:flutter/material.dart';
import 'animations/fade_page_route.dart';
import 'ui/screens/main/main_screen.dart';
import 'ui/screens/splash/splash_screen.dart';

enum Routes {
  splash,
  signIn,
  signUp,
  forgotPassword,
  verification,
  main,
  manageHome,
  manageRoom,
  manageDevice,
  controlDevice,
  statistic,
  profile,
  profileSetting
}

class _Paths {
  static const String splash = '/';
  static const String signIn = '/sign_in';
  static const String signUp = '/sign_up';
  static const String forgotPassword = '/forgot_password';
  static const String verification = '/verification';
  static const String main = '/main';
  static const String manageHome = '/home/manage_home';
  static const String manageRoom = '/home/manage_room';
  static const String manageDevice = '/home/manage_device';
  static const String controlDevice = '/home/control_device';
  static const String statistic = '/statistic';
  static const String profile = '/profile';
  static const String profileSetting = '/profile/profile_setting';

  static const Map<Routes, String> _pathMap = {
    Routes.splash: _Paths.splash,
    Routes.signIn: _Paths.signIn,
    Routes.signUp: _Paths.signUp,
    Routes.forgotPassword: _Paths.forgotPassword,
    Routes.verification: _Paths.verification,
    Routes.main: _Paths.main,
    Routes.manageHome: _Paths.manageHome,
    Routes.manageRoom: _Paths.manageRoom,
    Routes.manageDevice: _Paths.manageDevice,
    Routes.controlDevice: _Paths.controlDevice,
    Routes.statistic: _Paths.statistic,
    Routes.profile: _Paths.profile,
    Routes.profileSetting: _Paths.profileSetting
  };

  static String of(Routes route) => _pathMap[route] ?? splash;
}

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  static Route<Widget> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case _Paths.splash:
        return FadeRoute(page: const SplashScreen());
      case _Paths.signIn:
        return FadeRoute(page: const SignInScreen());
      case _Paths.signUp:
        return FadeRoute(page: const SignUpScreen());
      case _Paths.forgotPassword:
        return FadeRoute(page: Container());
      case _Paths.verification:
        return FadeRoute(page: const VerificationScreen());
      case _Paths.manageHome:
        return FadeRoute(page: const ManageHomeScreen());
      case _Paths.manageRoom:
        return FadeRoute(page: const ManageRoomScreen());
      case _Paths.manageDevice:
        return FadeRoute(page: const ManageDeviceScreen());
      case _Paths.controlDevice:
        return FadeRoute(page: const ControlDeviceScreen());
      case _Paths.statistic:
        return FadeRoute(page: Container());
      case _Paths.profile:
        return FadeRoute(page: Container());
      case _Paths.profileSetting:
        return FadeRoute(page: const ProfileSettingScreen());
      case _Paths.main:
      default:
        return FadeRoute(page: const MainScreen());
    }
  }

  static Future? push<T>(Routes route, [T? arguments]) =>
      state?.pushNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWith<T>(Routes route, [T? arguments]) =>
      state?.pushReplacementNamed(_Paths.of(route), arguments: arguments);

  static Future? replaceWithThenRemoveAllCurrentRoute<T>(Routes route) =>
      state?.pushNamedAndRemoveUntil(_Paths.of(route), (route) => false);

  static void pop() => state?.pop();

  static NavigatorState? get state => navigatorKey.currentState;
}
