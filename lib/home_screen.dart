import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projetoPDS/auth_service.dart';
import 'package:projetoPDS/create_arquivo.dart';
import 'package:projetoPDS/models/user.dart';
import 'package:projetoPDS/theme.dart';
import 'package:projetoPDS/widgets/collapsing_navigation_drawer.dart';

User user = User();

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pageController = PageController(initialPage: 0, keepPage: false);

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
                    return Center(
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("You are logged in ${snapshot.data.name}"),
                            SizedBox(height: 10.0),
                            Container(
                              height: 40,
                              width: 100,
                              child: RaisedButton(
                                onPressed: () {
                                  AuthService().signOut();
                                },
                                child: Center(
                                  child: Text("Sign out"),
                                ),
                                color: Color.fromRGBO(159, 230, 136, 1.0),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Container(
                                height: 40,
                                width: 100,
                                child: Center(
                                  child: RaisedButton(
                                    onPressed: () {
                                      // Navigator.push(
                                      //   context,
                                      //   MaterialPageRoute(builder: (context) => CreateArquivo()),
                                      // );
                                    },
                                    child: Center(
                                      child: Text("Adicionar Arquivo"),
                                    ),
                                    color: Color.fromRGBO(128, 182, 124, 1.0),
                                  ),
                                ),
                              ),
                            )
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
        Container(color: Colors.blue),
      ]
    );
  }
}