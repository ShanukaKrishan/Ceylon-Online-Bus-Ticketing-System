import 'package:flutter/material.dart';
import 'Constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key key,
    @required this.text,
    @required this.onPressed,
  }) : super(key: key);

  final String text;
  final Function onPressed;
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.09,
      width: size.width * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xFFe8505b),
      ),
      child: FlatButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: kHeading1White,
        ),
      ),
    );
  }
}