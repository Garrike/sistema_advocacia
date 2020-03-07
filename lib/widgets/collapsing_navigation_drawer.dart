import 'package:flutter/material.dart';
import 'package:projetoPDS/create_arquivo.dart';
import 'package:projetoPDS/models/navigation_model.dart';
import 'package:projetoPDS/models/user.dart';
import 'package:projetoPDS/theme.dart';

import '../auth_service.dart';
import '../home_screen.dart';
import 'collapsing_list_title.dart';

bool isCollapsed = true;

class CollapsingNavigationDrawer extends StatefulWidget {
  final PageController pageController;
  final int index;
  final User user;

  CollapsingNavigationDrawer(this.pageController, this.index, this.user);

  @override
  _CollapsingNavigationDrawerState createState() => _CollapsingNavigationDrawerState();
}

class _CollapsingNavigationDrawerState extends State<CollapsingNavigationDrawer> with SingleTickerProviderStateMixin{

  double maxWidth = 220;
  double minWidth = 60;
  
  AnimationController _animationController;
  Animation<double> widthAnimation;
  int currentSelectedIndex;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: minWidth, end: maxWidth).animate(_animationController);
    currentSelectedIndex = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) {
        return Material(
          elevation: 0.0,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter, // 10% of the width, so there are ten blinds.
                colors: [Color.fromRGBO(128, 182, 124, 1.0), Color.fromRGBO(159, 230, 136, 1.0)], 
              ),
            ),
            width: widthAnimation.value,
            //color: drawerBackgroundColor,
            child: Column(
              children: <Widget>[
                SizedBox(height: 15.0),
                FutureBuilder(
                  future: AuthService().currentUser(),
                  builder: (context, AsyncSnapshot<User> snapshot) {
                    if (snapshot.hasData) {
                      return CollapsingListTitle(
                        title: snapshot.data.name, //user.name 
                        icon: Icons.person,
                        animationController: _animationController,
                      );
                    } else {
                      return CollapsingListTitle(
                        title: 'Carregando..', //user.name 
                        icon: Icons.person,
                        animationController: _animationController,
                      );
                    }
                  }
                ),
                Divider(color: Colors.grey, height: 40.0,),
                Expanded(
                  child: ListView.separated(
                    separatorBuilder: (context, counter) {
                      return Divider(height: 12.0);
                    },
                    itemCount: navigationItens.length,
                    itemBuilder: (context, counter) {
                      return CollapsingListTitle(
                        onTap: () {
                          setState(() {
                            currentSelectedIndex = counter;
                            print(counter);
                            jumpPage(counter);
                          });
                        },
                        isSelected: currentSelectedIndex == counter,
                        title: navigationItens[counter].title,
                        icon: navigationItens[counter].icon,
                        animationController: _animationController,
                      );
                    },
                  ),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      isCollapsed ? _animationController.forward() : _animationController.reverse();
                      isCollapsed = !isCollapsed;
                      print(isCollapsed);
                    });
                  },  
                  child: AnimatedIcon(
                    icon: AnimatedIcons.close_menu,
                    progress: _animationController, 
                    color: Colors.black, 
                    size: 38.0
                  ),
                ),
                SizedBox(height: 50.0),
              ],
            )
          ),
        );
      }
    );
  }
                            
  void jumpPage(int counter) {
    widget.pageController.jumpToPage(counter);
  }
}