import 'package:flutter/material.dart';
import 'package:projetoPDS/models/arquivos.dart';
import 'package:projetoPDS/models/user.dart';
import 'package:projetoPDS/top_bar.dart';
import 'package:projetoPDS/widgets/collapsing_navigation_drawer.dart';

class ProcessDetails extends StatefulWidget {
  PageController pageController;
  Processo processo;
  int i;
  User user;

  ProcessDetails(this.pageController, this.i, this.user, this.processo);

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
              Padding(
                padding: const EdgeInsets.only(left: 90, top: 40.0),
                child: Text(
                  'Gerenciador de Processos',
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
                padding: const EdgeInsets.only(left: 90, top: 80.0, right: 30),
                child: Expanded(
                  child: Card(     
                    color: widget.processo.status == "Aberto" ? Color.fromRGBO(221, 239, 215, 1) 
                    : Color.fromRGBO(239, 215, 215, 1),                                     
                    child: InkWell(
                      splashColor: Colors.blue.withAlpha(30),
                      onTap: () {
                        print('Card tapped.');
                        // _pageController.animateToPage(2, duration: null, curve: null);
                      },
                      child: Container(
                        height: 100,
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                // Padding(
                                //   padding: const EdgeInsets.only(top: 5.0, left: 10, bottom: 5),
                                //   child: Text('ID ${user.processes[i]}', style: TextStyle(fontSize: 14),),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),                                                          
                                  child: Center(
                                    child: Icon(Icons.person_pin, color: Colors.black, size: 48),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10.0, left: 10),
                                  child: Text(
                                    widget.processo.autor, 
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
                                      '${widget.processo.archives.length.toString()}', 
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
                  ),
                ),
              ),
            ],
          ),
          CollapsingNavigationDrawer(widget.pageController, 2, widget.user)
        ],
      ),
    );
  }
}