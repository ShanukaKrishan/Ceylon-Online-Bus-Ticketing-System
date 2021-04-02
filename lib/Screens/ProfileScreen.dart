import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobts/Components/Constants.dart';
import 'package:cobts/Components/MenuCard.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatefulWidget {

  ProfileScreen({this.uid});
  final uid;

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  int _selectedIndex = 0;
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedinUser;
  String userID ;

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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      getCurrentUser();
    });
  }

  void getCurrentUser() async{
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user as FirebaseUser;
        print("User: $userID");
      }
    } catch (e) {
      String error = e.toString();
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF161d6f),
        title: Padding(
          padding: EdgeInsets.fromLTRB(80, 0, 0, 0),
          child: Text(
              'My Account'
          ),
        ),
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection('UserInfo').document(userID).collection('UserDetails').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data.documents.map((document) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        height: 40,
                        color: Colors.grey[300],
                        child: Center(
                          child: Text(
                            'User Information',
                          ),
                        ),
                      ),
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
                      SizedBox(height: 20,),
                      Center(
                        child: Text(
                          document['Name'],
                          style: kHeading3,
                        ),
                      ),
                      SizedBox(height: 05,),
                      Center(
                        child: Text(
                          "Mobile: " +document['Mobile'],
                          style: kHeading3,
                        ),
                      ),
                      SizedBox(height: 20,),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/PreviousRidesScreen');
                        },
                        child: MenuCard(
                          icon: Icons.directions_bus,
                          text: 'Previous Rides',
                          top: BorderSide(color: Colors.black26, width: 1),
                          bottom: BorderSide(color: Colors.black26, width: 1),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/ForgotPasswordScreen');
                        },
                        child: MenuCard(
                          icon: Icons.lock,
                          text: 'Change Password',
                          bottom: BorderSide(color: Colors.black26, width: 1),
                          top: BorderSide(color: Colors.white, width: 0),
                        ),
                      ),
// MenuCard(
//   icon: Icons.credit_card_outlined,
//   text: 'Saved Cards',
//   bottom: BorderSide(color: Colors.black26, width: 1),
//   top: BorderSide(color: Colors.white, width: 0),
// ),
// MenuCard(
//   icon: Icons.location_on,
//   text: 'Location Settings',
//   bottom: BorderSide(color: Colors.black26, width: 1),
//   top: BorderSide(color: Colors.white, width: 0),
// ),
                      GestureDetector(
                        onTap: () {
                          _auth.signOut();
                          Navigator.pushNamed(context, '/');

                        },
                        child: MenuCard(
                          icon: Icons.logout,
                          text: 'Logout',
                          bottom: BorderSide(color: Colors.black26, width: 1),
                          top: BorderSide(color: Colors.white, width: 0),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          }
      )
    );
  }
}

