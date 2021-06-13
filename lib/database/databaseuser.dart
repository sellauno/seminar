import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;

class DatabaseUser {
  static String userUid;
  static String role;

  static Future<void> addUser({
    String email,
    String nama,
    String noTelp,
  }) async {
    DocumentReference documentReferencer =
    FirebaseFirestore.instance.collection(role).doc(userUid);

    Map<String, dynamic> data = <String, dynamic>{
      "email": email,
      "nama": nama,
      "noTelp": noTelp,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("User added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateUser({
    String docId,
    String email,
    String nama,
    String noTelp,

  }) async {
    DocumentReference documentReferencer =
        FirebaseFirestore.instance.collection(role).doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "email": email,
      "nama": nama,
      "noTelp": noTelp,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("User updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readPembeli() {
    CollectionReference userItemCollection =
        FirebaseFirestore.instance.collection("pembeli");

    return userItemCollection.snapshots();
  }

  static Future<bool> isAdmin({
    String uid,
  }) async {
    DocumentReference documentReferencer = _firestore.collection('admin').doc(uid);
    if(documentReferencer!=null){
      return true;
    }else{
      return false;
    }
  }

  static Future<void> deleteUser({
    String docId,
  }) async {
    DocumentReference documentReferencer =
        FirebaseFirestore.instance.collection(role).doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('User deleted from the database'))
        .catchError((e) => print(e));
  }
}
