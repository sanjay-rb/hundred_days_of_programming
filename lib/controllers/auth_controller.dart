import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hundred_days_of_programming/services/logger_service.dart';

class AuthController extends GetxController {
  RxString userID = "".obs;

  Future<bool> isLoggedIn() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      userID.value = currentUser.uid;
      return true;
    }
    return false;
  }

  Future<bool> signUp(name, email, password) async {
    UserCredential? userCredential;
    try {
      userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        LoggerService.error("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        LoggerService.info('The account already exists for that email.');
      }
    } catch (e) {
      LoggerService.error(e.toString());
    }
    if (userCredential != null) {
      String id = userCredential.user!.uid;
      userID.value = id;
      return true;
    }
    return false;
  }

  Future<bool> signIn(email, password) async {
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        LoggerService.info('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        LoggerService.error('Wrong password provided for that user.');
      }
    } catch (e) {
      LoggerService.error(e.toString());
    }
    if (userCredential != null) {
      String id = userCredential.user!.uid;
      userID.value = id;
      return true;
    }
    return false;
  }

  Future<void> deleteUser() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        await user.delete();
        // User deleted, handle additional logic here if needed
        Get.snackbar('Success', 'User deleted successfully');
      }
    } catch (e) {
      LoggerService.error(e.toString());
    }
  }

  signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed('/login');
    } catch (e) {
      LoggerService.error(e.toString());
    }
  }
}
