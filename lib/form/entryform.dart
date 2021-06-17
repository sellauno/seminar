import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seminar/database/databasepesanan.dart';
import 'package:seminar/database/databaseseminar.dart';
import 'package:intl/intl.dart';
import 'package:seminar/login/loginprosesgoogle.dart';
import 'package:seminar/pages/akun.dart';

class EntryForm extends StatefulWidget {
  final int kuota;
  final String id;
  final String total;

  const EntryForm(this.kuota, this.id, this.total);

  @override
  EntryFormState createState() =>
      EntryFormState(this.kuota, this.id, this.total);
}

//class controller
class EntryFormState extends State<EntryForm> {
  final int pilKuota;
  final String pilId;
  final String pilTotal;
  TextEditingController namaController = TextEditingController();
  TextEditingController idSeminarController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  int total;
  int kuota;
  CollectionReference _seminar =
      FirebaseFirestore.instance.collection('seminar');

  EntryFormState(this.pilKuota, this.pilId, this.pilTotal);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataAkun();
  }

  @override
  Widget build(BuildContext context) {
    if (pilTotal != null) {
      totalController.text = pilTotal;
      idSeminarController.text = pilId;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text('Buat Pesanan'),
          leading: Icon(Icons.keyboard_arrow_left),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
// nama
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: TextField(
                  controller: namaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),
// email
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),
// No Telepon
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: TextField(
                  controller: notelpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'No Telepon',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),
              // dropDown(),

              StreamBuilder<QuerySnapshot>(
                stream: _seminar.where('kuota', isGreaterThan: 0).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return Padding(
                      padding:
                          EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
                      child: DropdownButtonFormField(
                        hint: Text('Pilih Seminar yang diinginkan'),
                        value: pilId,
                        items:
                            snapshot.data.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data();

                          total = data['harga'];
                          kuota = data['kuota'];

                          return new DropdownMenuItem<String>(
                            value: document.id,
                            child: Column(
                              children: [
                                new Text(
                                  data['judul'],
                                ),
                                // new Text(
                                //   " (Rp "+ data['harga'].toString() +")",
                                // ),
                              ],
                            ),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            idSeminarController.text = value;
                            totalController.text = total.toString();
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),

              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: TextField(
                  controller: totalController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Total',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),
// tombol button
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
// tombol simpan
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        onPressed: () async {
                          var formatter = new DateFormat('yyyy-MM-dd hh:mm');
                          String date = formatter.format(DateTime.now());
                          await DatabasePesanan.addPesanan(
                            email: emailController.text,
                            nama: namaController.text,
                            noTelp: notelpController.text,
                            time: date,
                            idSeminar: idSeminarController.text,
                          );
                          int fixKuota;
                          if(pilKuota !=null){
                            fixKuota = pilKuota;
                          }else{
                            fixKuota = kuota;
                          }
                          await FirebaseFirestore.instance
                              .collection('seminar')
                              .doc(idSeminarController.text)
                              .update({"kuota": fixKuota - 1});
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
// tombol batal
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void dataAkun() async {
    await FirebaseFirestore.instance
        .collection('pembeli')
        .doc(userUid)
        .get()
        .then((DocumentSnapshot ds) {
      Map<String, dynamic> data = ds.data();
      namaController.text = data["nama"];
      emailController.text = data["email"];
      notelpController.text = data["noTelp"];
    });
  }
}
