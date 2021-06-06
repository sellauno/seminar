import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('seminar');

class DatabaseSeminar {
  static String userUid;

  static Future<void> addSeminar({
    String judul,
    String pembicara,
    String waktu,
    String lokasi,
    int kuota,
    int harga,

  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc();

    Map<String, dynamic> data = <String, dynamic>{
      "judul": judul,
      "pembicara": pembicara,
      "waktu": waktu,
      "lokasi": lokasi,
      "kuota": kuota,
      "harga": harga,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Item added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updateSeminar({
    String docId,
    String judul,
    String pembicara,
    String waktu,
    String lokasi,
    int kuota,
    int harga,

  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "judul": judul,
      "pembicara": pembicara,
      "waktu": waktu,
      "lokasi": lokasi,
      "kuota": kuota,
      "harga": harga,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Item updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readSeminar() {
    CollectionReference seminarItemCollection =
        _mainCollection;

    return seminarItemCollection.snapshots();
  }

  static Future<void> deleteSeminar({
    String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Item deleted from the database'))
        .catchError((e) => print(e));
  }
}
