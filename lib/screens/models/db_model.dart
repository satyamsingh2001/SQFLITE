

import 'dart:io';

import 'package:users_data/services/database/db_test.dart';

class StoreData{

  int ?id;
  File? imageUrl;
  String name;
  String mobile;
  String email;

  StoreData({ this.id, required this.imageUrl,required this.name,required this.mobile,required this.email });

  factory StoreData.fromMap(Map<String, dynamic> map) {
    return StoreData(
      id: map[DbTesting.id],
      imageUrl: File(map[DbTesting.userImage] ?? ''),
      name: map[DbTesting.userName],
      mobile: map[DbTesting.userMobile],
      email: map[DbTesting.userEmail],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'email': email,

    };
  }

}