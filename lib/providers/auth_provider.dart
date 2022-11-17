
import 'package:admin_dashboard/models/user.dart';
import 'package:flutter/foundation.dart';

import 'package:admin_dashboard/api/coffee_api.dart';

import 'package:admin_dashboard/models/http/auth_response.dart';

import 'package:admin_dashboard/router/router.dart';

import 'package:admin_dashboard/services/local_storage.dart';
import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notification_service.dart';

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
  Usuario? user;
  login( String email, String password ) async {
    final data = {
      'correo': email,
      'password': password,
    };
    CoffeeApi.httpPost('/auth/login', data)
      .then(( json) {
        final authResponse = AuthResponse.fromMap(json);
        user = authResponse.usuario;
        LocalStorage.prefs.setString('token', authResponse.token);
        authStatus = AuthStatus.authenticated;
        NavigationService.replaceTo(CustomFluroRouter.dashboardRoute);
        notifyListeners();
        CoffeeApi.configureDio();
      })
      .catchError( (error) {
        if (kDebugMode) {
          print(error.toString());
        }
        NotificationService.showSnackbarError('Invalid credentials');
      });

  }

  Future<bool> isAuthenticated() async {
    final token = LocalStorage.prefs.getString('token');
    if ( token == null ) {
      authStatus = AuthStatus.notAuthenticated;
      notifyListeners();
      return false;
    }
    try {
      final response = await CoffeeApi.httpGet('/auth');
      final authResponse = AuthResponse.fromMap(response);
      user = authResponse.usuario;
      authStatus = AuthStatus.authenticated;
      LocalStorage.prefs.setString('token', authResponse.token);
      notifyListeners();
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      authStatus = AuthStatus.notAuthenticated;
      LocalStorage.prefs.clear();
      notifyListeners();
      return false;
    }
  }

  register( String name, String email, String password ) async {
    final data = {
      'nombre': name,
      'correo': email,
      'password': password,
    };
    CoffeeApi.httpPost('/usuarios', data)
      .then((json) {
        print(json);
        final authResponse = AuthResponse.fromMap(json);
        user = authResponse.usuario;
        LocalStorage.prefs.setString('token', authResponse.token);
        authStatus = AuthStatus.authenticated;
        NavigationService.replaceTo(CustomFluroRouter.dashboardRoute);
        notifyListeners();
        CoffeeApi.configureDio();
      })
      .catchError( (error) {
        NotificationService.showSnackbarError( 'Invalid credentials');
      });

  }

  logout() {
    LocalStorage.prefs.remove('token');
    authStatus = AuthStatus.notAuthenticated;
    notifyListeners();
  }
}