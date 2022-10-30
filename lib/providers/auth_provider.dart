
import 'package:admin_dashboard/router/router.dart';
import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:flutter/material.dart';

enum AuthStatus{
  checking,
  authenticated,
  notAuthenticated
}
class AuthProvider extends ChangeNotifier {
  
  AuthProvider() {
    isAuthenticated();
  }

  String? _token;
  AuthStatus authStatus = AuthStatus.checking;
  login( String email, String password ) async {
    // TODO: reques http
    _token = 'asasaewfgsd12323434rfasafrgf.dsdsd.dsdsdsds';
    print(' jwt: $_token');

    // TODO: navigate dashboard
    LocalStorage.prefs.setString('token', _token!);
    await Future.delayed( const Duration(seconds: 1));
    authStatus = AuthStatus.authenticated;
    notifyListeners();
    NavigationService.replaceTo(CustomFluroRouter.dashboardRoute);

  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');
    if ( token == null ) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
    // TODO check valid token
    await Future.delayed( const Duration(seconds: 2));
    authStatus = AuthStatus.authenticated;
    notifyListeners();
    return true;
  }
}