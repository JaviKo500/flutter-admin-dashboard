import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/ui/views/dashboard_view.dart';
import 'package:admin_dashboard/ui/views/login_view.dart';

class DashboardHandlers {
  
  static Handler dashboard = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!, listen: false);
        if (authProvider.authStatus == AuthStatus.notAuthenticated) {
          return const LoginView();
        } else {
          return const DashboardView();
        }
    },
  );
}