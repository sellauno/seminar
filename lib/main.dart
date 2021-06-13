import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:seminar/login/loginpage.dart';
import 'package:seminar/pages/homeadmin.dart';
import 'package:seminar/pages/pesananadmin.dart';
import 'form/editseminar.dart';
import 'form/entryform.dart';
import 'form/entryseminar.dart';
import 'login/register.dart';
import 'pages/akun.dart';
import 'pages/homepembeli.dart';
import 'pages/pesananpage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: HomePembeli(),
      routes: {
        '/seminar': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/pesanan': (context) => PesananPage(),
        '/pesananadmin': (context) => PesananAdminPage(),
        '/formseminar': (context) => EntryFormSeminar(),        
        '/formpesanan': (context) => EntryForm(),
        '/editseminar': (context) => EditFormSeminar(),
        '/register': (context) => Register(),  
        '/homePembeli': (context) => HomePembeli(), 
        '/akun': (context) => AkunPage(),
      },
    );
  }
}
