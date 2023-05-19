import 'package:flutter/material.dart';

class Profile extends ChangeNotifier {
  final String uid;
  final String? fName;
  final String? lName;
  final String? telno;
  final bool seller;
  final String? username;
  final String? sex;
  final String? icon;

  Profile({
    required this.uid,
    this.fName,
    this.lName,
    this.telno,
    required this.seller,
    this.username,
    this.sex,
    this.icon,
  });

  factory Profile.fromFirestore(Map<String, dynamic> firestoreDoc) {
    return Profile(
      uid: firestoreDoc['UID'],
      fName: firestoreDoc['fName'],
      lName: firestoreDoc['lName'],
      telno: firestoreDoc['telno'],
      seller: firestoreDoc['seller'],
      username: firestoreDoc['username'],
      sex: firestoreDoc['sex'],
      icon: firestoreDoc['icon'],
    );
  }
}
