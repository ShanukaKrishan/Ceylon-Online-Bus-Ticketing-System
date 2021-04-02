import 'package:cobts/Components/Constants.dart';
import 'package:cobts/Screens/ReservationPrevious.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PreviousRidesScreen extends StatefulWidget {

  PreviousRidesScreen({this.uid});
  final uid;

  @override
  _PreviousRidesScreenState createState() => _PreviousRidesScreenState();
}

class _PreviousRidesScreenState extends State<PreviousRidesScreen> {

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

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF161d6f),
        title: Padding(
          padding: EdgeInsets.fromLTRB(30, 0, 0, 0),
          child: Text(
            'Previous Subscriptions',
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
        stream: Firestore.instance.collection('UserInfo').document(userID).collection('Ride').snapshots(),
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
                  String start = document['pickup'];
                  String dest = document['destination'];
                  String date = document['subDate'];
                  String type = document['subType'];
                  String price = document['price'];
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ReservationPrevious(uid: userID, start: start, destination: dest, subDate: date, subType: type, price: price,);
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
                                document['subType'],
                                style: kHeading3,
                              ),
                            ),
                            // Padding(
                            //   padding: EdgeInsets.fromLTRB(210, 20, 0, 0),
                            //   child: Text(
                            //     'Luxury',
                            //     style: kHeading3,
                            //   ),
                            // )
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(55, 10, 0, 0),
                              child: Text(
                                document['subDate'],
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
                               ""+document['pickup'] +" - "+ document['destination']+" ",
                                style: kHeading3,
                              ),
                            ),
                          ],
                        ),
                        // Row(
                        //   children: [
                        //     Padding(
                        //         padding: EdgeInsets.fromLTRB(55, 10, 0, 0),
                        //         child: Icon(
                        //           Icons.star,
                        //           color: Colors.black54,
                        //         )
                        //     ),
                        //     Padding(
                        //         padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        //         child: Icon(
                        //           Icons.star,
                        //           color: Colors.black54,
                        //         )
                        //     ),
                        //     Padding(
                        //         padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        //         child: Icon(
                        //           Icons.star,
                        //           color: Colors.black54,
                        //         )
                        //     ),
                        //     Padding(
                        //         padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        //         child: Icon(
                        //           Icons.star,
                        //           color: Colors.black54,
                        //         )
                        //     ),
                        //     Padding(
                        //         padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                        //         child: Icon(
                        //           Icons.star_border,
                        //           color: Colors.black54,
                        //         )
                        //     ),
                        //     // Padding(
                        //     //   padding: EdgeInsets.fromLTRB(150, 10, 0, 0),
                        //     //   child: Text(
                        //     //     " \$ "+document['price'],
                        //     //     style: kHeading3,
                        //     //   ),
                        //     // ),
                        //   ],
                        // ),
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


