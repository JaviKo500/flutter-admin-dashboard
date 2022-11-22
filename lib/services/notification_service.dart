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

  static showBusyIndiator( BuildContext context ){
    final AlertDialog dialog = AlertDialog(
      content: Container(
        width:  100,
        height: 100,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
    showDialog(context: context, builder: ( _ ) => dialog);
  }
}