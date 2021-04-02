import 'package:cobts/Components/InputField.dart';
import 'package:cobts/Components/RoundedButton.dart';
import 'package:cobts/Screens/BookingScreen.dart';
import 'package:cobts/Screens/PassengerScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _auth = FirebaseAuth.instance; //firebase connection
  String email; //email value
  String password; //password value

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60,),
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 50,),
              Center(
                child: InputField(
                  hint: 'Email',
                  fontSize: 25,
                  icon: Icons.account_circle,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.name,
                  obsecureText: false,
                  onChanged: (value) {
                    email = value;
                    print(email);
                  },
                ),
              ),
              SizedBox(height: 20,),
              InputField(
                hint: 'Password',
                fontSize: 25,
                icon: Icons.lock,
                inputAction: TextInputAction.next,
                inputType: TextInputType.name,
                obsecureText: true,
                onChanged: (value) {
                  password = value;
                  print(password);
                },
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.fromLTRB(190.0, 0.0, 0.0, 0.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/ForgotPasswordScreen'),
                  child: Text(
                    'Forgot Password',
                    style: GoogleFonts.josefinSans(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40,),
              RoundedButton(
                text: 'Login',
                onPressed: () async {
                  if(email =='admin@gmail.com' && password == 'admin123') {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return PassengerScreen();
                    }));
                  } else {
                    try {
                      final user = await _auth.signInWithEmailAndPassword(email: email, password: password);

                      if (user != null) {
                        String uid = user.uid;
                        print(uid);
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return BookingScreen(uid: uid,);
                        }));
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
                  }
                },
              ),
              SizedBox(
                height: 35,
              ),
              Container(
                child: GestureDetector(
                  onTap: () => Navigator.pushNamed(context, '/SignupScreen'),
                  child: Text(
                    'Create New Account',
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
            ],
          ),
        ),
      ),
    );
  }
}
