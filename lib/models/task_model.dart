// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class TaskModel {
  static const String collectionName = 'tasks';
  static CollectionReference<TaskModel> taskRef = FirebaseFirestore.instance
      .collection(collectionName)
      .withConverter<TaskModel>(
        fromFirestore: (snapshot, _) => TaskModel.fromMap(snapshot.data()!),
        toFirestore: (task, _) => task.toMap(),
      );

  String id;
  int day;
  String title;
  List description;
  List testCases;
  TaskModel({
    required this.id,
    required this.day,
    required this.title,
    required this.description,
    required this.testCases,
  });

  static Future<QuerySnapshot<TaskModel>> getTaskDetails() {
    return taskRef.get();
  }

  TaskModel copyWith({
    String? id,
    int? day,
    String? title,
    List? description,
    List? testCases,
  }) {
    return TaskModel(
      id: id ?? this.id,
      day: day ?? this.day,
      title: title ?? this.title,
      description: description ?? this.description,
      testCases: testCases ?? this.testCases,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'day': day,
      'title': title,
      'description': description,
      'testCases': testCases,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] as String,
      day: map['day'] as int,
      title: map['title'] as String,
      description: List.from(
        (map['description'] as List),
      ),
      testCases: List.from(
        (map['testCases'] as List),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) =>
      TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TaskModel(id: $id, day: $day, title: $title, description: $description, testCases: $testCases)';
  }

  @override
  bool operator ==(covariant TaskModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.day == day &&
        other.title == title &&
        listEquals(other.description, description) &&
        listEquals(other.testCases, testCases);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        day.hashCode ^
        title.hashCode ^
        description.hashCode ^
        testCases.hashCode;
  }
}
