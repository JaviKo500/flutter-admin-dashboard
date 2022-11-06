import 'package:flutter/material.dart';

class NotificationService {
  static GlobalKey<ScaffoldMessengerState> messengerKey = GlobalKey<ScaffoldMessengerState>(); 
  static showSnackbarError( String msg) {
    final snackBar = SnackBar(
      backgroundColor: Colors.red.withOpacity(0.9),
      content: Text(
        msg,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
    messengerKey.currentState?.showSnackBar(snackBar);
  }
  static showSnackbarOk( String msg) {
    final snackBar = SnackBar(
      backgroundColor: Colors.greenAccent.withOpacity(0.9),
      content: Text(
        msg,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),
        textAlign: TextAlign.center,
      ),
    );
    messengerKey.currentState?.showSnackBar(snackBar);
  }
}