import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:seminar/database/databaseuser.dart';

import 'loginprosesemail.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class Register extends StatefulWidget {
  final String title = 'Registration';
  @override
  State<StatefulWidget> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _noTelpController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Padding(
              //   padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
              //   child: 
                DropdownButtonFormField(
                  hint: Text('Daftar sebagai'),
                  items: <String>['admin', 'pembeli']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      DatabaseUser.role = value;
                    });
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              // ),
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
                controller: _namaController,
                decoration: const InputDecoration(labelText: 'Nama'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _noTelpController,
                decoration: const InputDecoration(labelText: 'No. Telp'),
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: 'Password'),
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
                  minWidth: 150,
                  child: RaisedButton(
                    onPressed: () async {
                      SignInSignUpResult result = await createUser(
                          email: _emailController.text,
                          pass: _passwordController.text);
                      if (result.user != null) {
                        DatabaseUser.userUid = result.user.uid;
                        await DatabaseUser.addUser(
                            email: _emailController.text,
                            nama: _namaController.text,
                            noTelp: _noTelpController.text);
                        Navigator.pushNamed(context, '/login');
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
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
