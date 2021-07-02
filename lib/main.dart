import 'package:cobts/Screens/BookingScreen.dart';
import 'package:cobts/Screens/LoginScreen.dart';
import 'package:cobts/Screens/PassengerScreen.dart';
import 'package:cobts/Screens/PaymentScreen.dart';
import 'package:cobts/Screens/ProfileScreen.dart';
import 'package:cobts/Screens/ReservationDetailsScreen.dart';
import 'package:cobts/Screens/ResultScreen.dart';
import 'package:cobts/Screens/SignupScreen.dart';
import 'package:flutter/material.dart';

import 'Screens/ForgetPasswordScreen.dart';
import 'Screens/PreviousRidesScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ceylon Online Bus Ticketing Service',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/SignupScreen': (context) => SignupScreen(),
        '/ForgotPasswordScreen': (context) => ForgetPasswordScreen(),
        '/ProfileScreen': (context) => ProfileScreen(),
        '/ResultScreen': (context) => ResultScreen(),
        '/PassengerScreen': (context) => PassengerScreen(),
        '/BookingScreen': (context) => BookingScreen(),
        '/PaymentScreen': (context) => PaymentScreen(),
        '/ReservationDetailsScreen': (context) => ReservationDetailsScreen(),
        '/PreviousRidesScreen': (context) => PreviousRidesScreen(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}
