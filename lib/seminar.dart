import 'package:flutter/material.dart';

class SeminarCard extends StatelessWidget {
  final String judul;
  final String pembicara;
  final String waktu;
  final String lokasi;
  final int kuota;
  final int harga;
  //// Pointer to Update Function
  final Function onUpdate;
  //// Pointer to Delete Function
  final Function onDelete;

  SeminarCard(this.judul,this.pembicara,this.waktu,this.lokasi,this.kuota,this.harga,
  {this.onUpdate, this.onDelete});

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
          judul,
          style: TextStyle(fontSize: 25),
        ),
        subtitle: Text("Pembicara : " + pembicara +
            "\nWaktu : " + waktu + 
            "\nLokasi : " + lokasi +
            "\nKuota  : " + kuota.toString() +
            "\nHarga  : "+ harga.toString()),
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
