import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seminar/card/pembeli.dart';
import 'package:seminar/card/pesanan.dart';
import 'package:seminar/database/databasepesanan.dart';
import 'package:seminar/database/databaseuser.dart';
import 'package:seminar/form/entryform.dart';
import 'package:seminar/login/loginprosesgoogle.dart';

class PesananAdminPage extends StatefulWidget {
  @override
  _PesananAdminPageState createState() => _PesananAdminPageState();
}

class _PesananAdminPageState extends State<PesananAdminPage> {
  int count = 1;
  int _selectedIndex = 1;
  CollectionReference _pembeli =
      FirebaseFirestore.instance.collection('pembeli');

  List<Widget> seminarList;

  @override
  Widget build(BuildContext context) {
    if (seminarList == null) {
      seminarList = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pembeli'),
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
                stream: DatabaseUser.readPembeli(),
                builder: (buildContext, snapshot) {
                  if (snapshot.data == null) return CircularProgressIndicator();
                  return Column(
                    children: snapshot.data.docs.map((e) {
                      Map<String, dynamic> data = e.data();
                      return PembeliCard(
                        data['nama'],
                        data['email'],
                        data['noTelp'],
                        e.id,
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
            onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => EntryForm(null, null, null)
                ),
              ),
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
              Navigator.pushNamed(context, '/seminar');
            } else if (_selectedIndex == 1) {
              Navigator.pushNamed(context, '/pesananadmin');
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
}
