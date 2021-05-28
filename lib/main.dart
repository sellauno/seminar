import 'package:flutter/material.dart';
import 'package:seminar/loginpage.dart';
import 'package:seminar/home.dart';
import 'entryform.dart';
import 'entryseminar.dart';
import 'pesanan.dart';

void main() {
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
      home: HomePage(),
      routes: {
        // '/register': (context) => RegisterEmailSection(),
        // '/signin': (context) => EmailPasswordForm(),
        // '/firstScreen': (context) => FirstScreen(),
        '/pesanan': (context) => PesananPage(),
        '/formseminar': (context) => EntryForm(),        
        '/formpesanan': (context) => EntryFormSeminar(),
      },
    );
  }
}
