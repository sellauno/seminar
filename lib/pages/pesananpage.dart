import 'package:flutter/material.dart';
import 'package:seminar/login/loginpage.dart';
import 'package:seminar/login/loginprosesgoogle.dart';

class PesananPage extends StatefulWidget {
  @override
  _PesananPageState createState() => _PesananPageState();
}

class _PesananPageState extends State<PesananPage> {
  int count = 1;
  int _selectedIndex = 1;

  List<Widget> seminarList;

  @override
  Widget build(BuildContext context) {
    if (seminarList == null) {
      seminarList = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Daftar Pesanan'),
      ),
      body: Column(children: [
        Expanded(
          child: createListView(),
        ),
        Container(
          alignment: Alignment.bottomRight,
          margin: const EdgeInsets.all(20),
          child: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () async {
              Navigator.pushNamed(context, '/formpesanan');
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

  ListView createListView() {
    TextStyle textStyle = Theme.of(context).textTheme.headline5;
    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.red,
              child: Icon(Icons.date_range),
            ),
            title: Text(
              "Pembeli",
              style: textStyle,
            ),
            subtitle: Text("Nama : " +
                "\nSeminar : " +
                "\nTanggal : "),
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
      },
    );
  }
}