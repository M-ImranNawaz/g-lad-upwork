import 'package:flutter/material.dart';
import 'package:glad/daily_entry/daily_entry_home.dart';
import 'package:glad/help/help.dart';
import 'package:glad/home/home.dart';
import 'package:glad/search/keyword_search.dart';
import 'package:glad/search/search_page.dart';
import 'package:glad/settings/settings.dart';
import 'package:glad/splash/splash.dart';
import 'package:go_router/go_router.dart';

import 'about/about.dart';

class Routes {
  static String base = "/";
  static String home = "home";
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
      GoRoute(
        name: 'date',
        path: Routes.dailyEntry,
        builder: (BuildContext context, GoRouterState state) {
          String date = state.extra as String;
          return  DailyEntryHome(date: date);
        },
      ),
      GoRoute(
        path: Routes.search,
        builder: (BuildContext context, GoRouterState state) {
          return const SearchPage();
        },
      ),
      GoRoute(
        path: Routes.settings,
        builder: (BuildContext context, GoRouterState state) {
          return const SettingsPage();
        },
      ),

      // Help:
      GoRoute(
        path: Routes.help,
        builder: (BuildContext context, GoRouterState state) {
          return const HelpPage();
        },
      ),
      GoRoute(
        path: Routes.keywordsSearch,
        builder: (BuildContext context, GoRouterState state) {
          return const KeywordSearch();
        },
      ),
    ],
  )
]);
