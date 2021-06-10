import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seminar/database/databasepesanan.dart';
import 'package:seminar/database/databaseseminar.dart';
import 'package:intl/intl.dart';
// import 'dbhelperseminar.dart';
// import 'seminar.dart';
// import 'pesanan.dart';

class EntryForm extends StatefulWidget {
  // final Pesanan pesanan;
  //EntryForm(this.pesanan);
  @override
  EntryFormState createState() => EntryFormState(/*this.pesanan*/);
}

//class controller
class EntryFormState extends State<EntryForm> {
  TextEditingController namaController = TextEditingController();
  TextEditingController idSeminarController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  String total;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Tambah'),
          leading: Icon(Icons.keyboard_arrow_left),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
// nama
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: namaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),
// email
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),
// No Telepon
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: notelpController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'No Telepon',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),

              StreamBuilder<QuerySnapshot>(
                stream: DatabaseSeminar.readSeminar(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  } else if (snapshot.hasData || snapshot.data != null) {
                    return Padding(
                      padding:
                          EdgeInsets.only(top: 20.0, bottom: 20.0, right: 10.0),
                      child: DropdownButtonFormField(
                        hint: Text('Pilih Seminar yang diinginkan'),
                        items:
                            snapshot.data.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data();
                          total = data['harga'];
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
                            idSeminarController.text = value.id;
                            totalController.text = total;
                          });
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),

              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: totalController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Total',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
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
                            Navigator.of(context).pop();
                          }),
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
}
