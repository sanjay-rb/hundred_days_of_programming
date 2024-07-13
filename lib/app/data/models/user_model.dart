import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  static const String COLLECTION_NAME = 'users';
  static CollectionReference<UserModel> userRef = FirebaseFirestore.instance
      .collection(COLLECTION_NAME)
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );

  String? bio;
  List<CompletedTasks>? completedTasks;
  String? email;
  String? github;
  String? id;
  Timestamp? lastSubmittedDate;
  String? linkedin;
  int? maxStreak;
  String? name;
  int? streak;

  UserModel(
      {this.bio,
      this.completedTasks,
      this.email,
      this.github,
      this.id,
      this.lastSubmittedDate,
      this.linkedin,
      this.maxStreak,
      this.name,
      this.streak});

  Future<void> addUser() async {
    await userRef.doc(id).set(this);
  }

  Future<void> updateUser() async {
    await userRef.doc(id).set(this);
  }

  Future<void> deleteUser() async {
    await userRef.doc(id).delete();
  }

  static Future<UserModel> getUser(String id) async {
    return (await userRef.doc(id).get()).data()!;
  }

  static Stream<DocumentSnapshot<UserModel>> getUserStreamByID(String id) {
    return userRef.doc(id).snapshots();
  }

  UserModel.fromJson(Map<String, dynamic> json) {
    bio = json['bio'];
    if (json['completedTasks'] != null) {
      completedTasks = <CompletedTasks>[];
      json['completedTasks'].forEach((v) {
        completedTasks?.add(CompletedTasks.fromJson(v));
      });
    }
    email = json['email'];
    github = json['github'];
    id = json['id'];
    lastSubmittedDate = json['lastSubmittedDate'];
    linkedin = json['linkedin'];
    maxStreak = json['maxStreak'];
    name = json['name'];
    streak = json['streak'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['bio'] = bio;
    if (completedTasks != null) {
      data['completedTasks'] = completedTasks?.map((v) => v.toJson()).toList();
    }
    data['email'] = email;
    data['github'] = github;
    data['id'] = id;
    data['lastSubmittedDate'] = lastSubmittedDate;
    data['linkedin'] = linkedin;
    data['maxStreak'] = maxStreak;
    data['name'] = name;
    data['streak'] = streak;
    return data;
  }
}

class CompletedTasks {
  String? taskID;
  String? githubLink;
  String? linkedinLink;
  Timestamp? submittedDate;

  CompletedTasks(
      {this.taskID, this.githubLink, this.linkedinLink, this.submittedDate});

  CompletedTasks.fromJson(Map<String, dynamic> json) {
    taskID = json['taskID'];
    githubLink = json['githubLink'];
    linkedinLink = json['linkedinLink'];
    submittedDate = json['submittedDate'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['taskID'] = taskID;
    data['githubLink'] = githubLink;
    data['linkedinLink'] = linkedinLink;
    data['submittedDate'] = submittedDate;
    return data;
  }
}
