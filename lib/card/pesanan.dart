import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PesananCard extends StatelessWidget {
  final String nama;
  final String email;
  final String noTelp;
  final String idSeminar;
  final String time;
  final String docId;
  final Function onDelete;

  PesananCard(
      this.nama, this.email, this.noTelp, this.idSeminar, this.time, this.docId,
      {this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Icon(Icons.date_range),
        ),
        title: Text(
          email,
          style: TextStyle(fontSize: 20),
        ),
        subtitle: Text("Nama : " +
            nama +
            "\nNo Telp : " +
            noTelp +
            "\nSeminar : " +
            idSeminar +
            "\n" +
            time),
        onTap: () async {
          // var seminar = await navigateToEntryForm(context, this.seminarList[index]);
          // Memanggil Fungsi untuk Edit data
          // await dbHelperSeminar.update(seminar);
          // updateListView();
        },
      ),
    );
  }
}
