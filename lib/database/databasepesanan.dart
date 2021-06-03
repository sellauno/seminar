import 'package:cloud_firestore/cloud_firestore.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('tiket');

class DatabasePesanan {
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
        _mainCollection.doc(userUid).collection('seminar').doc();

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
        .whenComplete(() => print("Note item added to the database"))
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
        _mainCollection.doc(userUid).collection('seminar').doc(docId);

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
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readSeminar() {
    CollectionReference notesItemCollection =
        _mainCollection.doc(userUid).collection('seminar');

    return notesItemCollection.snapshots();
  }

  static Future<void> deleteSeminar({
    String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('seminar').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
