import 'package:cobts/Components/Constants.dart';
import 'package:cobts/Components/InputField.dart';
import 'package:cobts/Components/RoundedButton.dart';
import 'package:cobts/Services/Database.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PassengerScreen extends StatefulWidget {
  @override
  _PassengerScreenState createState() => _PassengerScreenState();
}

class _PassengerScreenState extends State<PassengerScreen> {

  String start;
  String destination;
  String busType;
  String noOfSeats;
  String busName;
  String price;

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF161d6f),
        title: Padding(
          padding: EdgeInsets.fromLTRB(105, 0, 0, 0),
          child: Text(
              'Admin'
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: size.width,
              height: 40,
              color: Colors.grey[300],
              child: Center(
                child: Text(
                  'Add a Bus route',
                ),
              ),
            ),
            SizedBox(height: 20,),
            InputField(
              hint: 'Name of the bus',
              icon: null,
              inputAction: TextInputAction.next,
              inputType: TextInputType.name,
              onChanged: (value) {
                busName = value;
                print(busName);
              },
              obsecureText: false,
              fontSize: 20,
            ),
            SizedBox(height: 15,),
            InputField(
              hint: 'Bus type',
              icon: null,
              inputAction: TextInputAction.next,
              inputType: TextInputType.name,
              onChanged: (value) {
                busType = value;
                print(busType);
              },
              obsecureText: false,
              fontSize: 20,
            ),
            SizedBox(height: 15,),
            InputField(
              hint: 'No. of seats',
              icon: null,
              inputAction: TextInputAction.next,
              inputType: TextInputType.number,
              onChanged: (value) {
                noOfSeats = value;
                print(noOfSeats);
              },
              obsecureText: false,
              fontSize: 20,
            ),
            SizedBox(height: 15,),
            InputField(
              hint: 'Route start',
              icon: null,
              inputAction: TextInputAction.next,
              inputType: TextInputType.name,
              onChanged: (value) {
                start = value;
                print(start);
              },
              obsecureText: false,
              fontSize: 20,
            ),
            SizedBox(height: 15,),
            InputField(
              hint: 'Destination',
              icon: null,
              inputAction: TextInputAction.next,
              inputType: TextInputType.name,
              onChanged: (value) {
                destination = value;
                print(destination);
              },
              obsecureText: false,
              fontSize: 20,
            ),
            SizedBox(height: 15,),
            InputField(
              hint: 'Price',
              icon: null,
              inputAction: TextInputAction.done,
              inputType: TextInputType.number,
              onChanged: (value) {
                price = value;
                print(price);
              },
              obsecureText: false,
              fontSize: 20,
            ),
            SizedBox(height: 20,),
            RoundedButton(
                text: 'Add Bus',
                onPressed: () async {
                  try {
                    if (noOfSeats != null && busName != null && busType !=null && start != null && destination != null && price != null) {
                      await DatabaseService().InsertBusData(busName, busType, noOfSeats, start, destination, price);
                      Alert(
                        context: context,
                        type: AlertType.success,
                        title: "Bus Added",
                        desc: 'Route has been successfully added!',
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
                    String error = e;
                    print(error);
                    Alert(
                      context: context,
                      type: AlertType.error,
                      title: "Error!",
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
            )
          ],
        ),
      )
    );
  }
}
