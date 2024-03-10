import 'package:easy_lib/gui/page/error_page.dart';
import 'package:flutter/material.dart';

class RouteCollector {
  static const String sign_in = '/sign_in';
  static const String sign_up = '/sign_up';
  static const String main = '/main';
  static const String about = '/about';
  static const Set<String> simpleRoutes = {
    sign_in,
    sign_up,
    about,
  };

  // specialRoutes中的路由不会在路由表中注册，而是在RouteGenerator中动态生成,因为这些路由需要用户满足某种条件才能跳转
  static const Set<String> specialRoutes = {
    main,
  };
  static Map<String, WidgetBuilder> simpleRouteMap = {
    '/about': (context) => const ErrorPage(),
    // '/main': (context) => const MainTabs(),
    // '/sign_in': (context) => const Center(),
    // '/sign_up': (context) => const SignUpPage(),
  };
}