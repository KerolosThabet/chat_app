import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../model/task.dart';
import '../../../model/user.dart';

class FirestoreHelper {
  static CollectionReference<User> GetUsersCollections() {
    var reference = FirebaseFirestore.instance.collection("User").withConverter(
      fromFirestore: (snapshot, options) {
        Map<String, dynamic>? data = snapshot.data();
        return User.fromFirestore(data ?? {});
      },
      toFirestore: (user, options) {
        return user.toFirestore();
      },
    );
    return reference;
  }

  static Future<void> AddUser(
      String userID, String email, String fullName) async {
    var document = GetUsersCollections().doc(userID);
    await document.set(User(id: userID, email: email, fullName: fullName));
  }

  static Future<User?> GetUser(String userID) async {
    var document = GetUsersCollections().doc(userID);
    var snapshot = await document.get();
    User? user = snapshot.data();
  }

  static CollectionReference<Task> GetTasksCollections(String userID) {
    var TaskCollection =
        GetUsersCollections().doc(userID).collection("Tasks").withConverter(
              fromFirestore: (snapshot, options) =>
                  Task.fromFirestore(snapshot.data() ?? {}),
              toFirestore: (Task, options) => Task.toFirestore(),
            );
    return TaskCollection;
  }

  static Future<void> AddTask(Task task , String userID) async {
    var reference = GetTasksCollections(userID);
    var taskDocument = reference.doc();
    task.id = taskDocument.id;
    await taskDocument.set(task);
  }

  static Future< List<Task> > GetAlltasks(userID)async{
 var taskQuery =  await  GetTasksCollections(userID).get();
     List<Task> TasksList =  taskQuery.docs.map((snapshot) => snapshot.data()).toList();
     return TasksList;
  }


  static Stream<List<Task>> ListenToTAsk (String uid,int date)async*{
    Stream<QuerySnapshot<Task>> taskStream =  GetTasksCollections(uid).where("date",isEqualTo: date).snapshots();
    Stream<List<Task>> ListTaskStream = taskStream.map((querySnapShot) => querySnapShot.docs.map((Document) =>Document.data()).toList());
    yield* ListTaskStream;
  }

  static Future<void> DeletTask  ({required String uid,required String taskId}) async {
   await GetTasksCollections(uid).doc(taskId).delete();
  }

  static Future<void> EditeTask(Task task , String userID) async {
    var reference = GetTasksCollections(userID);
    var taskDocument = reference.doc(task.id);
    await taskDocument.update(task.toFirestore());
  }

}

