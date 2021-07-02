import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  // collection reference
  final CollectionReference userCollection = Firestore.instance.collection('UserInfo');
  final CollectionReference busCollection = Firestore.instance.collection('BusInfo');

  Future<void> updateUserData(String name, String nic, String mobile ) async {
    return await userCollection.document(uid).collection('UserDetails').document('Info').setData({
      'Name': name,
      'Nic': nic,
      'Mobile': mobile,
    });
  }

  Future<void> updateRideData(  String pickup,  String destination,  String subType,  String subDate ) async {
    return await userCollection.document(uid).collection('Ride').document().setData({
      'pickup': pickup,
      'destination': destination,
      'subType': subType,
      'subDate' : subDate,
    });
  }

  Future<void> InsertBusData( String name, String type, String seats, String start, String destination, String price ) async {
    return await busCollection.document().setData({
     'name' : name,
     'type' : type,
     'seats' : seats,
     'start' : start,
     'destination' : destination,
      'price' : price,
    });
  }

  // // get brews stream
  // Stream<QuerySnapshot> get brews {
  //   return brewCollection.snapshots();
  // }

}