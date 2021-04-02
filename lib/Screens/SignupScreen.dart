import 'package:cobts/Components/InputField.dart';
import 'package:cobts/Components/RoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:cobts/Services/Database.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final _auth = FirebaseAuth.instance;
  String name;
  String email;
  String password;
  String phone;
  String nationalID;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   leading: IconButton(
      //     onPressed: () {
      //       Navigator.pop(context);
      //     },
      //     icon: Icon(
      //       Icons.arrow_back,
      //       color: Colors.white,
      //     ),
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Center(
              child: CircleAvatar(
                radius: size.width * 0.14,
                backgroundColor: Colors.grey[400].withOpacity(0.5),
                child: Center(
                  child: Icon(
                    FontAwesomeIcons.user,
                    color: Colors.white,
                    size: size.width * 0.15,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            InputField(
              icon: FontAwesomeIcons.portrait,
              hint: 'Name',
              inputAction: TextInputAction.next,
              inputType: TextInputType.name,
              obsecureText: false,
              fontSize: 25,
              onChanged: (value) {
                name = value;
                print(name);
              },
            ),
            SizedBox(height: 15,),
            InputField(
              icon: FontAwesomeIcons.envelope,
              hint: 'Email',
              inputAction: TextInputAction.next,
              inputType: TextInputType.emailAddress,
              obsecureText: false,
              fontSize: 25,
              onChanged: (value) {
                email = value;
                print(email);
              },
            ),
            SizedBox(height: 15,),
            InputField(
              icon: FontAwesomeIcons.lock,
              hint: 'Password',
              inputAction: TextInputAction.next,
              inputType: TextInputType.name,
              obsecureText: true,
              fontSize: 25,
              onChanged: (value) {
                password = value;
                print(password);
              },
            ),
            SizedBox(height: 15,),
            InputField(
              icon: FontAwesomeIcons.phoneAlt,
              hint: 'Phone',
              inputAction: TextInputAction.next,
              inputType: TextInputType.number,
              obsecureText: false,
              fontSize: 25,
              onChanged: (value) {
                phone = value;
                print(phone);
              },
            ),
            SizedBox(height: 15,),
            InputField(
              icon: FontAwesomeIcons.idCard,
              hint: 'National ID',
              inputAction: TextInputAction.done,
              inputType: TextInputType.name,
              obsecureText: false,
              fontSize: 25,
              onChanged: (value) {
                nationalID = value;
                print(nationalID);
              },
            ),
            SizedBox(
              height: 30,
            ),
            RoundedButton(
              text: 'Register',
              onPressed: () async {
                try {
                  final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                  await DatabaseService(uid: newUser.uid).updateUserData(name, nationalID, phone);
                  print(email);
                  print(password);
                  print(name);
                  print(phone);
                  print(nationalID);
                  if (newUser != null) {
                    Navigator.pushNamed(context, '/');
                  }
                } catch (e) {
                  print(e);
                  String error = e.toString();
                  Alert(
                    context: context,
                    type: AlertType.error,
                    title: "Error",
                    desc: error,
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Continue",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        width: 120,
                      )
                    ],
                  ).show();
                }

              },
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              child: GestureDetector(
                onTap: () => Navigator.pushNamed(context, '/'),
                child: Text(
                  'Already have an account? Login',
                  style: GoogleFonts.josefinSans(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(width: 1, color: Colors.black54),
                ),
              ),
            ),
            // SizedBox(height: 30,)
          ],
        ),
      ),
    );
  }
}
