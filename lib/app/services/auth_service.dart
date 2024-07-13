import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:hundred_days_of_programming/app/data/models/user_model.dart';
import 'package:hundred_days_of_programming/app/routes/app_pages.dart';
import 'package:hundred_days_of_programming/app/services/logger_service.dart';

class AuthService extends GetxService {
  Rx<UserModel> user = UserModel(
          id: "id",
          name: "name",
          bio: "bio",
          email: "email",
          github: "github",
          linkedin: "linkedin",
          maxStreak: 0,
          streak: 0,
          completedTasks: [],
          lastSubmittedDate: Timestamp.now())
      .obs;

  Future<bool> isLoggedIn() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      // userID.value = currentUser.uid;
      user.value = await UserModel.getUser(currentUser.uid);
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
      if (userCredential.credential != null) {
        await FirebaseAuth.instance.signInWithCredential(
          userCredential.credential!,
        );
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        LoggerService.error("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        LoggerService.info('The account already exists for that email.');
      } else {
        LoggerService.error(e.toString());
      }
    } catch (e) {
      LoggerService.error(e.toString());
    }
    if (userCredential != null) {
      String id = userCredential.user!.uid;
      // userID.value = id;
      UserModel userModel = UserModel(
        id: id,
        name: (name != null && name != "") ? name : "New User",
        bio: "",
        email: email,
        github: "",
        linkedin: "",
        maxStreak: 0,
        streak: 0,
        completedTasks: [],
        lastSubmittedDate: Timestamp.fromDate(
          DateTime.now().subtract(
            const Duration(days: 1),
          ),
        ),
      );
      await userModel.addUser();
      user.value = userModel;
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
      } else if (e.code == 'invalid-credential') {
        LoggerService.error(
            "Invalid User! If you are new to 100 Days of Programming, please try signing up.");
      } else {
        LoggerService.error(e.toString());
      }
    } catch (e) {
      LoggerService.error(e.toString());
    }
    if (userCredential != null) {
      String id = userCredential.user!.uid;
      // userID.value = id;
      user.value = await UserModel.getUser(id);
      return true;
    }
    return false;
  }

  Future<void> updateUser() async {
    await user.value.updateUser();
  }

  Future<void> deleteUser() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        user.value = await UserModel.getUser(currentUser.uid);
        currentUser.delete().then(
          (value) {
            user.value.deleteUser().then(
              (value) {
                Get.offAllNamed(Routes.LOGIN);
                LoggerService.info("User Deleted Successfully!");
              },
            ).onError(
              (error, stackTrace) {
                LoggerService.error(error.toString());
              },
            );
          },
        ).onError(
          (error, stackTrace) {
            LoggerService.error(error.toString());
          },
        );
      }
    } catch (e) {
      LoggerService.error(e.toString());
    }
  }

  signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      LoggerService.error(e.toString());
    }
  }
}
