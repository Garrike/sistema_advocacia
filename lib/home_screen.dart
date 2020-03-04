import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projetoPDS/auth_service.dart';
import 'package:projetoPDS/create_arquivo.dart';
import 'package:projetoPDS/detalhe_processo.dart';
import 'package:projetoPDS/models/user.dart';
import 'package:projetoPDS/theme.dart';
import 'package:projetoPDS/top_bar.dart';
import 'package:projetoPDS/widgets/collapsing_navigation_drawer.dart';

import 'auth_service.dart';
import 'models/arquivos.dart';

User user = User();
Processo card = Processo();
List<Processo> processos;

final _pageController = PageController(initialPage: 0, keepPage: false);

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final _pageController = PageController(initialPage: 0, keepPage: false);
  TextEditingController search = TextEditingController();
  @override
  void initState() {
    super.initState();
    card = null;
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget> [ 
        Scaffold(
          body: Stack(
            children: <Widget>[        
              FutureBuilder(
                future: AuthService().currentUser(),
                builder: (context, AsyncSnapshot<User> snapshot) {
                  if (snapshot.hasData) {
                    user = snapshot.data;
                    // print(user.processes.length);
                    return Container(
                      margin: new EdgeInsets.only(left: 60.0),
                      color: Colors.white,
                      child: SingleChildScrollView(
                        child: Stack(
                          children: <Widget>[
                            TopBar(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 30, top: 40.0),
                                  child: Text(
                                    'Dashboard',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold, 
                                      fontSize: 32, 
                                      color: Color.fromRGBO(0, 0, 0, 1),
                                      decoration: TextDecoration.underline,
                                      decorationColor: Colors.teal,
                                      decorationThickness: 2.85
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 30, top: 50, bottom: 20),
                                  child: Container(
                                    height: 40,
                                    width: 400,
                                    decoration: BoxDecoration(
                                      color: Color.fromRGBO(89, 154, 96, 1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                                            child: TextFormField(
                                              controller: search,
                                              decoration: InputDecoration(
                                                hintText: "Procurar Arquivo", 
                                                fillColor: Colors.white,
                                                hintStyle: TextStyle(fontWeight: FontWeight.bold)
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          width: 40,
                                          height: 40,
                                          child: InkWell(
                                            child: Icon(Icons.search), 
                                            onTap: () {
                                              print(search.text);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      width: 30,
                                    ),
                                    Expanded(
                                      child: Container(                                            
                                        decoration: BoxDecoration(
                                          color: Color.fromRGBO(226, 226, 226, 1),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        height: 500,
                                        child: FutureBuilder(
                                          future: AuthService().getProcess(user),
                                          builder: (context, snapshot) {
                                            if(snapshot.hasData) {
                                              return ListView.builder(
                                                itemCount: snapshot.data.length,
                                                itemBuilder: (context, i) {
                                                  processos = snapshot.data;
                                                  print(processos[i].advogado);
                                                  return Card(     
                                                    color: processos[i].status == "Aberto" ? Color.fromRGBO(221, 239, 215, 1) 
                                                    : Color.fromRGBO(239, 215, 215, 1),                                     
                                                    child: InkWell(
                                                      splashColor: Colors.blue.withAlpha(30),
                                                      onTap: () {
                                                        print('Card tapped.');
                                                        setState(() {
                                                          card = processos[i]; 
                                                        });                                                        
                                                        _pageController.jumpToPage(2);
                                                      },
                                                      child: Container(
                                                        height: 100,
                                                        child: Row(
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: <Widget>[
                                                                Padding(
                                                                  padding: const EdgeInsets.only(top: 5.0, left: 10, bottom: 5),
                                                                  child: Text('ID ${user.processes[i]}', style: TextStyle(fontSize: 14),),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(left: 10),                                                          
                                                                  child: Center(
                                                                    child: Icon(Icons.person_pin, color: Colors.black, size: 48),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(bottom: 10.0, left: 10),
                                                                  child: Text(
                                                                    processos[i].autor, 
                                                                    style: TextStyle(fontWeight: FontWeight.bold),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                            Expanded(
                                                              child: Container(
                                                                margin: const EdgeInsets.only(right: 30.0),
                                                                alignment: Alignment.centerRight,
                                                                // color: Colors.amberAccent,
                                                                height: 100,
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.end,
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: <Widget>[
                                                                    Text(
                                                                      '${processos[i].archives.length.toString()}', 
                                                                      style: TextStyle(
                                                                        fontSize: 30,
                                                                        fontWeight: FontWeight.bold
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      'documentos',
                                                                      style: TextStyle(
                                                                        fontSize: 14,
                                                                        fontWeight: FontWeight.bold
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                            Column(
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Padding(
                                                                  padding: const EdgeInsets.only(right: 15.0, bottom: 8),
                                                                  child: ClipOval(
                                                                    child: Material(
                                                                      elevation: 60,
                                                                      color: Colors.white, // button color                                                                    
                                                                      shadowColor: Colors.black,
                                                                      child: InkWell(
                                                                        splashColor: Colors.teal, // inkwell color
                                                                        child: SizedBox(width: 25, height: 25, child: Icon(Icons.zoom_out_map, color: Colors.teal, size: 20,),),
                                                                        onTap: () {
                                                                          setState(() {
                                                                            card = processos[i]; 
                                                                          });                                                        
                                                                          _pageController.jumpToPage(2);
                                                                          print('zoom');
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(right: 15.0, bottom: 8),
                                                                  child: ClipOval(
                                                                    child: Material(
                                                                      elevation: 60,
                                                                      color: Colors.white, // button color
                                                                      shadowColor: Colors.black.withOpacity(0.6),
                                                                      child: InkWell(
                                                                        splashColor: Colors.teal, // inkwell color
                                                                        child: SizedBox(
                                                                          width: 25, 
                                                                          height: 25,                                                                         
                                                                          child: Icon(
                                                                            Icons.restore_from_trash, 
                                                                            color: Colors.teal, 
                                                                            size: 20,
                                                                          ),
                                                                        ),
                                                                        onTap: () {
                                                                          print('trash');
                                                                          deleteProcess(context, user.processes[i]);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(right: 15.0),
                                                                  child: ClipOval(
                                                                    child: Material(
                                                                      elevation: 60,
                                                                      color: Colors.white, // button color
                                                                      shadowColor: Colors.black.withOpacity(0.6),
                                                                      child: InkWell(
                                                                        splashColor: Colors.teal, // inkwell color
                                                                        child: SizedBox(width: 25, height: 25, child: Icon(Icons.share, color: Colors.teal, size: 20,),),
                                                                        onTap: () {
                                                                          print('shared');
                                                                          shareProcess(context, user.processes[i]);
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ]
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                              );
                                            } 
                                            return Expanded(
                                              child: Container(
                                                height: 100,
                                                child: Center(
                                                  child: Text("Não há processos arquivados")
                                                ),
                                              ),
                                            );
                                          }
                                        ),
                                      ),                                        
                                    ),
                                    Container(
                                      width: 80,
                                    ),
                                    FutureBuilder(
                                      future: AuthService().getProcessID(getPending().toString()),
                                      builder: (context, snapshot) {
                                        if(snapshot.hasData) {
                                          Processo pendente = snapshot.data;
                                          return Expanded(
                                            child: Column(
                                              children: <Widget>[
                                                Padding(
                                                  padding: const EdgeInsets.only(bottom: 30),
                                                  child: Card(     
                                                    color: Color.fromRGBO(239, 215, 215, 1),                                     
                                                    child: Container(
                                                      height: 100,
                                                      child: Row(
                                                        children: [
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: <Widget>[
                                                              Padding(
                                                                padding: const EdgeInsets.only(top: 5.0, left: 10, bottom: 5),
                                                                child: Text('ID ${getPending()}', style: TextStyle(fontSize: 14,),),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(left: 10),                                                          
                                                                child: Center(
                                                                  child: Icon(Icons.person_pin, color: Colors.black, size: 48),
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding: const EdgeInsets.only(bottom: 10.0, left: 10),
                                                                child: Text(
                                                                  pendente.autor, 
                                                                  style: TextStyle(fontWeight: FontWeight.bold),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                          Expanded(
                                                            child: Center(
                                                              child: Padding(
                                                                padding: const EdgeInsets.only(left: 60.0, right: 40.0),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  children: <Widget>[
                                                                    RaisedButton(        
                                                                      color: Color.fromRGBO(182, 220, 109, 0.8), 
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius: new BorderRadius.circular(8.0),
                                                                      ),
                                                                      splashColor: Colors.green,                                                     
                                                                      onPressed: () async {                  
                                                                        AuthService().addProcessfromPending(user, await AuthService().deletePending(user, getPending()));                                  
                                                                        print('tap accept');   
                                                                        _pageController.jumpToPage(1);                                                                 
                                                                      },
                                                                      child: Center(
                                                                        child: Text(
                                                                          'Aceitar',
                                                                          style: TextStyle(fontWeight: FontWeight.bold),                                                                
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    RaisedButton(
                                                                      color: Color.fromRGBO(254, 121, 102, 0.8),
                                                                      shape: RoundedRectangleBorder(
                                                                        borderRadius: new BorderRadius.circular(8.0),
                                                                      ),
                                                                      splashColor: Colors.red,
                                                                      onPressed: () {
                                                                        AuthService().deletePending(user, getPending());
                                                                        print('tap rejected');
                                                                        _pageController.jumpToPage(1); 
                                                                      },
                                                                      child: Center(
                                                                        child: Text(
                                                                          'Rejeitar',
                                                                          style: TextStyle(fontWeight: FontWeight.bold),                                                                
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Container(
                                                            margin: const EdgeInsets.only(right: 20.0),
                                                            alignment: Alignment.centerRight,
                                                            // color: Colors.amberAccent,
                                                            height: 100,
                                                            width: 150,
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.end,
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              children: <Widget>[
                                                                Text(
                                                                  '${pendente.archives.length}', 
                                                                  style: TextStyle(
                                                                    fontSize: 30,
                                                                    fontWeight: FontWeight.bold
                                                                  ),
                                                                ),
                                                                Text(
                                                                  'documentos',
                                                                  style: TextStyle(
                                                                    fontSize: 14,
                                                                    fontWeight: FontWeight.bold
                                                                  ),
                                                                )
                                                              ],
                                                            ),
                                                          ),
                                                        ]
                                                      ),
                                                    ),
                                                  ),
                                                ),  
                                                Container(
                                                  height: 365,                                                  
                                                  decoration: BoxDecoration(
                                                    color: Color.fromRGBO(226, 226, 226, 1),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                ),                    
                                              ],
                                            ),
                                          );
                                        }
                                        return Expanded(
                                          child: Container(
                                            height: 100,
                                            child: Center(
                                              child: Text("Não há processos arquivados")
                                            ),
                                          ),
                                        );
                                      }
                                    ),
                                    Container(
                                      width: 30,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  else {
                    return Text('Loading...');
                  }
                }
              ),              
              CollapsingNavigationDrawer(_pageController, 0, user),
            ]
          ),
        ),
        CreateArquivo(_pageController),
        ProcessDetails(_pageController, user, card),
      ]
    );
  }

  getPending() {
    if(user.pending.isEmpty || user.pending == null) return null;
    List lista = user.pending.toList();
    // print(lista[0]);
    return lista[0];
  }
}

shareProcess(BuildContext context, String idProcesso) {
  var textController = TextEditingController();
  Widget cancelaButton = FlatButton(
    child: Text("Cancelar"),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continuaButton = FlatButton(
    child: Text("Compartilhar"),
    onPressed:  () {
      var response = AuthService().addPending(textController.text, idProcesso);
      if(response != null){
        print('Add com sucesso');
        Navigator.pop(context);
      }
    },
  );

  //configura o AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Compartilhar Processo", style: TextStyle(fontWeight: FontWeight.bold),),
    content: Container(
      height: 70,
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("Informe o ID do advogado:"),
          TextFormField(
            controller: textController,
            decoration: InputDecoration(hintText: "ID destinatário"),
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

deleteProcess(BuildContext context, String idProcesso) {
  Widget cancelaButton = FlatButton(
    child: Text("Cancelar"),
    onPressed:  () {
      Navigator.pop(context);
    },
  );
  Widget continuaButton = FlatButton(
    child: Text("Deletar"),
    onPressed:  () {
      AuthService().deleteProcess(user, idProcesso);
      Navigator.pop(context);
      _pageController.jumpToPage(1);
    },
  );

  //configura o AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Deletar Processo", style: TextStyle(fontWeight: FontWeight.bold),),
    content: Container(
      height: 40,
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text("O processo e todos seus arquivos relacionados serão apagados. Tem certeza de que deseja fazer isso ?"),
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