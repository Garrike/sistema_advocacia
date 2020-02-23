import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projetoPDS/auth_service.dart';
import 'package:projetoPDS/create_arquivo.dart';
import 'package:projetoPDS/models/user.dart';
import 'package:projetoPDS/theme.dart';
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 35.0, bottom: 35.0),
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                width: 30,
                              ),
                              Expanded(
                                child: Container(
                                  height: 450,
                                  child: 
                                  // FutureBuilder(
                                  //   future: AuthService().getProcess(),
                                  //   builder: (context, snapshot) {
                                  //     if(snapshot.hasData){
                                  //       List<Processo> processos = snapshot.data;
                                  //       ListView.builder(
                                  //         itemCount: numberTruthList.length,
                                  //         itemBuilder: (context, index) {
                                  //           return Card(
                                  //             child: ListTile(
                                  //               title: Text(numberTruthList[index].toString()),
                                  //             ),
                                  //           );
                                  //         },
                                  //       );
                                  //     }                                  
                                  //   },
                                  // ),
                                  FutureBuilder(
                                    future: AuthService().getProcess(),
                                    builder: (context, snapshot) {
                                      if(snapshot.hasData){
                                        List<Processo> processos = snapshot.data;
                                        print(processos.length);
                                        ListView.builder(
                                          itemCount: 6,
                                          itemBuilder: (context, i) {
                                            return Card(
                                              child: ListTile(
                                                title: Text(numberTruthList[i].toString()),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    }
                                  ),
                                ),
                              ),
                              Container(
                                width: 60,
                              ),
                              Expanded(
                                child: Container(
                                  color: Colors.amber,
                                  height: 100,
                                ),
                              ),
                              Container(
                                width: 30,
                              ),
                              // Text("You are logged in ${snapshot.data.name}"),
                              // SizedBox(height: 10.0),
                              // Container(
                              //   height: 40,
                              //   width: 100,
                              //   child: RaisedButton(
                              //     onPressed: () {
                              //       AuthService().signOut();
                              //     },
                              //     child: Center(
                              //       child: Text("Sign out"),
                              //     ),
                              //     color: Color.fromRGBO(159, 230, 136, 1.0),
                              //   ),
                              // ),
                              // Padding(
                              //   padding: EdgeInsets.only(top: 10),
                              //   child: Container(
                              //     height: 40,
                              //     width: 100,
                              //     child: Center(
                              //       child: RaisedButton(
                              //         onPressed: () {
                              //           // Navigator.push(
                              //           //   context,
                              //           //   MaterialPageRoute(builder: (context) => CreateArquivo()),
                              //           // );
                              //         },
                              //         child: Center(
                              //           child: Text("Adicionar Arquivo"),
                              //         ),
                              //         color: Color.fromRGBO(128, 182, 124, 1.0),
                              //       ),
                              //     ),
                              //   ),
                              // )
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
}