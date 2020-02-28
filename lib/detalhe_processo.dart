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
              Row(
                children: <Widget>[
                  Expanded(                
                    child: Container(
                      margin:const EdgeInsets.only(left: 90, top: 100.0, right: 30, bottom: 45),
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
                            // color: Colors.teal,
                            child: Row(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),                                                          
                                      child: Center(
                                        child: Icon(Icons.person_pin, color: Colors.black, size: 48),
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text(
                                            widget.processo.autor, 
                                            style: TextStyle(fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text(
                                            'ID 433824', 
                                            style: TextStyle(fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Container(
                                    margin: const EdgeInsets.only(right: 50.0),
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
                                      padding: const EdgeInsets.only(right: 20.0, bottom: 8),
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
                                      padding: const EdgeInsets.only(right: 20.0, bottom: 8),
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
                                      padding: const EdgeInsets.only(right: 20.0),
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: 100,
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0, top: 5),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Autor:     ',
                                  style: TextStyle(
                                    color: Color.fromRGBO(71, 128, 64, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  '${widget.processo.autor}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'CPF:       ',
                                  style: TextStyle(
                                    color: Color.fromRGBO(71, 128, 64, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  '${widget.processo.cpf}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Vara:       ',
                                  style: TextStyle(
                                    color: Color.fromRGBO(71, 128, 64, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  '${widget.processo.vara}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Cidade:   ',
                                  style: TextStyle(
                                    color: Color.fromRGBO(71, 128, 64, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  '${widget.processo.cidade}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Container(width: 20),
                                Text(
                                  'UF:  ',
                                  style: TextStyle(
                                    color: Color.fromRGBO(71, 128, 64, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  '${widget.processo.uf}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Advogado responsável:    ',
                                  style: TextStyle(
                                    color: Color.fromRGBO(71, 128, 64, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  '${widget.processo.advogado}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Contato: ',
                                  style: TextStyle(
                                    color: Color.fromRGBO(71, 128, 64, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  '${widget.processo.contato}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 20.0, right: 80),
                            child: Divider(
                              color: Color.fromRGBO(170, 205, 165, 1),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Data:  ',
                                  style: TextStyle(
                                    color: Color.fromRGBO(71, 128, 64, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  '${widget.processo.data}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'CEP:  ',
                                  style: TextStyle(
                                    color: Color.fromRGBO(71, 128, 64, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  '${widget.processo.cep}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'OAB:  ',
                                  style: TextStyle(
                                    color: Color.fromRGBO(71, 128, 64, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  '${widget.processo.oab}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: <Widget>[
                                Text(
                                  'Nº Protocolo:  ',
                                  style: TextStyle(
                                    color: Color.fromRGBO(71, 128, 64, 1),
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                                Text(
                                  '${widget.processo.protocolo}',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 10,
                  ),
                  Container(
                    color: Color.fromRGBO(170, 205, 165, 1),
                    height: 400,
                    width: 2,
                  ),
                  Container(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      height: 400,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: const EdgeInsets.only(top: 10.0, bottom: 15),
                            child: Text(
                              'Arquivos anexados', 
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.8),
                                fontSize: 18,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          Expanded(
                            child: Scrollbar(
                              child: ListView.builder(
                                itemCount: widget.processo.archives.length,
                                itemBuilder: (context, index) {
                                  return Card(     
                                    color: Color.fromRGBO(170, 205, 165, 1),                             
                                    child: InkWell(
                                      splashColor: Colors.blue.withAlpha(30),
                                      onTap: () {
                                        print('Card tapped.');
                                        // _pageController.animateToPage(2, duration: null, curve: null);
                                      },
                                      child: Container(                        
                                        height: 80,
                                        child: Row(
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[                                              
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 10),
                                                      child: Text(
                                                        'Anexo ${index + 1}', 
                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 10, right: 10),
                                                      child: Text(
                                                        'ID 433824', 
                                                        style: TextStyle(fontStyle: FontStyle.italic),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Container(
                                              color: Colors.grey,
                                              height: 40,
                                              width: 1,
                                            ),
                                            Expanded(
                                              child: Container(
                                                margin: const EdgeInsets.only(left: 10.0),
                                                alignment: Alignment.centerLeft,
                                                // color: Colors.amberAccent,
                                                height: 80,
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Text(
                                                      'Descrição da testemunha', 
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.bold
                                                      ),
                                                    ),
                                                    Text(
                                                      '2 páginas',
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight: FontWeight.bold,
                                                        fontStyle: FontStyle.italic
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.only(right: 20.0),
                                              child: Center(
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
                                            ),                                          
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 40,
                  ),
                ],
              ),
            ],
          ),
          CollapsingNavigationDrawer(widget.pageController, 2, widget.user)
        ],
      ),
    );
  }
}