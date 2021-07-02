import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InputField extends StatelessWidget {
  const InputField({
    Key key,
    this.inputAction,
    this.inputType,
    this.obsecureText,
    this.onChanged,
    this.fontSize,
    @required this.hint,
    @required this.icon,
  }) : super(key: key);

  final IconData icon;
  final String hint;
  final double fontSize;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final bool obsecureText;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height * 0.08,
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.grey[500].withOpacity(0.5),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: TextField(
          decoration: InputDecoration(
            border: InputBorder.none,
            prefixIcon: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Icon(
                icon,
                size: 28,
                color: Colors.black45,
              ),
            ),
            hintText: hint,
            hintStyle: GoogleFonts.josefinSans(
              fontSize: fontSize,
              color: Colors.black45,
            ),
          ),
          obscureText: obsecureText,
          style: GoogleFonts.josefinSans(
            fontSize: fontSize,
            fontWeight: FontWeight.bold,
            color: Colors.black45,
          ),
          keyboardType: inputType,
          textInputAction: inputAction,
          onChanged: onChanged,
          autocorrect: true,
        ),
      ),
    );
  }
}
