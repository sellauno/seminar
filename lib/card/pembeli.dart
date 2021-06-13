import 'package:flutter/material.dart';

class PembeliCard extends StatelessWidget {
  final String nama;
  final String email;
  final String noTelp;
  final String docId;

  PembeliCard(this.nama, this.email, this.noTelp, this.docId);

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
        subtitle: Text("Nama : " + nama +
            "\nEmail : " + email + 
            "\nNo Telp : " + noTelp),
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
