import 'package:flutter/material.dart';

final class AppConstants {
  // navigator constants
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
  static get context => navigatorKey.currentState!.overlay!.context;
}
