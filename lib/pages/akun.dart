import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seminar/login/loginpage.dart';
import 'package:seminar/login/loginprosesemail.dart';
import 'package:seminar/login/loginprosesgoogle.dart';
import 'homepembeli.dart';

class AkunPage extends StatefulWidget {
  @override
  _AkunPageState createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  int count = 1;
  int _selectedIndex = 2;

  String nama = "";
  String email = "";
  String noTelp = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dataAkun();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Akun'),
        leading: Icon(Icons.account_circle_rounded),
      ),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Align(
            child: Container(
              child: Icon(
                Icons.account_circle_rounded,
                size: 100,
              ),
              width: 150,
              height: 150,
            ),
            alignment: Alignment.center,
          ),
          height: 140,
        ),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Text(nama),
          decoration: myBoxDecoration(),
        ),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Text(email),
          decoration: myBoxDecoration(),
        ),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(20),
          width: double.infinity,
          child: Text(noTelp),
          decoration: myBoxDecoration(),
        ),
        Padding(
          padding: const EdgeInsets.all(30),
          child: RaisedButton(
            onPressed: () {
              if (loginwithgoogle) {
                signOutGoogle();
                setState(() {
                  loginwithgoogle = false;
                  role = "";
                  userUid = null;
                });
              } else {
                setState(() {
                  userUid = null;
                });
                signOut();
              }
              Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) {
                return LoginPage();
              }), ModalRoute.withName('/'));
            },
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                margin: EdgeInsets.all(10),
                child: Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            elevation: 5,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        )
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
              if (role != "admin") {
                Navigator.pushNamed(context, '/homePembeli');
              } else {
                Navigator.pushNamed(context, '/seminar');
              }
            } else if (_selectedIndex == 1) {
              if (role != "admin") {
                Navigator.pushNamed(context, '/pesanan');
              } else {
                Navigator.pushNamed(context, '/pesananadmin');
              }
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

  void dataAkun() async {
    String dnama;
    String demail;
    String dnoTelp;
    await FirebaseFirestore.instance
        .collection(role)
        .doc(userUid)
        .get()
        .then((DocumentSnapshot ds) {
      Map<String, dynamic> data = ds.data();
      dnama = data["nama"];
      demail = data["email"];
      dnoTelp = data["noTelp"];
    });

    setState(() {
      nama = dnama;
      email = demail;
      noTelp = dnoTelp;
    });
  }

  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      border: Border.all(
        color: Colors.grey,
        width: 2.0,
      ),
      borderRadius: BorderRadius.circular(30),
    );
  }
}
