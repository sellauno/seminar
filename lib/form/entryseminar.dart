import 'package:flutter/material.dart';
// import 'seminar.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import '../database/databaseseminar.dart';

class EntryFormSeminar extends StatefulWidget {
  @override
  EntryFormSeminarState createState() => EntryFormSeminarState(/*this.seminar*/);
}

class EntryFormSeminarState extends State<EntryFormSeminar> {
  TextEditingController judulController = TextEditingController();
  TextEditingController waktuController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController kuotaController = TextEditingController();
  TextEditingController lokasiController = TextEditingController();
  TextEditingController pembicaraController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
//kondisi
    // if (seminar != null) {
    //   judulController.text = seminar.judul;
    //   waktuController.text = seminar.waktu;
    //   hargaController.text = seminar.harga.toString();
    //   kuotaController.text = seminar.kuota.toString();
    //   lokasiController.text = seminar.lokasi;
    //   pembicaraController.text = seminar.getPembicara;
    // }
//ubah
    return Scaffold(
        appBar: AppBar(
          title: Text('Tambah'),
          leading: Icon(Icons.keyboard_arrow_left),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
// judul
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: judulController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Judul',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),

// Harga
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: hargaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Harga',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),
// kuota
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: kuotaController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Kuota',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),
// Lokasi
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: lokasiController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Lokasi',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),

// Pembicara
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: pembicaraController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Pembicara',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onChanged: (value) {
//
                  },
                ),
              ),

// waktu
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  readOnly: true,
                  controller: waktuController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Waktu',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                  onTap: () => _selectDate(context),
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
                          await DatabaseSeminar.addSeminar(
                            judul : judulController.text,
                            waktu : waktuController.text,
                            harga : int.parse(hargaController.text),
                            kuota : int.parse(kuotaController.text),
                            lokasi : lokasiController.text,
                            pembicara : pembicaraController.text,
                      );
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
//DatePicker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate ?? DateTime.now()),
      );
      if (time != null)
        setState(() {
          selectedDate = picked;
          var formatter = new DateFormat('yyyy-MM-dd');
          String date = formatter.format(selectedDate);
          waktuController.text = date + " " + time.format(context).toString();
        });
    }
  }
}
