

import 'package:admin_dashboard/api/coffee_api.dart';
import 'package:admin_dashboard/models/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserFormProvider extends ChangeNotifier{
  
  Usuario? user;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

   // TODO: tking update user

  bool _validForm() {
   return formKey.currentState!.validate();
  }

  // void updateListeners (){
  //   notifyListeners();
  // }

  copyUserWith({
    String? rol,
    bool? estado,
    bool? google,
    String? nombre,
    String? correo,
    String? uid,
    String? img,
  }){
    user = Usuario(
      rol: rol ?? this.user!.rol, 
      estado: estado ?? this.user!.estado, 
      google: google ?? this.user!.google, 
      nombre: nombre ?? this.user!.nombre, 
      correo: correo ?? this.user!.correo, 
      uid: uid ?? this.user!.uid
    );
    notifyListeners();
  }
  
  Future<bool> updateUser () async {
    if ( !_validForm() ) return false;
    if (kDebugMode) {
      print(user?.nombre);
      print(user?.correo);
    }

    final data = {
      'nombre' : user?.nombre,
      'correo': user?.correo
    };

    try {
      final resp = await CoffeeApi.httpPut('/usuarios/${user?.uid}', data);
      if (kDebugMode) {
        print(resp);
      }
      return true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
  } 
  Future< Usuario > uploadImage  ( String path, Uint8List bytes ) async {
    try {
      final resp = await CoffeeApi.httpUploadFile(path, bytes);
      user = Usuario.fromMap( resp );
      notifyListeners();
      return user!;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw 'Error in user form provider';
    }
  }

}