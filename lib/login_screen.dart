import 'dart:convert';

import 'package:flutter/material.dart';
//import 'package:http/http.dart';
import 'package:projetoPDS/auth_service.dart';
import 'package:projetoPDS/models/user.dart';
import 'package:projetoPDS/register_screen.dart';
import 'package:http/http.dart' as http;


// Future<User> fetchPost() async {
//   print("testea");
//   http.Response response =
//   await http.get('https://projetopds-72fa1.firebaseapp.com/home/Lcqj8av0DuQzS0VS6CG8');
//   print(response.body);

//   if (response.statusCode == 200) {
//     // If the call to the server was successful, parse the JSON.
//     return User.fromJson(json.decode(response.body));
//   } else {
//     print("não achou..");
//     // If that call was not successful, throw an error.
//     throw Exception('Failed to load post');
//   }
// }

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String email, password;

  List<User> data;

  final formKey = new GlobalKey<FormState>();

  var items = new List<User>();
  _LoginPageState() {
    items = [];
    items.add(User(
      email: "gabriel@gmail.com",
      name: "Gabriel",
      userid: "userid2",
      office: "Advogado",
      password: "123456"
    ));  
  }

  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }

  Future<List<String>> getJsonData() async {
    try{
      final response = await http.get(
        'https://projetopds-72fa1.firebaseapp.com/api/v1/contacts'
      );
      print(response.body);
      print('\n\n');

      var responseJson = json.decode(response.body)['usuarios'];
      print(responseJson['JNGMHdU1p6xFODOZOC4r']);
    } catch (e) {
      print(e);
    }
    return allUsersFromJson(data);
  }

  allUsersFromJson(response) {
    print("recebido");
  }

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
      body: Container(
        decoration: BoxDecoration(
          color: Colors.teal
          //image: DecorationImage(image: AssetImage("images/laika-notebooks-pONH9yZ-wXg-unsplash.jpg"), fit: BoxFit.cover),
        ),
        child: Center(
          child: Container(
            height: 380.0,
            width: 420.0,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(left: 25, right: 25),
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(200, 200, 200, 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                            child: TextFormField(
                              decoration: InputDecoration(hintText: "Email"),
                              validator: (value) => value.isEmpty ? 'Email is required' : validateEmail(value.trim()),
                              onChanged: (value) {
                                this.email = value;
                              },
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 25, right: 25, top: 10, bottom: 5),
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(200, 200, 200, 1),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12.0, right: 12.0),
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
                      ),
                      InkWell(
                        onTap: () {
                          if(checkFields()) {
                            AuthService().signIn(email, password);
                          }
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 25.0, right: 25.0, top: 50),
                          child: Container(
                            height: 45,
                            //width: 100,
                            decoration: BoxDecoration(
                              color: Color.fromRGBO(203, 232, 106, 1),
                              borderRadius: BorderRadius.circular(15)
                            ),
                            child: Center(
                              child: Text('Sign in'),
                            ),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> (RegisterPage())));
        },
        child: Icon(Icons.create),
        backgroundColor: Colors.green,
      ),
    );
  }
}
