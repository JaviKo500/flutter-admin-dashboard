

import 'package:admin_dashboard/api/coffee_api.dart';
import 'package:admin_dashboard/models/http/users_response.dart';
import 'package:admin_dashboard/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UsersProvider extends ChangeNotifier{
  UsersProvider(){
    getPaginatedUsers();
  }
  List< Usuario > users = [];
  bool isLoading = true;
  bool ascending = true;
  int? sortColumIndex;

  getPaginatedUsers() async {
    final resp = await CoffeeApi.httpGet('/usuarios?limite=100&desde=0');
    final usersResponse = UsersResponse.fromMap(resp);
    users = [ ...usersResponse.usuarios];
    isLoading = false;
    notifyListeners();
  }

  Future< Usuario? > getUserById ( String uid) async{
    try {
      final resp = await CoffeeApi.httpGet('/usuarios/$uid');
      final userResp = Usuario.fromMap(resp);
      return userResp;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return null;
    }
  }

  void sort<T> ( Comparable<T> Function( Usuario user ) getFiled ){
    users.sort( (a, b) {
      final aValue = getFiled( a );
      final bValue = getFiled( b );
      return ascending 
      ? Comparable.compare( aValue, bValue )
      : Comparable.compare( bValue, aValue );
    });
    ascending = !ascending;
    notifyListeners();
  }

  void refreshUser ( Usuario user ){
    users = users.map(( u ) {
      if ( u.uid == user.uid) {
        return user;
      }
      return u;
    }).toList();
    notifyListeners();
  }
}