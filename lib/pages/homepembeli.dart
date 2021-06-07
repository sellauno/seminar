import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:seminar/card/seminar.dart';

class HomePembeli extends StatefulWidget {
  @override
  _HomePembeliState createState() => _HomePembeliState();
}

class _HomePembeliState extends State<HomePembeli> {
  int count = 1;
  int _selectedIndex = 0;
  CollectionReference _seminar =
      FirebaseFirestore.instance.collection('seminar');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home for Pembeli'),
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
                stream: _seminar.snapshots(),
                builder: (buildContext, snapshot) {
                  if(snapshot.data == null) return CircularProgressIndicator();
                  return Column(
                    children: snapshot.data.docs.map((e) {
                      Map<String, dynamic> data = e.data();
                      return SeminarCard(
                        data['judul'],
                        data['pembicara'],
                        data['waktu'],
                        data['lokasi'],
                        data['kuota'],
                        data['harga'],
                        e.id,
                        onDelete: () {
                          _seminar.doc(e.id).delete();
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
              Navigator.pushNamed(context, '/formseminar');
              // var seminar = await navigateToEntryForm(context, null);
              // if (seminar != null) {
              //   //TODO 2 Panggil Fungsi untuk Insert ke DB
              //   int result = await dbHelperSeminar.insert(seminar);
              //   if (result > 0) {
              //     updateListView();
              //   }
              // }
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
              Navigator.pushNamed(context, '/seminar');
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
}
