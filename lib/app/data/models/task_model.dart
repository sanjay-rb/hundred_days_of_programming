import 'package:cloud_firestore/cloud_firestore.dart';

class TaskModel {
  static const String COLLECTION_NAME = 'tasks';
  static CollectionReference<TaskModel> taskRef = FirebaseFirestore.instance
      .collection(COLLECTION_NAME)
      .withConverter<TaskModel>(
        fromFirestore: (snapshot, _) => TaskModel.fromJson(snapshot.data()!),
        toFirestore: (task, _) => task.toJson(),
      );

  int? day;
  List<String>? description;
  String? id;
  List<String>? testCases;
  String? title;

  TaskModel({this.day, this.description, this.id, this.testCases, this.title});

  static Future<List<TaskModel>> getTaskDetails() async {
    QuerySnapshot<TaskModel> data = await taskRef.get();
    return data.docs.map((e) => e.data()).toList();
  }

  TaskModel.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    description = json['description']?.cast<String>();
    id = json['id'];
    testCases = json['testCases']?.cast<String>();
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['day'] = day;
    data['description'] = description;
    data['id'] = id;
    data['testCases'] = testCases;
    data['title'] = title;
    return data;
  }

  @override
  String toString() {
    return "TaskModel($id, $day, $title, $description)";
  }
}
