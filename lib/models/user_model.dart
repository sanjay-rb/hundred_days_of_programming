// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class UserModel {
  static const String collectionName = 'users';
  static CollectionReference<UserModel> userRef = FirebaseFirestore.instance
      .collection(collectionName)
      .withConverter<UserModel>(
        fromFirestore: (snapshot, _) => UserModel.fromMap(snapshot.data()!),
        toFirestore: (user, _) => user.toMap(),
      );

  String id;
  String name;
  String bio;
  String email;
  String github;
  String linkedin;
  int maxStreak;
  int streak;
  List completedTasks;
  Timestamp lastSubmittedDate;

  UserModel({
    required this.id,
    required this.name,
    required this.bio,
    required this.email,
    required this.github,
    required this.linkedin,
    required this.maxStreak,
    required this.streak,
    required this.completedTasks,
    required this.lastSubmittedDate,
  });

  static Stream<DocumentSnapshot<UserModel>> getUserStreamByID(String id) {
    return userRef.doc(id).snapshots();
  }

  addUser() async {
    await userRef.doc(id).set(this);
  }

  static Future<UserModel?> getUser(String id) async {
    return (await userRef.doc(id).get()).data();
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? bio,
    String? email,
    String? github,
    String? linkedin,
    int? maxStreak,
    int? streak,
    List? completedTasks,
    Timestamp? lastSubmittedDate,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      github: github ?? this.github,
      linkedin: linkedin ?? this.linkedin,
      maxStreak: maxStreak ?? this.maxStreak,
      streak: streak ?? this.streak,
      completedTasks: completedTasks ?? this.completedTasks,
      lastSubmittedDate: lastSubmittedDate ?? this.lastSubmittedDate,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'bio': bio,
      'email': email,
      'github': github,
      'linkedin': linkedin,
      'maxStreak': maxStreak,
      'streak': streak,
      'completedTasks': completedTasks,
      'lastSubmittedDate': lastSubmittedDate,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as String,
      name: map['name'] as String,
      bio: map['bio'] as String,
      email: map['email'] as String,
      github: map['github'] as String,
      linkedin: map['linkedin'] as String,
      maxStreak: map['maxStreak'] as int,
      streak: map['streak'] as int,
      completedTasks: List.from(
        (map['completedTasks'] as List),
      ),
      lastSubmittedDate: map['lastSubmittedDate'] as Timestamp,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(id: $id, name: $name, bio: $bio, email: $email, github: $github, linkedin: $linkedin, maxStreak: $maxStreak, streak: $streak, completedTasks: $completedTasks, lastSubmittedDate: $lastSubmittedDate)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.bio == bio &&
        other.email == email &&
        other.github == github &&
        other.linkedin == linkedin &&
        other.maxStreak == maxStreak &&
        other.streak == streak &&
        listEquals(other.completedTasks, completedTasks) &&
        other.lastSubmittedDate == lastSubmittedDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        bio.hashCode ^
        email.hashCode ^
        github.hashCode ^
        linkedin.hashCode ^
        maxStreak.hashCode ^
        streak.hashCode ^
        completedTasks.hashCode ^
        lastSubmittedDate.hashCode;
  }
}
