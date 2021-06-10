import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seminar/login/loginprosesgoogle.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _mainCollection = _firestore.collection('pembeli');

class DatabasePesanan {
  // static String userUid;

  static Future<void> addPesanan({
    String nama,
    String email,
    String noTelp,
    String time,
    String idSeminar,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('Pesanan').doc();

    Map<String, dynamic> data = <String, dynamic>{
      "nama": nama,
      "email": email,
      "noTelp": noTelp,
      "time": time,
      "idSeminar": idSeminar,
    };

    await documentReferencer
        .set(data)
        .whenComplete(() => print("Order added to the database"))
        .catchError((e) => print(e));
  }

  static Future<void> updatePesanan({
    String docId,
    String nama,
    String email,
    String noTelp,
    String time,
    String idSeminar,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('Pesanan').doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "nama": nama,
      "email": email,
      "noTelp": noTelp,
      "time": time,
      "idSeminar": idSeminar,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Order updated in the database"))
        .catchError((e) => print(e));
  }

  static Stream<QuerySnapshot> readPesanan() {
    CollectionReference pesananItemCollection =
        _mainCollection.doc(userUid).collection('Pesanan');

    return pesananItemCollection.snapshots();
  }

  static Future<void> deletePesanan({
    String docId,
  }) async {
    DocumentReference documentReferencer =
        _mainCollection.doc(userUid).collection('Pesanan').doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Order deleted from the database'))
        .catchError((e) => print(e));
  }
}
