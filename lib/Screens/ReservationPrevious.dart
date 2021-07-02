import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobts/Components/RoundedButton.dart';
import 'package:flutter/material.dart';
import 'package:cobts/Components/Constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReservationPrevious extends StatefulWidget {

  ReservationPrevious({this.uid,this.start, this.destination, this.subDate, this.subType, this.price, this.name});
  final uid;
  final start;
  final destination;
  final subDate;
  final subType;
  final price;
  final name;

  @override
  _ReservationPreviousState createState() => _ReservationPreviousState();
}

class _ReservationPreviousState extends State<ReservationPrevious> {

  String userID ;
  String startLoc ;
  String destLoc ;
  String date ;
  String type ;
  String busFare;
  String busName;
  String userName;

  void setUID (dynamic uid, dynamic start, dynamic destination, dynamic subDate, dynamic subType, dynamic price, dynamic name) {
    setState(() {
      userID = uid;
      startLoc = start;
      destLoc = destination;
      date = subDate;
      type = subType;
      busFare = price;
      busName = name;
    });
  }

  @override
  void initState() {
    super.initState();
    setUID(widget.uid,widget.start, widget.destination, widget.subDate, widget.subType, widget.price, widget.name);
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF161d6f),
        title: Padding(
          padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
          child: Text(
            'Reservation Details',
            style: kAppBarTitle,
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
                return Column(
                  children: [
                    Container(
                      width: size.width,
                      height: 40,
                      color: Colors.grey[300],
                      child: Center(
                        child: Text(
                          'Confirmed Subscription: $type',
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'From: $startLoc',
                            style: kHeading3,
                          ),
                          Text(
                            'To: $destLoc',
                            style: kHeading3,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.black54, width: 1),
                            bottom: BorderSide(color: Colors.white, width: 0),
                          )
                      ),
                    ),
                    SizedBox(height: 15,),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Subscription Type',
                            style: kHeading3,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 40, 0),
                            child: Text(
                              'Subscribed Date',
                              style: kHeading3,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '$type',
                            style: kHeading5,
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 65, 0),
                            child: Text(
                              '$date',
                              style: kHeading5,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 15,),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                          border: Border(
                            top: BorderSide(color: Colors.black54, width: 1),
                            bottom: BorderSide(color: Colors.white, width: 0),
                          )
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Icon(
                            FontAwesomeIcons.userAlt,
                            color: Colors.black54,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                          child: Text(
                            document['Name'],
                            style: kHeading3,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(50, 10, 0, 0),
                          child: Text(
                            'Total Fare: \$ 120',
                            style: kHeading3,
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20,),
                    QrImage(
                      data: "Subcsription ID: $userID \n Route: $startLoc to $destLoc \n Subscription Type: $type \n Subscription Start: $date \n User Name: "+document['Name']+" \n Fare: $busFare",
                      version: QrVersions.auto,
                      size: 180,
                      gapless: false,
                    ),
                    SizedBox(height: 20,),
                    RoundedButton(
                      text: 'Continue',
                      onPressed: () {
                        Navigator.pushNamed(context, '/BookingScreen');
                      },
                    )
                  ],
                );
              }).toList(),
            );
          }
      )
    );
  }
}