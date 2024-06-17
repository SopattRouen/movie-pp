import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:movietime/src/enum/enum.dart';

class AuthService extends GetxController {
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
    } on FirebaseAuthException catch (e) {
      return e;
    } catch (e) {
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Notification", "No user found for that email");
      } else if (e.code == 'wrong-password') {
        return;
      }
    }
  }

  Future signout() async {
    await FirebaseAuth.instance.signOut();
  }

  User? getCurrentUser() {
    return FirebaseAuth.instance.currentUser;
  }
}
