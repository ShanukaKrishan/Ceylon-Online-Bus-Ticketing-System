import 'package:cobts/Components/MenuCard.dart';
import 'package:cobts/Components/RoundedButton.dart';
import 'package:cobts/Screens/ReservationDetailsScreen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cobts/Components/Constants.dart';
import 'package:cobts/Components/LabeledRadio.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class PaymentScreen extends StatefulWidget {

  PaymentScreen({this.uid,this.start, this.destination, this.subDate, this.subType, this.price, this.busName});
  final uid;
  final start;
  final destination;
  final subDate;
  final subType;
  final price;
  final busName;

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {

  String isRadioSelected;
  String userID ;
  String startLoc ;
  String destLoc ;
  String date ;
  String type ;
  String busFare;
  String name;
  String paymentMethod;

  void setUID (dynamic uid, dynamic start, dynamic destination, dynamic subDate, dynamic subType, dynamic price, dynamic busName) {
    setState(() {
      userID = uid;
      startLoc = start;
      destLoc = destination;
      date = subDate;
      type = subType;
      busFare = price;
      name = busName;
    });
  }

  @override
  void initState() {
    super.initState();
    isRadioSelected = null;
    setUID(widget.uid,widget.start, widget.destination, widget.subDate, widget.subType, widget.price, widget.busName);
  }

  setSelectedRadio (String val) {
    setState(() {
      isRadioSelected = val;
    });
  }
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    Color menuCardColor = Colors.black54;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF161d6f),
        title: Padding(
          padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
          child: Text(
            'Payment Method',
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
      body: Column(
        children: [
          Container(
            width: size.width,
            height: 40,
            color: Colors.grey[300],
            child: Center(
              child: Text(
                'How would you like to pay?',
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
              height: 270,
              width: size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0,),
                    child: Text(
                      'Choose a payment method',
                      style: kHeading1,
                    ),
                  ),
                  LabeledRadio(
                    label: 'Credit Card',
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0,),
                    value: 'Credit Card',
                    groupValue: isRadioSelected,
                    onChanged: (val) {
                      setSelectedRadio(val);
                      paymentMethod = val;
                    },
                  ),
                  LabeledRadio(
                    label: 'Debit Card',
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0,),
                    value: 'Debit Card',
                    groupValue: isRadioSelected,
                    onChanged: (val) {
                      setSelectedRadio(val);
                      paymentMethod = val;
                    },
                  ),
                  LabeledRadio(
                    label: 'PayPal',
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0,),
                    value: 'PayPal',
                    groupValue: isRadioSelected,
                    onChanged: (val) {
                      setSelectedRadio(val);
                      paymentMethod = val;
                    },
                  ),
                  LabeledRadio(
                    label: 'Mobile Wallet',
                    padding: const EdgeInsets.fromLTRB(0, 5, 0, 0,),
                    value: 'Mobile Wallet',
                    groupValue: isRadioSelected,
                    onChanged: (val) {
                      setSelectedRadio(val);
                      paymentMethod = val;
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20,),
          Text(
            'TRAVEL SUMMARY',
            style: kHeading3,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 15,),
              Text(
                '$startLoc to $destLoc, $date',
                style: kHeading5,
              ),
              SizedBox(height: 5,),
              Text(
                'Arriving $destLoc at 6:00 PM',
                style: kHeading5,
              ),
              SizedBox(height: 5,),
              Text(
                '$type Subscription',
                style: kHeading5,
              )
            ],
          ),
          SizedBox(height: 15,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black45,
                )
            ),
          ),
          SizedBox(height: 20,),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total Fare',
                  style: kHeading3,
                ),
                Text(
                  '\$ $busFare',
                  style: kHeading3,
                ),
              ],
            ),
          ),
          SizedBox(height: 25,),
          RoundedButton(
            text: 'Pay Now',
            onPressed: () {
              try {
                if (paymentMethod != null) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ReservationDetailsScreen(uid: userID, start: startLoc, destination: destLoc, subDate: date, subType: type, price: busFare, name: name);
                  }));
                } else {
                  Alert(
                    context: context,
                    type: AlertType.error,
                    title: "Error",
                    desc: "Please select a payment method",
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
        ],
      ),
    );
  }
}
