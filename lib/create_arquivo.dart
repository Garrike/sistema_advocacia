import 'package:flutter/material.dart';
import 'package:projetoPDS/auth_service.dart';
import 'package:projetoPDS/home_screen.dart';
import 'package:projetoPDS/top_bar.dart';
import 'package:projetoPDS/widgets/collapsing_navigation_drawer.dart';
import 'package:toast/toast.dart';

class CreateArquivo extends StatefulWidget {
  final PageController pageController;

  CreateArquivo(this.pageController);

  @override
  _CreateArquivoState createState() => _CreateArquivoState();
}

class _CreateArquivoState extends State<CreateArquivo> {
  String advogado, oab, autor, cep, cidade, comarca, contato, cpf, data, protocolo, uf, vara;
  double distance = 20;
  final formKey = new GlobalKey<FormState>();
  final TextEditingController _textController1 = new TextEditingController();
  final TextEditingController _textController2 = new TextEditingController();
  final TextEditingController _textController3 = new TextEditingController();
  final TextEditingController _textController4 = new TextEditingController();
  final TextEditingController _textController5 = new TextEditingController();
  final TextEditingController _textController6 = new TextEditingController();
  final TextEditingController _textController7 = new TextEditingController();
  final TextEditingController _textController8 = new TextEditingController();
  final TextEditingController _textController9 = new TextEditingController();
  final TextEditingController _textController10 = new TextEditingController();
  final TextEditingController _textController11 = new TextEditingController();
  final TextEditingController _textController12 = new TextEditingController();

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
      body: Stack(
        children: <Widget>[
          TopBar(),
          Container(
            margin: new EdgeInsets.only(left: 60.0),
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 95.0, top: 35.0, bottom: 35.0),
                  child: Text(
                    'Adicionar arquivos',
                    style: TextStyle(
                      fontWeight: FontWeight.bold, 
                      fontSize: 28, 
                      color: Color.fromRGBO(0, 0, 0, 1),
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.teal,
                      decorationThickness: 2.85
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 1250,
                    height: 280,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color.fromRGBO(239, 239, 239, 1),
                    ),
                    child: Center(
                      child: Text(
                        '+Add File', 
                        style: TextStyle(fontSize: 25.0, color: Colors.black45),
                      )
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: 1250,
                    // color: Color.fromRGBO(239, 239, 239, 1),
                    margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 35.0, bottom: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      color: Color.fromRGBO(239, 239, 239, 1),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Column(                      
                        children: <Widget>[
                          Form(
                            key: formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Flexible(
                                      child: TextFormField(
                                        controller: _textController1,
                                        decoration: InputDecoration(hintText: "Autor"),
                                        // validator: (value) => value.isEmpty ? 'Email is required' : validateEmail(value.trim()),
                                        onChanged: (value) {
                                          this.autor = value;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: distance,
                                    ),
                                    Flexible(
                                      child:TextFormField(
                                        controller: _textController2,
                                        decoration: InputDecoration(hintText: "Nº Protocolo"),
                                        // validator: (value) => value.isEmpty ? 'Email is required' : validateEmail(value.trim()),
                                        onChanged: (value) {
                                          this.protocolo = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Flexible(
                                      child: TextFormField(
                                        controller: _textController3,
                                        obscureText: false,
                                        decoration: InputDecoration(hintText: "CPF"),
                                        // validator: (value) => value.isEmpty ? 'Password is required' : null,
                                        onChanged: (value) {
                                          this.cpf = value;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: distance,
                                    ),
                                    Flexible(
                                      child: TextFormField(
                                        controller: _textController4,
                                        obscureText: false,
                                        decoration: InputDecoration(hintText: "Contato"),
                                        // validator: (value) => value.isEmpty ? 'Password is required' : null,
                                        onChanged: (value) {
                                          this.contato = value;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: distance,
                                    ),
                                    Flexible(
                                      child: TextFormField(
                                        controller: _textController5,
                                        obscureText: false,
                                        decoration: InputDecoration(hintText: "Data"),
                                        // validator: (value) => value.isEmpty ? 'Password is required' : null,
                                        onChanged: (value) {
                                          this.data = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Flexible(
                                      child: TextFormField(
                                        controller: _textController6,
                                        obscureText: false,
                                        decoration: InputDecoration(hintText: "Vara"),
                                        // validator: (value) => value.isEmpty ? 'Password is required' : null,
                                        onChanged: (value) {
                                          this.vara = value;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: distance,
                                    ),
                                    Flexible(
                                      child: TextFormField(
                                        controller: _textController7,
                                        obscureText: false,
                                        decoration: InputDecoration(hintText: "Comarca"),
                                        // validator: (value) => value.isEmpty ? 'Password is required' : null,
                                        onChanged: (value) {
                                          this.comarca = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Flexible(
                                      child: TextFormField(
                                        controller: _textController8,
                                        obscureText: false,
                                        decoration: InputDecoration(hintText: "Cidade"),
                                        // validator: (value) => value.isEmpty ? 'Password is required' : null,
                                        onChanged: (value) {
                                          this.cidade = value;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: distance,
                                    ),
                                    Flexible(
                                      child: TextFormField(
                                        controller: _textController9,
                                        obscureText: false,
                                        decoration: InputDecoration(hintText: "UF"),
                                        // validator: (value) => value.isEmpty ? 'Password is required' : null,
                                        onChanged: (value) {
                                          this.uf = value;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: distance,
                                    ),
                                    Flexible(
                                      child: TextFormField(
                                        controller: _textController10,
                                        obscureText: false,
                                        decoration: InputDecoration(hintText: "CEP"),
                                        // validator: (value) => value.isEmpty ? 'Password is required' : null,
                                        onChanged: (value) {
                                          this.cep = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Flexible(
                                      child: TextFormField(
                                        controller: _textController11,
                                        obscureText: false,
                                        decoration: InputDecoration(hintText: "Advogado Responsável"),
                                        // validator: (value) => value.isEmpty ? 'Password is required' : null,
                                        onChanged: (value) {
                                          this.advogado = value;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: distance,
                                    ),
                                    Flexible(
                                      child: TextFormField(
                                        obscureText: false,
                                        controller: _textController12,
                                        decoration: InputDecoration(hintText: "OAB"),
                                        // validator: (value) => value.isEmpty ? 'Password is required' : null,
                                        onChanged: (value) {
                                          this.oab = value;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          CollapsingNavigationDrawer(widget.pageController, 1, user)
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          bool check = await AuthService().addArchive(advogado, oab, autor, cep, cidade, comarca, contato, cpf, data, protocolo, uf, vara, user);
          if(check){
            setState(() {
              _textController1.clear();
              _textController2.clear();
              _textController3.clear();
              _textController4.clear();
              _textController5.clear();
              _textController6.clear();
              _textController7.clear();
              _textController8.clear();
              _textController9.clear();
              _textController10.clear();
              _textController11.clear();
              _textController12.clear();
              Toast.show(
                "Arquivo Adicionado com SUCESSO", 
                context, 
                duration: Toast.LENGTH_LONG, 
                gravity:  Toast.CENTER,
                backgroundColor: Colors.teal
              );
            });              
          }
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }
}