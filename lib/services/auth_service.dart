import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:myapp/pages/hello_screen.dart';
import 'package:myapp/pages/login_screen.dart';

import '../pages/home_screen.dart';

class AuthService {
  Future<void> signup({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    String message = '';

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return const HomeScreen();
      }));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        message = 'La contraseña es muy débil.';
      } else if (e.code == 'email-already-in-use') {
        message = 'Una cuenta ya fue creada con ese Email.';
      }
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0);
    }
  }

  Future<void> login({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    String message = '';

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext context) {
        return const HomeScreen();
      }));
    } on FirebaseAuthException catch (e) {
      print(e.code);
      if (e.code == 'user-not-found') {
        message = 'No se encontro un usuario con ese Email.';
      } else if (e.code == 'wrong-password') {
        message = 'Contraseña incorrecta';
      }
      else{
        message = 'Introduzca en formato valido';
      }
      print('mensge $message');
      Fluttertoast.showToast(
          msg: message,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.black54,
          textColor: Colors.white,
          fontSize: 14.0);
    }
  }

  Future<void> logout({required BuildContext context}) async {
    await Future.delayed(const Duration(seconds: 1));

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return const HelloScreen();
    }));
  }

  Future<bool> isLoged({required BuildContext context}) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return false;
    }
    return true;
  }
}
