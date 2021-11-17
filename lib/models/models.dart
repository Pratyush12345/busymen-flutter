import 'package:firebase_database/firebase_database.dart';

class UserDetailModel {
  String name;
  String positionName;
  String phoneNumber;
  String officeAddress;
  String localAddress;
  UserDetailModel(
      {required this.name,
      required this.positionName,
      required this.phoneNumber,
      required this.officeAddress,
      required this.localAddress});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['positionName'] = this.positionName;
    data['phoneNumber'] = this.phoneNumber;
    data['officeAddress'] = this.officeAddress;
    data['localAddress'] = this.officeAddress;
    return data;
  }
  UserDetailModel.fromSnapshot(DataSnapshot snapshot)
      : name = snapshot.value["name"],
      positionName = snapshot.value["positionName"],
      phoneNumber = snapshot.value["phoneNumber"],
      officeAddress = snapshot.value["officeAddress"],
      localAddress = snapshot.value["localAddress"];
}

class ConnectivityCheckModel {
  final String status;
  ConnectivityCheckModel({required this.status});
}