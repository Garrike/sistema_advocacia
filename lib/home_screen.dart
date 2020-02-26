import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projetoPDS/auth_service.dart';
import 'package:projetoPDS/create_arquivo.dart';
import 'package:projetoPDS/models/user.dart';
import 'package:projetoPDS/theme.dart';
import 'package:projetoPDS/top_bar.dart';
import 'package:projetoPDS/widgets/collapsing_navigation_drawer.dart';

import 'auth_service.dart';
import 'models/arquivos.dart';

User user = User();

List<bool> numberTruthList = [false, true, true, true , true, true];

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController(initialPage: 0, keepPage: false);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: NeverScrollableScrollPhysics(),
      children: <Widget> [ 
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: <Widget>[
        //     Column(
        //       children: <Widget>[
        //         ListView.builder(
        //           itemCount: test.length,
        //           itemBuilder: (context, index) {
        //             return Center(
        //               child: Text(test[index]),
        //             );
        //           },
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
        Scaffold(
          body: Stack(
            children: <Widget>[        
              FutureBuilder(
                future: AuthService().currentUser(),
                builder: (context, AsyncSnapshot<User> snapshot) {
                  if (snapshot.hasData) {
                    user = snapshot.data;
                    return Container(
                      margin: new EdgeInsets.only(left: 60.0),
                      color: Colors.white,
                      child: Stack(
                        children: <Widget>[
                          TopBar(),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 30, top: 35.0),
                                child: Text(
                                  'Dashboard',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold, 
                                    fontSize: 28, 
                                    color: Color.fromRGBO(0, 0, 0, 0.7),
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
                                  width: 350,
                                  decoration: BoxDecoration(
                                    color: Color.fromRGBO(89, 154, 96, 1),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: "Procurar Arquivo", 
                                        fillColor: Colors.white,
                                        hintStyle: TextStyle(fontWeight: FontWeight.bold)
                                      ),
                                      onChanged: (value) {
                                        print(value);
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    width: 30,
                                  ),
                                  FutureBuilder(
                                    future: AuthService().getProcess(user),
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData){                                      
                                        return Expanded(
                                          child: Container(                                            
                                            decoration: BoxDecoration(
                                              color: Color.fromRGBO(226, 226, 226, 1),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            height: 430,
                                            child: ListView.builder(
                                              itemCount: snapshot.data.length,
                                              itemBuilder: (context, i) {
                                                List<Processo> processos = snapshot.data;
                                                print(i);
                                                return Card(     
                                                  color: processos[i].status == "Aberto" ? Color.fromRGBO(221, 239, 215, 1) 
                                                  : Color.fromRGBO(239, 215, 215, 1),                                     
                                                  child: InkWell(
                                                    splashColor: Colors.blue.withAlpha(30),
                                                    onTap: () {
                                                      print('Card tapped.');
                                                    },
                                                    child: Container(
                                                      height: 100,
                                                      child: Row(
                                                        // crossAxisAlignment: CrossAxisAlignment.start,
                                                        // mainAxisAlignment: MainAxisAlignment.start,
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
                                            ),
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
                                                                    onPressed: () {
                                                                      print('tap accept');
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
                                                                      print('tap rejected');
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
                                                                '409', 
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
                                                height: 290,
                                                color: Colors.amberAccent
                                              ),                    
                                            ],
                                          ),
                                        );
                                      }
                                      return Expanded(
                                        child: Container(
                                          height: 100,
                                          child: Center(
                                            child: Text("Não há processos pendentes")
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
        Container(color: Colors.blue),
      ]
    );
  }

  getPending() {
    List lista = user.pending.toList();
    print(lista[0]);
    return lista[0];
  }
}