import 'package:flutter/material.dart';
import 'package:seminar/form/editseminar.dart';

class SeminarCard extends StatelessWidget {
  final String judul;
  final String pembicara;
  final String waktu;
  final String lokasi;
  final int kuota;
  final int harga;
  final String docId;
  //// Pointer to Update Function
  //final Function onUpdate;
  //// Pointer to Delete Function
  final Function onDelete;

  SeminarCard(this.judul, this.pembicara, this.waktu, this.lokasi, this.kuota,
      this.harga, this.docId, {this.onDelete});

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
          subtitle: Text("Pembicara : " +
              pembicara +
              "\nWaktu : " +
              waktu +
              "\nLokasi : " +
              lokasi +
              "\nKuota  : " +
              kuota.toString() +
              "\nHarga  : " +
              harga.toString()),
          trailing: GestureDetector(
            child: Icon(Icons.delete),
            onTap: () async {
              onDelete();
            },
          ),
          onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EditFormSeminar(
                    judul: this.judul,
                    pembicara: this.pembicara,
                    waktu: this.waktu,
                    lokasi: this.lokasi,
                    kuota: this.kuota,
                    harga: this.harga,
                    documentId: this.docId,
                  ),
                ),
              ),
          ),
    );
  }
}
