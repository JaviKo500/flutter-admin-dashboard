import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/api/coffee_api.dart';

import 'package:admin_dashboard/ui/layouts/dashboard/dashboard_layout.dart';
import 'package:admin_dashboard/ui/layouts/splash/splash_layout.dart';
import 'package:admin_dashboard/ui/layouts/auth/auth_layout.dart';

import 'package:admin_dashboard/router/router.dart';

import 'package:admin_dashboard/providers/categories_provider.dart';
import 'package:admin_dashboard/providers/users_provider.dart';
import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/side_menu_provider.dart';

import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notification_service.dart';


void main() async {
  await LocalStorage.configurePrefs();
  CoffeeApi.configureDio();
  CustomFluroRouter.configureRoutes();
  runApp(const AppState());
}


class AppState extends StatelessWidget {

const AppState({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider( lazy: false, create: ( _ ) => AuthProvider() ),
        ChangeNotifierProvider( lazy: false, create: ( _ ) => SideMenuProvider() ),
        ChangeNotifierProvider( create: ( _ ) => CategoriesProvider() ),
        ChangeNotifierProvider( create: ( _ ) => UsersProvider() )
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Dashboard',
      debugShowCheckedModeBanner: false,
      initialRoute: CustomFluroRouter.rootRoute,
      onGenerateRoute: CustomFluroRouter.router.generator,
      navigatorKey: NavigationService.navigatorKey,
      scaffoldMessengerKey: NotificationService.messengerKey,
      builder: ( _ , child) {
        final authProvider = Provider.of<AuthProvider>(context);  
        if (authProvider.authStatus == AuthStatus.checking) {
          return const SplashLayout();
        }
        if ( authProvider.authStatus == AuthStatus.authenticated) {
          return  DashboardLayout( child: child ?? Container());
        } else {
          return  AuthLayout( child: child ?? Container());
        }
      },
      theme: ThemeData.light().copyWith(
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: MaterialStateProperty.all( Colors.grey.withOpacity(0.5))
        )
      ),
    );
  }
}