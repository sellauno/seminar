import 'package:flutter/material.dart';
import 'package:seminar/loginpage.dart';
import 'package:seminar/loginprosesgoogle.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int count = 1;

  List<Widget> seminarList;

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
          child: createListView(),
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
            icon: Icon(Icons.mail),
            title: Text('Inbox'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Akun'),
          ),
        ],
        currentIndex: 0,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
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
              "Judul Seminar",
              style: textStyle,
            ),
            subtitle: Text("Pembicara : " +
                "\nWaktu : " +
                "\nLokasi : " +
                "\nKuota  : " +
                "\nHarga  : "),
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
