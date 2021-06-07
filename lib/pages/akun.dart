import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:seminar/login/loginprosesemail.dart';
import 'package:seminar/login/loginprosesgoogle.dart';
import 'homepembeli.dart';

class AkunPage extends StatefulWidget {
  @override
  _AkunPageState createState() => _AkunPageState();
}

class _AkunPageState extends State<AkunPage> {
  int count = 1;
  List<Widget> seminarList;
  int _selectedIndex = 2;
  CollectionReference _seminar =
      FirebaseFirestore.instance.collection('seminar');

  @override
  Widget build(BuildContext context) {
    if (seminarList == null) {
      seminarList = [];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Akun'),
      ),
      body: Column(children: [
        Container(
          padding: EdgeInsets.all(20),
          child: Text("name"),
        ),
        RaisedButton(
          onPressed: () {
            if(loginwithgoogle){
              signOutGoogle();
            }else{
              signOut();
            }
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) {
              return HomePembeli();
            }), ModalRoute.withName('/'));
          },
          color: Colors.deepPurple,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Sign Out',
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
          ),
          elevation: 5,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
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
