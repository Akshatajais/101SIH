import 'package:flutter/material.dart';

import 'screens/dashboard_screen.dart';
import 'screens/classroom_screen.dart';

class AppRoutes {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case DashboardScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
          settings: settings,
        );
      case ClassroomScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => ClassroomScreen(args: settings.arguments as ClassroomArgs?),
          settings: settings,
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const DashboardScreen(),
          settings: settings,
        );
    }
  }
}


