import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:movietime/src/enum/enum.dart';

class AuthService extends GetxController{
  final form = FormControll();
  Future createAcount() async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: form.con_mail.text.trim(),
        password: form.con_pass.text.trim(),
      );
      if (credential != 0) {
        Get.snackbar("Notification", "Congrate Your already signup");
      } else {
        Get.snackbar("Notification", "Fail");
      }
      log("$credential");
    } on FirebaseAuthException catch (e) {
      log("$e");
    } catch (e) {
      print(e);
      Get.snackbar("Notification", "$e");
    }
  }

  Future signIn() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: form.con_mail.text.trim(),
        password: form.con_pass.text.trim(),
      );
      if (credential != 0) {
        Get.snackbar("Notification", "Success");
      } else {
        Get.snackbar("Notification", "Fail");
      }
      log("$credential");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.snackbar("Notification", "No user found for that email");
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future signout() async {
    await FirebaseAuth.instance.signOut();
  }
  // User getCurrentUser() {
  //   // Replace this with your actual implementation
  //   // For example, fetching from Firebase Auth or your backend
  //   return User("john_doe", "john.doe@example.com");
  // }
    User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
