import 'package:flutter/material.dart';
import 'package:projetoPDS/theme.dart';

class CollapsingListTitle extends StatefulWidget {

  final String title;
  final IconData icon;
  final AnimationController animationController;
  final bool isSelected;
  final Function onTap;

  CollapsingListTitle({
    @required this.title, 
    @required this.icon, 
    @required this.animationController,
    this.isSelected = false,
    this.onTap
    });

  @override
  _CollapsingListTitleState createState() => _CollapsingListTitleState();
}

class _CollapsingListTitleState extends State<CollapsingListTitle> {

  Animation<double> widthAnimation, sizedBoxAnimation;

  @override
  void initState() {
    super.initState();
    widthAnimation = Tween<double>(begin: 60, end: 220).animate(widget.animationController);
    sizedBoxAnimation = Tween<double>(begin: 0, end: 10).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: widget.isSelected 
            ? Colors.transparent.withOpacity(0.3)
            : Colors.transparent,
        ),
        width: widthAnimation.value,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            Icon(
              widget.icon, 
              color: widget.isSelected 
                ? Colors.white // selectedColor 
                : Colors.black, 
              size: 28.0,
            ),
            SizedBox(width: sizedBoxAnimation.value),
            (widthAnimation.value >= 220)
              ? Text(
                  widget.title, 
                  style: widget.isSelected 
                    ? listTitleSelectedTextStyle 
                    : listTitleDefaultTextStyle,
                )
              : Container()
          ],
        ),
      ),
    );
  }
}