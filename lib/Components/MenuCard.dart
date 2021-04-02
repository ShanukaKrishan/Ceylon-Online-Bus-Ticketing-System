import 'package:flutter/material.dart';
import 'Constants.dart';

class MenuCard extends StatelessWidget {
  const MenuCard({
    Key key,
    @required this.icon,
    this.top,
    this.bottom,
    this.color,
    @required this.text
  }) : super(key: key);

  final BorderSide top;
  final BorderSide bottom;
  final IconData icon;
  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          border: Border(
            top: top,
            bottom: bottom,
          )
      ),
      child: GestureDetector(
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(
                icon,
                size: 25,
                color: color,
              ),
            ),
            Text(
              text,
              style: kHeading3,
            )
          ],
        ),
      ),
    );
  }
}