import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cobts/Components/Constants.dart';
import 'package:cobts/Screens/PaymentScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cobts/Services/Database.dart';

class ResultScreen extends StatefulWidget {

  ResultScreen({this.uid,this.start, this.destination, this.subDate, this.subType});
  final uid;
  final start;
  final destination;
  final subDate;
  final subType;

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {

  String userID ;
  String startLoc ;
  String destLoc ;
  String date ;
  String type ;

  void setUID (dynamic uid, dynamic start, dynamic destination, dynamic subDate, dynamic subType) {
    setState(() {
      userID = uid;
      startLoc = start;
      destLoc = destination;
      date = subDate;
      type = subType;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setUID(widget.uid,widget.start, widget.destination, widget.subDate, widget.subType);
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF161d6f),
        title: Padding(
          padding: EdgeInsets.fromLTRB(100, 0, 0, 0),
          child: Text(
            "Results",
            style: kHeading1White,
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
          stream: Firestore.instance.collection('BusInfo').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView(
              children: snapshot.data.documents.map((document) {
                return GestureDetector(
                  onTap: () {
                    String price = document['price'];
                    String name = document['name'];
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return PaymentScreen(uid: userID, start: startLoc, destination: destLoc, subDate: date, subType: type, price: price, busName: name);
                    }));
                  },
                  child: Card(
                    elevation:5,
                    margin: EdgeInsets.fromLTRB(10.0, 16.0, 10.0, 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    child: Container(
                      height: 150,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                child: Icon(
                                  FontAwesomeIcons.bus,
                                  color: Colors.black54,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(10, 20, 0, 0),
                                child: Text(
                                  document['name'],
                                  style: kHeading3,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(225, 20, 0, 0),
                                child: Text(
                                  document['type'],
                                  style: kHeading3,
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(55, 10, 0, 0),
                                child: Text(
                                  ""+ document['start'] +" to " + document['destination'] + "",
                                  style: kHeading3,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(55, 10, 0, 0),
                                child: Text(
                                  "No of seats: " +document['seats'],
                                  style: kHeading3,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                  padding: EdgeInsets.fromLTRB(55, 10, 0, 0),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.black54,
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.black54,
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.black54,
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.black54,
                                  )
                              ),
                              Padding(
                                  padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                                  child: Icon(
                                    Icons.star_border,
                                    color: Colors.black54,
                                  )
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(150, 10, 0, 0),
                                child: Text(
                                  "\$ "+ document['price'],
                                  style: kHeading3,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            );
          }
      )
    );
  }
}

// Column(
// children: [
// Container(
// width: size.width,
// height: 40,
// color: Colors.grey[300],
// child: Center(
// child: Text(
// 'Tue, 4th Dec 2021',
// ),
// ),
// ),


