import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projetoPDS/models/arquivos.dart';
import 'package:toast/toast.dart';

import 'auth_service.dart';

BuildContext mainContext;
bool _isEnabled;

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  String email, password, name, cargo, dropdownValue = 'Advogado';

  final formKey = new GlobalKey<FormState>();

  void initState() {
    super.initState();
    _isEnabled = true;
    // verificar(context);
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
    mainContext = context;
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
                          enabled: _isEnabled,
                          decoration: InputDecoration(hintText: "Name"),
                          validator: (value) => value.isEmpty ? 'Name is required' : null,
                          onChanged: (value) {
                            this.name = value;
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25, right: 25, bottom: 15),
                      child: Container(
                        height: 50,
                        width: 250,
                        // child: DropdownButton<String>(
                        //   value: dropdownValue,
                        //   icon: Icon(Icons.arrow_downward),
                        //   iconSize: 24,
                        //   elevation: 16,
                        //   underline: Container(
                        //     height: 2,
                        //     color: Colors.teal,
                        //   ),
                        //   onChanged: (String newValue) {
                        //     setState(() {
                        //       dropdownValue = newValue;
                        //       this.cargo = newValue;
                        //     });
                        //   },
                        //   items: <String>['Advogado', 'Estagiário']
                        //     .map<DropdownMenuItem<String>>((String value) {
                        //       return DropdownMenuItem<String>(
                        //         value: value,
                        //         child: Center(child: Text(value)),
                        //       );
                        //     })
                        //     .toList(),
                        // ),
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
                          enabled: _isEnabled,
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
                          enabled: _isEnabled,
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
                        print(this.cargo);                     
                        verificar(context);
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

  verificar(BuildContext context) {
    var textController = TextEditingController();
    Widget cancelaButton = FlatButton(
      child: Text("Cancelar"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continuaButton = FlatButton(
      child: Text("Verificar"),
      onPressed:  () async {
        var response = await AuthService().getUserOffice(textController.text);
        if(response == 'Advogado'){
          
          Navigator.pop(context);
          setState(() {
            _isEnabled = true;
          });                    
          if(checkFields()) {
            bool check = await AuthService().createUser(email, password, name, cargo);
            if(check){
              await AuthService().signIn(email, password);
              Navigator.pop(context);
            }
          } 
          print('Add com sucesso');
        } else {
          setState(() {
            _isEnabled = false;
          });          
          Navigator.pop(context);
          Navigator.pop(mainContext);
          print("Permissão Negada");
          Toast.show(
            "Permissão Negada", 
            context, 
            duration: Toast.LENGTH_LONG, 
            gravity:  Toast.CENTER,
            backgroundColor: Colors.teal
          );
        }
      },
    );

    //configura o AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Verificação de Registro", style: TextStyle(fontWeight: FontWeight.bold),),
      content: Container(
        height: 70,
        width: 400,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Informe o ID :"),
            TextFormField(
              controller: textController,
              decoration: InputDecoration(hintText: "ID Responsável"),
              validator: (value) => value.isEmpty ? 'ID obrigatório' : 'ID validado com sucesso',
            ),
          ],
        ),
      ),
      actions: [
        cancelaButton,
        continuaButton,
      ],
    );

    //exibe o diálogo
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}