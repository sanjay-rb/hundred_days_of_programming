// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class User {
  static const String collectionName = 'users';
  static CollectionReference<User> userRef =
      FirebaseFirestore.instance.collection(collectionName).withConverter<User>(
            fromFirestore: (snapshot, _) => User.fromMap(snapshot.data()!),
            toFirestore: (movie, _) => movie.toMap(),
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

  User({
    required this.id,
    required this.name,
    required this.bio,
    required this.email,
    required this.github,
    required this.linkedin,
    required this.maxStreak,
    required this.streak,
    required this.completedTasks,
  });

  User copyWith({
    String? id,
    String? name,
    String? bio,
    String? email,
    String? github,
    String? linkedin,
    int? maxStreak,
    int? streak,
    List? completedTasks,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      bio: bio ?? this.bio,
      email: email ?? this.email,
      github: github ?? this.github,
      linkedin: linkedin ?? this.linkedin,
      maxStreak: maxStreak ?? this.maxStreak,
      streak: streak ?? this.streak,
      completedTasks: completedTasks ?? this.completedTasks,
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
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
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
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'User(id: $id, name: $name, bio: $bio, email: $email, github: $github, linkedin: $linkedin, maxStreak: $maxStreak, streak: $streak, completedTasks: $completedTasks)';
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.bio == bio &&
        other.email == email &&
        other.github == github &&
        other.linkedin == linkedin &&
        other.maxStreak == maxStreak &&
        other.streak == streak &&
        listEquals(other.completedTasks, completedTasks);
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
        completedTasks.hashCode;
  }
}
