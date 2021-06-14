import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seminar/database/databasepesanan.dart';
import 'package:seminar/database/databaseseminar.dart';
import 'package:intl/intl.dart';

class EntryForm extends StatefulWidget {
  final String seminar;
  final String id;

  const EntryForm(this.seminar, this.id);

  @override
  EntryFormState createState() => EntryFormState(this.seminar, this.id);
}

//class controller
class EntryFormState extends State<EntryForm> {
  final String pilSeminar;
  final String pilId;
  TextEditingController namaController = TextEditingController();
  TextEditingController idSeminarController = TextEditingController();
  TextEditingController idSeminarController2 = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController notelpController = TextEditingController();
  TextEditingController totalController = TextEditingController();
  int total;
  int kuota;

  EntryFormState(this.pilSeminar, this.pilId);

  @override
  Widget build(BuildContext context) {
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
              dropDown(),

              // StreamBuilder<QuerySnapshot>(
              //   stream: DatabaseSeminar.readSeminar(),
              //   builder: (context, snapshot) {
              //     if (snapshot.hasError) {
              //       return Text('Something went wrong');
              //     } else if (snapshot.hasData || snapshot.data != null) {
              //       return Padding(
              //         padding:
              //             EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
              //         child: DropdownButtonFormField(
              //           hint: Text('Pilih Seminar yang diinginkan'),
              //           items:
              //               snapshot.data.docs.map((DocumentSnapshot document) {
              //             Map<String, dynamic> data = document.data();

              //             total = data['harga'];
              //             kuota = data['kuota'];

              //             return new DropdownMenuItem<String>(
              //               value: document.id,
              //               child: Column(
              //                 children: [
              //                   new Text(
              //                     data['judul'],
              //                   ),
              //                   // new Text(
              //                   //   " (Rp "+ data['harga'].toString() +")",
              //                   // ),
              //                 ],
              //               ),
              //             );
              //           }).toList(),
              //           onChanged: (value) {
              //             setState(() {
              //               idSeminarController.text = value;
              //               totalController.text = total.toString();
              //             });
              //           },
              //           decoration: InputDecoration(
              //             border: OutlineInputBorder(
              //               borderRadius: BorderRadius.circular(20.0),
              //             ),
              //           ),
              //         ),
              //       );
              //     }
              //   },
              // ),

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
                          await FirebaseFirestore.instance
                              .collection('seminar')
                              .doc(idSeminarController.text)
                              .update({"kuota": kuota - 1});
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

  Widget dropDown() {
    if (this.pilSeminar == null) {
      return StreamBuilder<QuerySnapshot>(
        stream: DatabaseSeminar.readSeminar(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          } else if (snapshot.hasData || snapshot.data != null) {
            return Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 10.0),
              child: DropdownButtonFormField(
                hint: Text('Pilih Seminar yang diinginkan'),
                items: snapshot.data.docs.map((DocumentSnapshot document) {
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
      );
    } else {
      setState(() {
        idSeminarController2.text = pilSeminar;
        idSeminarController.text = pilId;
      });
      return Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
        child: TextField(
          controller: idSeminarController2,
          readOnly: true,
          decoration: InputDecoration(
            labelText: 'Seminar',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onChanged: (value) {
//
          },
        ),
      );
    }
  }
}
