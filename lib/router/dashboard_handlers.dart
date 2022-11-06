import 'package:admin_dashboard/providers/side_menu_provider.dart';
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/ui/views/blank_view.dart';
import 'package:admin_dashboard/ui/views/categories_view.dart';
import 'package:admin_dashboard/ui/views/icons_view.dart';
import 'package:fluro/fluro.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/ui/views/dashboard_view.dart';
import 'package:admin_dashboard/ui/views/login_view.dart';

class DashboardHandlers {
  
  static Handler dashboard = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!, listen: false);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( CustomFluroRouter.dashboardRoute );
      if (authProvider.authStatus == AuthStatus.notAuthenticated) {
        return const LoginView();
      } else {
        return const DashboardView();
      }
    },
  );
  static Handler icons = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!, listen: false);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( CustomFluroRouter.iconsRoute );
      if (authProvider.authStatus == AuthStatus.notAuthenticated) {
        return const LoginView();
      } else {
        return const IconsView();
      }
    },
  );
  static Handler blank = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!, listen: false);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( CustomFluroRouter.blankRoute );
      if (authProvider.authStatus == AuthStatus.notAuthenticated) {
        return const LoginView();
      } else {
        return const BlankView();
      }
    },
  );
  static Handler categories = Handler(
    handlerFunc: (context, parameters) {
      final authProvider = Provider.of<AuthProvider>(context!, listen: false);
      Provider.of<SideMenuProvider>(context, listen: false)
        .setCurrentPageUrl( CustomFluroRouter.categoriesRoute );
      if (authProvider.authStatus == AuthStatus.notAuthenticated) {
        return const LoginView();
      } else {
        return const CategoriesView();
      }
    },
  );
}