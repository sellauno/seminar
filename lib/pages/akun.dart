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
      ),
      body: Column(children: [
                    Container(
                      child: Text(nama),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(email),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(noTelp),
                    ),
                    RaisedButton(
                      onPressed: () {
                        if (loginwithgoogle) {
                          signOutGoogle();
                          setState(() {
                            loginwithgoogle = false;
                            role = "";
                          });
                        } else {
                          signOut();
                        }
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(builder: (context) {
                          return LoginPage();
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                    )
                  ]),
      // ListView(
      //   children: [
      //     StreamBuilder<QuerySnapshot>(
      //       stream: _akun,
      //       builder: (buildContext, snapshot) {
      //         if (snapshot.data == null) return CircularProgressIndicator();

      //         return Column(
      //           children: snapshot.data.docs.map((e) {
      //             Map<String, dynamic> data = e.data();
      //             return Column(children: [
      //               Container(
      //                 child: Text(data["nama"]),
      //               ),
      //               Container(
      //                 padding: EdgeInsets.all(20),
      //                 child: Text(data["email"]),
      //               ),
      //               Container(
      //                 padding: EdgeInsets.all(20),
      //                 child: Text(data["noTelp"]),
      //               ),
      //               RaisedButton(
      //                 onPressed: () {
      //                   if (loginwithgoogle) {
      //                     signOutGoogle();
      //                     setState(() {
      //                       loginwithgoogle = false;
      //                     });
      //                   } else {
      //                     signOut();
      //                   }
      //                   Navigator.of(context).pushAndRemoveUntil(
      //                       MaterialPageRoute(builder: (context) {
      //                     return LoginPage();
      //                   }), ModalRoute.withName('/'));
      //                 },
      //                 color: Colors.deepPurple,
      //                 child: Padding(
      //                   padding: const EdgeInsets.all(8.0),
      //                   child: Text(
      //                     'Sign Out',
      //                     style: TextStyle(fontSize: 25, color: Colors.white),
      //                   ),
      //                 ),
      //                 elevation: 5,
      //                 shape: RoundedRectangleBorder(
      //                     borderRadius: BorderRadius.circular(40)),
      //               )
      //             ]);
      //           }).toList(),
      //         );
      //       },
      //     ),
      //   ],
      // ),
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
}
