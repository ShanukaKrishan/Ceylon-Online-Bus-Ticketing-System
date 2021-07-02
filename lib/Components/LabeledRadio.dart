import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Constants.dart';

class LabeledRadio extends StatelessWidget {
  const LabeledRadio({
    this.label,
    this.padding,
    @required this.groupValue,
    @required this.value,
    @required this.onChanged,
  });

  final String label;
  final EdgeInsets padding;
  final String groupValue;
  final String value;
  final Function onChanged;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (value != groupValue)
          onChanged(value);
      },
      child: Padding(
        padding: padding,
        child: Row(
          children: <Widget>[
            Radio<String>(
              groupValue: groupValue,
              value: value,
              activeColor: Colors.blueAccent,
              onChanged: (String newValue) {
                onChanged(newValue);
              },
            ),
            Text(
              label,
              style: GoogleFonts.josefinSans(
                color: Colors.black54,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )
            ),
          ],
        ),
      ),
    );
  }
}