import 'package:cobts/Components/Constants.dart';
import 'package:cobts/Components/RoundedButton.dart';
import 'package:cobts/Screens/PreviousRidesScreen.dart';
import 'package:cobts/Screens/ProfileScreen.dart';
import 'package:cobts/Screens/ResultScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cobts/Components/LabeledRadio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cobts/Services/Database.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class BookingScreen extends StatefulWidget {

  BookingScreen({this.uid});
  final uid;

  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {

  String userID ;
  int _selectedIndex = 0;
  String isRadioSelected ;
  final _auth = FirebaseAuth.instance;

  String pickup;
  String destination;
  String subType;
  String subDate;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  setSelectedRadio (String val) {
    setState(() {
      isRadioSelected = val;
    });
  }

  void setUID (dynamic uid) {
    setState(() {
      userID = uid;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUID(widget.uid);
  }
  @override
  Widget build(BuildContext context) {

    Color color = Colors.black54;
    Size size = MediaQuery.of(context).size;

    final tabs = [

      SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: Color(0xFF161d6f),
              height: 90,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0,),
                    child: Text(
                      'My',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0,),
                    child: Icon(
                      Icons.directions_bus_rounded,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  SizedBox(width: 10,),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 15, 0, 0,),
                    child: Text(
                      'Bus',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Card(
              elevation:5,
              margin: EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Container(
                height: 190,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 320, 0,),
                      child: Text('From', style: kHeading3,),
                    ),
                    TextField(
                      onChanged: (value) {
                        pickup = value;
                        print(pickup);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Icon(
                            FontAwesomeIcons.building,
                            size: 28,
                            color: Colors.black45,
                          ),
                        ),
                        hintText: 'Enter Pickup Location',
                        hintStyle: GoogleFonts.josefinSans(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(10, 15, 70, 0,),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black26,
                              width: 1,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(330, 0, 0, 0,),
                          child: RotatedBox(
                            quarterTurns: 1,
                            child: Icon(
                              Icons.compare_arrows,
                              color: Colors.black26,
                              size: 35,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 320, 0,),
                      child: Text('To', style: kHeading3,),
                    ),
                    TextField(
                      onChanged: (value) {
                        destination = value;
                        print(destination);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Icon(
                            FontAwesomeIcons.building,
                            size: 28,
                            color: Colors.black45,
                          ),
                        ),
                        hintText: 'Enter Destination',
                        hintStyle: GoogleFonts.josefinSans(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation:5,
              margin: EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Container(
                height: 110,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 12, 240, 5,),
                      child: Text('Subscription Start', style: kHeading3,),
                    ),
                    TextField(
                      onChanged: (value) {
                        subDate = value;
                        print(subDate);
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Icon(
                            FontAwesomeIcons.calendarAlt,
                            size: 28,
                            color: Colors.black45,
                          ),
                        ),
                        hintText: 'YYYY/MM/DD',
                        hintStyle: GoogleFonts.josefinSans(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 5,),
            Card(
              elevation:5,
              margin: EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Container(
                height: 110,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 12, 240, 5,),
                      child: Text('Subscription Type', style: kHeading3,),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LabeledRadio(
                          label: 'Monthly',
                          padding: const EdgeInsets.fromLTRB(20, 10, 10, 0,),
                          value: 'Monthly',
                          groupValue: isRadioSelected,
                          onChanged: (val) {
                            setSelectedRadio(val);
                            subType = 'Monthly';
                          },
                        ),
                        LabeledRadio(
                          label: 'Weekly',
                          padding: const EdgeInsets.fromLTRB(20, 10, 10, 0,),
                          value: 'Weekly',
                          groupValue: isRadioSelected,
                          onChanged: (val) {
                            setSelectedRadio(val);
                            subType = 'Weekly';
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10,),
            RoundedButton(
              text: 'Search Bus',
              onPressed: () async {
                try {
                  if (pickup != null && destination != null && subType !=null && subDate != null) {
                    print(userID);
                    await DatabaseService(uid: userID).updateRideData(pickup, destination, subType, subDate);
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return ResultScreen(uid: userID, start: pickup, destination: destination, subDate: subDate, subType: subType,);
                    }));
                  } else {
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "Error",
                      desc: "Please fill all the textfields",
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
                  }
                } catch (e) {
                  String error = (e);
                  Alert(
                    context: context,
                    type: AlertType.error,
                    title: "Error",
                    desc: error,
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
                }
              }
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
      PreviousRidesScreen(uid: userID,),
      ProfileScreen(uid: userID,),
    ];

    return Scaffold(

      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.home,),
            label: 'Home',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.menu,),
            label: 'Booking',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,),
            label: 'Account',
            backgroundColor: Colors.black,
          )
        ],
      ),

      body: tabs[_selectedIndex],
    );
  }
}