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
                            padding: EdgeInsets.only(left: 30, top: 50, bottom: 30),
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
                                  decoration: InputDecoration(hintText: "Procurar Arquivo", fillColor: Colors.white),
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
                                        color: Color.fromRGBO(226, 226, 226, 1),
                                        height: 400,
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
                                                        children: <Widget>[
                                                          Text(i.toString()),
                                                          // Container(
                                                          //   color: Colors.teal,
                                                          //   width: 70,
                                                          //   height: 100,
                                                          // ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(12.0),                                                          
                                                            child: Center(
                                                              child: CircleAvatar(
                                                                child: Icon(Icons.person_pin, size: 15,),
                                                              ),
                                                            ),
                                                          ),
                                                          Text(processos[i].autor),
                                                        ],
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          // color: Colors.amberAccent,
                                                          height: 100,
                                                        ),
                                                      ),
                                                      Column(
                                                        children: <Widget>[
                                                          Container(
                                                            // color: Colors.teal,
                                                            width: 70,
                                                            height: 100,
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
                              Expanded(
                                child: Container(
                                  color: Colors.amberAccent,
                                  height: 100,
                                ),
                              ),
                              Container(
                                width: 30,
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
}