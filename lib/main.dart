import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:seminar/login/loginpage.dart';
import 'package:seminar/pages/home.dart';
import 'form/entryform.dart';
import 'form/entryseminar.dart';
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
      home: HomePage(),
      routes: {
        // '/register': (context) => RegisterEmailSection(),
        // '/signin': (context) => EmailPasswordForm(),
        // '/firstScreen': (context) => FirstScreen(),
        '/seminar': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/pesanan': (context) => PesananPage(),
        '/formseminar': (context) => EntryFormSeminar(),        
        '/formpesanan': (context) => EntryForm(),
      },
    );
  }
}
