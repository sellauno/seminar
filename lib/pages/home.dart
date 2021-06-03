import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:seminar/seminar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 1;
  List<Widget> seminarList;
  int _selectedIndex = 0;
  CollectionReference _seminar =
      FirebaseFirestore.instance.collection('seminar');

  @override
  Widget build(BuildContext context) {
    if (seminarList == null) {
      seminarList = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Seminar'),
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
                        onUpdate: () {
                          //_seminar.doc(e.id).update({"age": e.data()['age'] + 1});
                        },
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
              Navigator.pushNamed(context, '/login');
            }
          });
        },
      ),
    );
  }
}
