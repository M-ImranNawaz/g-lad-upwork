import 'package:flutter/material.dart';
import 'package:glad/forgot_password/forgot_password_page.dart';
import 'package:glad/signup/signup_page.dart';
import 'package:glad/splash/splash.dart';
import 'package:go_router/go_router.dart';

import 'legacy/about/about.dart';
import 'legacy/home/home.dart';
import 'login/login_page.dart';

class Routes {
  static String signup = "signup";
  static String signupRoute = "/signup";
  static String forgotPassword = "forgot_password";
  static String forgotPasswordRoute = "/forgot_password";
  static String login = "login";
  static String loginRoute = "/login";
  static String base = "/";
  static String home = "home";
  static String homeRoute = "/home";
  static String about = "about";
  static String dailyEntry = "daily_entry";
  static String settings = "settings";
  static String keywordsSearch = "keywordsSearch";
  static String help = "help";
  static String search = "search";
}


final GoRouter router = GoRouter(routes: <RouteBase>[
  GoRoute(
    path: Routes.base,
    builder: (BuildContext context, GoRouterState state) {
      return const Splash();
    },
    routes: <RouteBase>[
      GoRoute(
        path: Routes.login,
        builder: (BuildContext context, GoRouterState state) {
          return LoginPage(
            navigateToForgotPasswordView: () {
              context.push(Routes.forgotPasswordRoute);
            },
            navigateToSignupView: () {
              context.push(Routes.signupRoute);
            },
          );
        },
      ),
      GoRoute(
        path: Routes.signup,
        builder: (BuildContext context, GoRouterState state) {
          return SignupPage();
        },
      ),
      GoRoute(
        path: Routes.forgotPassword,
        builder: (BuildContext context, GoRouterState state) {
          return ForgotPasswordPage();
        },
      ),
      GoRoute(
        path: Routes.home,
        builder: (BuildContext context, GoRouterState state) {
          return const HomePage();
        },
      ),
      GoRoute(
        path: Routes.about,
        builder: (BuildContext context, GoRouterState state) {
          return const AboutPage();
        },
      ),

    ],
  )
]);
