import 'package:flutter/material.dart';
import 'package:seminar/form/entryform.dart';
import 'package:seminar/login/loginprosesgoogle.dart';

class SeminarPembeliCard extends StatelessWidget {
  final String judul;
  final String pembicara;
  final String waktu;
  final String lokasi;
  final int kuota;
  final int harga;
  final String docId;

  SeminarPembeliCard(this.judul, this.pembicara, this.waktu, this.lokasi,
      this.kuota, this.harga, this.docId);

  @override
  Widget build(BuildContext context) {
    TextStyle txt = TextStyle(fontSize: 15);
    return Card(
      color: Colors.white,
      elevation: 2.0,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                judul,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Text(
                "Pembicara : " + pembicara,
                style: txt,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 8, left: 5, right: 5, bottom: 10),
                  child: Text(
                    "Waktu : " + waktu + "\nLokasi : " + lokasi,
                    style: txt,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Kuota  : " +
                      kuota.toString() +
                      "\nHarga  : " +
                      harga.toString(),
                  style: txt,
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: RaisedButton(
                onPressed: () {
                  if (userUid != null) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                          builder: (context) => EntryForm(judul, docId)),
                    );
                  } else {
                    Navigator.pushNamed(context, '/login');
                  }
                },
                color: Colors.amber,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Text(
                      'Pesan Sekarang',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
              ),
            ),
          ],
        ),

        // onTap: () {
        // if (userUid != null) {
        //   Navigator.of(context).push(
        //     MaterialPageRoute(builder: (context) => EntryForm(null, null)),
        //   );
        // } else {
        //   Navigator.pushNamed(context, '/login');
        // }
        // },
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
      ),
    );

    // return Card(
    //   color: Colors.white,
    //   elevation: 2.0,
    //   child: ListTile(
    //     leading: CircleAvatar(
    //       backgroundColor: Colors.red,
    //       child: Icon(Icons.date_range),
    //     ),
    //     title: Text(
    //       judul,
    //       style: TextStyle(fontSize: 25),
    //     ),
    //     subtitle:
    //         Text("Pembicara : " +
    //             pembicara +
    //             "\nWaktu : " +
    //             waktu +
    //             "\nLokasi : " +
    //             lokasi +
    //             "\nKuota  : " +
    //             kuota.toString() +
    //             "\nHarga  : " +
    //             harga.toString()),
    //     onTap: () {
    //       if (userUid != null) {
    //         Navigator.of(context).push(
    //           MaterialPageRoute(builder: (context) => EntryForm(null, null)),
    //         );
    //       } else {
    //         Navigator.pushNamed(context, '/login');
    //       }
    //     },
    //   ),
    // );
  }
}
