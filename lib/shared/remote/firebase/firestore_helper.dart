import 'package:cloud_firestore/cloud_firestore.dart';

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

 static Future<void >AddUser(String userID, String email, String fullName) async {
     var document = GetUsersCollections().doc(userID);
     await  document.set(User(id: userID, email: email, fullName: fullName));
  }

 static Future<User?> GetUser (String userID) async {
    var document = GetUsersCollections().doc(userID);
    var snapshot = await document.get();
   User? user = snapshot.data();
  }
}
