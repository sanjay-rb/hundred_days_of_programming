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
    lastSubmittedDate: Timestamp.now(),
  ).obs;

  Future<bool> isLoggedIn() async {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      user.value = await UserModel.getUser(currentUser.uid);
      return true;
    }
    return false;
  }

  Future<String?> signUp(name, email, password) async {
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
    } catch (e) {
      return e.toString();
    }
    String id = userCredential.user!.uid;
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
    return null;
  }

  Future<String?> signIn(email, password) async {
    UserCredential? userCredential;
    try {
      userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      return e.toString();
    }
    String id = userCredential.user!.uid;
    user.value = await UserModel.getUser(id);
    return null;
  }

  Future<void> deleteUser() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        UserModel user = await UserModel.getUser(currentUser.uid);
        user.deleteUser().then((value) {
          currentUser.delete().then((value) {
            Get.offAllNamed(Routes.LOGIN);
            LoggerService.info("User Deleted Successfully!");
          }).onError((error, stackTrace) {
            user.addUser();
            LoggerService.error(error.toString());
          });
        }).onError((error, stackTrace) {
          LoggerService.error(error.toString());
        });
      }
    } catch (e) {
      LoggerService.error(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      Get.back(closeOverlays: true);
      LoggerService.error(e.toString());
    }
  }
}
