import 'package:cobts/Components/Constants.dart';
import 'package:cobts/Components/InputField.dart';
import 'package:cobts/Components/RoundedButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ForgetPasswordScreen extends StatefulWidget {
  @override
  _ForgetPasswordScreenState createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 60,),
              Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Enter the email that you would like your password reset information to be sent',
                  style: kHeading1,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 20,),
              Center(
                child: InputField(
                  hint: 'Email',
                  fontSize: 25,
                  icon: Icons.email,
                  inputAction: TextInputAction.next,
                  inputType: TextInputType.name,
                  obsecureText: false,
                  onChanged: (value) {
                    String email = value;
                    print(email);
                    FirebaseAuth.instance.sendPasswordResetEmail(email: email);
                  },
                ),
              ),
              SizedBox(height: 40,),
              RoundedButton(
                text: 'Reset Password',
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                  Alert(
                    context: context,
                    type: AlertType.info,
                    title: "Alart",
                    desc: "Password reset link sent to email",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Continue",
                          style: kHeading1,
                        ),
                        onPressed: () => Navigator.pop(context),
                        width: 120,
                      )
                    ],
                  ).show();
                },
              ),
              SizedBox(
                height: 35,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
