import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:seminar/database/databaseuser.dart';
import 'package:seminar/login/loginprosesgoogle.dart';
import 'package:seminar/pages/homeadmin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seminar/pages/homepembeli.dart';
import '../login/loginprosesemail.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
String role;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FocusNode _uidFocusNode = FocusNode();

  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();

    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Login to Your Account',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.blueGrey,
                ),
              ),
              SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (String value) {
                          if (value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 30.0),
                        alignment: Alignment.center,
                        child: ButtonTheme(
                          height: 50,
                          minWidth: 260,
                          child: RaisedButton(
                            onPressed: () async {
                              SignInSignUpResult result = await signInWithEmail(
                                  email: _emailController.text,
                                  pass: _passwordController.text);
                              User user = result.user;
                              if (user != null) {
                                navigateUser(user.uid);
                              } else {
                                // Show Dialog
                                showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                          title: Text("Error"),
                                          content: Text(result.message),
                                          actions: <Widget>[
                                            FlatButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: Text("OK"),
                                            )
                                          ],
                                        ));
                              }
                            },
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                            child: const Text(
                              'Sign In',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Container(
              //     width: 250,
              //     margin: EdgeInsets.only(top: 10, bottom: 15),
              //     child: _signInButton()
              //   ),
              _registerLink()
            ],
          ),
        ),
      ),
    );
  }

  Widget _signInButton() {
    return OutlineButton(
      splashColor: Colors.grey,
      onPressed: () {
        signInWithGoogle().then((result) {
          if (result != null) {
            navigateUser(result);
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.grey),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("assets/google_logo.png"), height: 20.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _registerLink() {
    return Center(
        child: new InkWell(
            child: new Text(
              "Belum memiliki akun? Register",
              style: TextStyle(color: Colors.blue),
            ),
            onTap: () => Navigator.pushNamed(context, '/register')));
  }

  Future<void> navigateUser(String userId) async {
    setState(() {
      userUid = userId;
    });
    FirebaseFirestore _firestore = FirebaseFirestore.instance;
    DocumentReference documentReferencer =
        _firestore.collection('admin').doc(userId);

    var doc = await FirebaseFirestore.instance.collection('admin').doc(userId).get();
   if (doc.exists) {
      setState(() {
        role = "admin";
      });      
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return HomePage();
          },
        ),
      );
    } else {
      setState(() {
        role = "pembeli";
      });
      
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return HomePembeli();
          },
        ),
      );
    }
  }
}
