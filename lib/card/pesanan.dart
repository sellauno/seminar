import 'package:flutter/material.dart';

class PesananCard extends StatelessWidget {
  final String nama;
  final String email;
  final String noTelp;
  final String idSeminar;
  //// Pointer to Update Function
  final Function onUpdate;
  //// Pointer to Delete Function
  final Function onDelete;

  PesananCard(this.nama, this.email, this.noTelp, this.idSeminar, this.onUpdate, this.onDelete);

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
          style: TextStyle(fontSize: 25),
        ),
        subtitle: Text("Nama : " + nama +
            "\nNo Telp : " + noTelp + 
            "\nSeminar : " + idSeminar),
        trailing: GestureDetector(
          child: Icon(Icons.delete),
          onTap: () async {
            //Memanggil Fungsi untuk Delete dari DB berdasarkan Seminar
            // await dbHelperSeminar.delete(seminarList[index].id);
            // updateListView();
          },
        ),
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
