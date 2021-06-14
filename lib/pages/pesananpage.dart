import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seminar/card/pesanan.dart';
import 'package:seminar/database/databasepesanan.dart';
import 'package:seminar/form/entryform.dart';
import 'package:seminar/login/loginprosesgoogle.dart';

class PesananPage extends StatefulWidget {
  @override
  _PesananPageState createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  int count = 1;
  int _selectedIndex = 1;
  CollectionReference _pesanan = FirebaseFirestore.instance
      .collection('pembeli')
      .doc(userUid)
      .collection('Pesanan');
  String judul = "-";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Riwayat Pesanan'),
        leading: Icon(Icons.assignment),
        automaticallyImplyLeading: false,
      ),
      body: Column(children: [
        Expanded(
          child: ListView(
            children: [
              StreamBuilder<QuerySnapshot>(
                // contoh penggunaan srteam
                // _seminar.orderBy('age', descending: true).snapshots()
                // _seminar.where('age', isLessThan: 30).snapshots()
                // stream: _seminar.orderBy('age', descending: true).snapshots(),
                stream: DatabasePesanan.readPesanan(),
                builder: (buildContext, snapshot) {
                  if (snapshot.data == null) return CircularProgressIndicator();
                  return Column(
                    children: snapshot.data.docs.map((e) {
                      Map<String, dynamic> data = e.data();
                      dataSeminar(data['idSeminar']);
                      return PesananCard(
                        data['nama'],
                        data['email'],
                        data['noTelp'],
                        judul,
                        data['time'],
                        e.id,
                        onDelete: () {
                          _pesanan.doc(e.id).delete();
                        },
                      );
                    }).toList(),
                  );
                },
              ),
              SizedBox(
                height: 150,
              )
            ],
          ),
        ),
        Container(
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.all(20),
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              if (userUid != null) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => EntryForm(null, null)),
                );
              }else{
                Navigator.pushNamed(context, '/login');
              }
            },
          ),
        ),
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Beranda'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            title: Text('Pesanan'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Akun'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            if (_selectedIndex == 0) {
              Navigator.pushNamed(context, '/homePembeli');
            } else if (_selectedIndex == 1) {
              Navigator.pushNamed(context, '/pesanan');
            } else {
              var user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                Navigator.pushNamed(context, '/akun');
              } else {
                Navigator.pushNamed(context, '/login');
              }
            }
          });
        },
      ),
    );
  }

  void dataSeminar(String idSeminar) async {
    String djudul;
    await FirebaseFirestore.instance
        .collection("seminar")
        .doc(idSeminar)
        .get()
        .then((DocumentSnapshot ds) {
      Map<String, dynamic> data = ds.data();
      djudul = data["judul"];
    });

    setState(() {
      judul = djudul;
    });
  }
}
