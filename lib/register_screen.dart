import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth_service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email, password, name, cargo;

  final formKey = new GlobalKey<FormState>();

  checkFields() {
    final form = formKey.currentState;
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 350.0,
          width: 300.0,
          child:  Column(
            children: <Widget>[
              Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25, bottom: 20),
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(hintText: "Name"),
                          validator: (value) => value.isEmpty ? 'Name is required' : null,
                          onChanged: (value) {
                            this.name = value;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25, bottom: 20),
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(hintText: "Cargo"),
                          validator: (value) => value.isEmpty ? 'Cargo is required' : null,
                          onChanged: (value) {
                            this.cargo = value;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25),
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          decoration: InputDecoration(hintText: "Email"),
                          validator: (value) => value.isEmpty ? 'Email is required' : validateEmail(value.trim()),
                          onChanged: (value) {
                            this.email = value;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25, top: 20, bottom: 5),
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          obscureText: true,
                          decoration: InputDecoration(hintText: "Password"),
                          validator: (value) => value.isEmpty ? 'Password is required' : null,
                          onChanged: (value) {
                            this.password = value;
                          },
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if(checkFields()) {
                          bool check = await AuthService().createUser(email, password, name, cargo);
                          if(check){
                            await AuthService().signIn(email, password);
                            Navigator.pop(context);
                          }
                        }
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.2),
                        ),
                        child: Center(
                          child: Text('Sign in'),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.green,
      ),
    );
  }
}
