//import 'dart:js';
//import 'package:firebase/firebase.dart' as fb;
//import 'package:firebase/firestore.dart' as fs;
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:projetoPDS/home_screen.dart';
import 'package:projetoPDS/login_screen.dart';

import 'models/arquivos.dart';
import 'models/user.dart';

class AuthService {
  //Handle Authentication
  handleAuth() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
    );
  }

  //Get currently logged-in user
  Future<User> currentUser() async {
    var user = User();
    var userJson;
    try{
      final response = await http.get(
        'https://projetopds-72fa1.firebaseapp.com/api/v1/contacts'
      );
      await FirebaseAuth.instance.currentUser().then((user) {
        userJson = json.decode(response.body)['usuarios'][user.uid];
        
      });
    } catch(e) {
      return null;
    }
    if(userJson != null){
      user = User(
        email: userJson['email'],
        password: userJson['password'],
        name: userJson['name'],
        office: userJson['office'],
        userid: userJson['userid'],
        processes: userJson['processes'],
        pending: userJson['pending']
      );
    }
    return user;
  }

  getUserOffice(String id) async {
    try{
      final response = await http.get(
        'https://projetopds-72fa1.firebaseapp.com/api/v1/contacts/$id'
      );
      return json.decode(response.body)['office'];
    } catch(e) {
      return null;
    }
  }

  //Sign out
  Future signOut() async {
    FirebaseAuth.instance.signOut();
  }
  
  //Sign in
  Future signIn(email, password) async {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((user) {
    }).catchError((e) {
      // print('error..');
      print(e);
    });
  }

  //Create User
  Future createUser(email, password, name, office) async {
    
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((data){
      addUser(email, password, name, office, data.user.uid);

      //Here if you want you can sign in the user
    }).catchError((e) {
      print(e);
      return false;
    });

    return true;
  }

  addUser(email, password, name, office, userid) async {
    List list = List<dynamic>();
    list = [];
    print('Function addUser: $office');
    var resBody = {};
    resBody["email"] = email;
    resBody["password"] = password;
    resBody["name"] = name;
    resBody["office"] = office;
    resBody["userid"] = userid;
    resBody["processes"] = list;
    resBody["pending"] = list;

    final response = 
      await http.post("https://projetopds-72fa1.firebaseapp.com/api/v1/contacts", 
      headers: {"Content-Type": "application/json"},
      body: json.encode(resBody));
  }

  addArchive(advogado, oab, autor, cep, cidade, comarca, contato, cpf, data, protocolo, uf, vara, User user) async {
    List list = List<dynamic>();
    list = [];
    try {
      var resBody = {};
      resBody["advogado"] = advogado;
      resBody["oab"] = oab;
      resBody["autor"] = autor;
      resBody["archives"] = list;
      resBody["cep"] = cep;
      resBody["cidade"] = cidade;
      resBody["comarca"] = comarca;
      resBody["contato"] = contato;
      resBody["cpf"] = cpf;
      resBody["data"] = data;
      resBody["protocolo"] = protocolo;
      resBody["uf"] = uf;
      resBody["vara"] = vara;
      resBody["status"] = "Aberto";

      final response = 
        await http.post("https://projetopds-72fa1.firebaseapp.com/api/v1/processes", 
        headers: {"Content-Type": "application/json"},
        body: json.encode(resBody));

      // print(response.body);
      await patchProcess(user.processes, user.userid, json.decode(response.body)['id']);
    } catch(e) {
      print(e);
      return false;
    }
    return true;
  }

  Future getProcess(User user) async {
    List<Processo> processes = List<Processo>();
    // processes = [];
    if(user.processes.isNotEmpty) {
      for(var item in user.processes){ 
        // print(item);       
        try {
          final response = await http.get(
            'https://projetopds-72fa1.firebaseapp.com/api/v1/processes/$item'
          );

          var jsonResponse = json.decode(response.body);
          // print(jsonResponse);
          processes.add(Processo(
            advogado: jsonResponse['advogado'],
            oab: jsonResponse['oab'],
            autor: jsonResponse['autor'],
            cep: jsonResponse['cep'],
            cidade: jsonResponse['cidade'],
            comarca: jsonResponse['comarca'],
            contato: jsonResponse['contato'],
            cpf: jsonResponse['cpf'],
            data: jsonResponse['data'],
            protocolo: jsonResponse['protocolo'],
            uf: jsonResponse['uf'],
            vara: jsonResponse['vara'],
            archives: jsonResponse['archives'],
            status: jsonResponse['status']
          ));

          // print('json: ${jsonResponse['advogado']}');
          // print('processes: ${processes.length}');
        } catch(e) {
          print("Error...");
        }
      }
      print(processes.length);
      return processes;
    } else return null;
  }

  Future getProcessID(id) async {
    if(id == null) {
      print("veio null..");
      return null;
    }
    try{
      final response = await http.get(
        'https://projetopds-72fa1.firebaseapp.com/api/v1/processes/$id'
      );
      
      var jsonResponse = json.decode(response.body);
      // print(jsonResponse);
      Processo processo = Processo(
        advogado: jsonResponse['advogado'],
        oab: jsonResponse['oab'],
        autor: jsonResponse['autor'],
        cep: jsonResponse['cep'],
        cidade: jsonResponse['cidade'],
        comarca: jsonResponse['comarca'],
        contato: jsonResponse['contato'],
        cpf: jsonResponse['cpf'],
        data: jsonResponse['data'],
        protocolo: jsonResponse['protocolo'],
        uf: jsonResponse['uf'],
        vara: jsonResponse['vara'],
        archives: jsonResponse['archives'],
        status: jsonResponse['status']
      );
      return processo;
    } catch(e) {
      print(e);
      return null;
    }
  }

  Future addPending(String idUser, String idProcesso) async {
    List pending = List();
    try{
      final response = await http.get(
        'https://projetopds-72fa1.firebaseapp.com/api/v1/contacts/$idUser'
      );
      pending = json.decode(response.body)['pending'];
      patchPending(pending, idUser, idProcesso);
    } catch(e) {
      return null;
    }    
    return 'sucesso';
  }

  Future deleteProcess(User user, String idProcesso) async {
    var resBody = {};
    // print(pending);
    user.processes.removeWhere((item) => item == idProcesso);
    resBody['processes'] = user.processes;
    var resp = json.encode(resBody);
    // print(resp);
    try{      
      final response = await http.patch(
        'https://projetopds-72fa1.firebaseapp.com/api/v1/contacts/${user.userid}', 
        headers: {"Content-Type": "application/json"},
        body: resp
      );
    } catch(e) {
      return print(e);
    }  
    return idProcesso;
  }

  Future deletePending(User user, String idProcesso) async {
    var resBody = {};
    // print(pending);
    user.pending.removeWhere((item) => item == idProcesso);
    resBody['pending'] = user.pending;
    var resp = json.encode(resBody);
    // print(resp);
    try{      
      final response = await http.patch(
        'https://projetopds-72fa1.firebaseapp.com/api/v1/contacts/${user.userid}', 
        headers: {"Content-Type": "application/json"},
        body: resp
      );
    } catch(e) {
      return print(e);
    }  
    return idProcesso;
  }

  Future addProcessfromPending(User user, String idProcesso) async { 
    var resBody = {};
    user.processes.add(idProcesso);
    resBody['processes'] = user.processes;
    var resp = json.encode(resBody);
    // print(resp);
    try{      
      final response = await http.patch(
        'https://projetopds-72fa1.firebaseapp.com/api/v1/contacts/${user.userid}', 
        headers: {"Content-Type": "application/json"},
        body: resp
      );
    } catch(e) {
      return print(e);
    }  
    return idProcesso;
  }  

  patchPending(pending, idUser, idProcesso) async {
    var resBody = {};
    // print(pending);
    pending.add(idProcesso);
    resBody['pending'] = pending;
    var resp = json.encode(resBody);
    // print(resp);
    try{      
      final response = await http.patch(
        'https://projetopds-72fa1.firebaseapp.com/api/v1/contacts/$idUser', 
        headers: {"Content-Type": "application/json"},
        body: resp
      );
      // print(response.body);
      // print('passou por aqui');
    } catch(e) {
      // print('https://projetopds-72fa1.firebaseapp.com/api/v1/contacts/$idUser');
      return print(e);
    }    
  }

  patchProcess(process, idUser, idProcesso) async {
    var resBody = {};
    // print(process);
    process.add(idProcesso);
    // print(process);
    resBody['processes'] = process;
    var resp = json.encode(resBody);
    // print(resp);
    try{      
      final response = await http.patch(
        'https://projetopds-72fa1.firebaseapp.com/api/v1/contacts/$idUser', 
        headers: {"Content-Type": "application/json"},
        body: resp
      );
      // print(response.body);
      // print('passou por aqui');
    } catch(e) {
      // print('https://projetopds-72fa1.firebaseapp.com/api/v1/contacts/$idUser');
      return print(e);
    }    
  }

  statusProcess(status, idProcesso) async {
    var resBody = {};
    resBody['status'] = status;
    var resp = json.encode(resBody);
    try{      
      final response = await http.patch(
        'https://projetopds-72fa1.firebaseapp.com/api/v1/processes/$idProcesso', 
        headers: {"Content-Type": "application/json"},
        body: resp
      );
    } catch(e) {
      return print(e);
    }    
  }
}