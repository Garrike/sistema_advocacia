import 'package:flutter/material.dart';
import 'package:projetoPDS/models/user.dart';
import 'package:projetoPDS/top_bar.dart';
import 'package:projetoPDS/widgets/collapsing_navigation_drawer.dart';

class ProcessDetails extends StatefulWidget {
  PageController pageController;
  int i;
  User user;

  ProcessDetails(this.pageController, this.i, this.user);

  @override
  _ProcessDetailsState createState() => _ProcessDetailsState();
}

class _ProcessDetailsState extends State<ProcessDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          TopBar(),
          ListView(
            children: <Widget>[
              Center(
                child: Text('Detalhes do Processo'),
              ),
            ],
          ),
          CollapsingNavigationDrawer(widget.pageController, 2, widget.user)
        ],
      ),
    );
  }
}