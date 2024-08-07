import 'package:flutter/material.dart';

class Member {
  final int mid;
  final String occupationalStatus;
  final String membershipType;
  final String memberName;
  final String motherName;
  final String fatherName;
  final String spouseName;
  final String dateOfBirth;
  int age;
  final String placeOfBirth;
  final String sex;
  final String height;
  final String weight;
  final String maritalStatus;
  final String citizenship;
  final String frequencyOfPayment;
  final String tin;
  final String sss;
  final String permanentAddress;
  final String presentAddress;
  final String preferredAddress;
  final String cellphoneNumber;
  final String dateOfRegistration;

  Member({
    required this.mid,
    required this.occupationalStatus,
    required this.membershipType,
    required this.memberName,
    required this.motherName,
    required this.fatherName,
    required this.spouseName,
    required this.dateOfBirth,
    required this.placeOfBirth,
    required this.age,
    required this.sex,
    required this.height,
    required this.weight,
    required this.maritalStatus,
    required this.citizenship,
    required this.frequencyOfPayment,
    required this.tin,
    required this.sss,
    required this.permanentAddress,
    required this.presentAddress,
    required this.preferredAddress,
    required this.cellphoneNumber,
    required this.dateOfRegistration,
  });

  Map<String, dynamic> toMap() {
    return {
      'occupationalStatus': occupationalStatus,
      'membershipType': membershipType,
      'memberName': memberName,
      'motherName': motherName,
      'fatherName': fatherName,
      'spouseName': spouseName,
      'dateOfBirth': dateOfBirth,
      'placeOfBirth': placeOfBirth,
      'sex': sex,
      'height': height,
      'weight': weight,
      'maritalStatus': maritalStatus,
      'citizenship': citizenship,
      'frequencyOfPayment': frequencyOfPayment,
      'tin': tin,
      'sss': sss,
      'permanentAddress': permanentAddress,
      'presentAddress': presentAddress,
      'preferredAddress': preferredAddress,
      'cellphoneNumber': cellphoneNumber,
      'dateOfRegistration': dateOfRegistration,
    };
  }

  factory Member.fromMap(Map<String, dynamic> map) {
    return Member(
      mid: map['mid'] ?? '',
      occupationalStatus: map['occupationalStatus'] ?? '',
      membershipType: map['membershipType'] ?? '',
      memberName: map['memberName'] ?? '',
      motherName: map['motherName'] ?? '',
      fatherName: map['fatherName'] ?? '',
      spouseName: map['spouseName'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
      age: map['age'] ?? '',
      placeOfBirth: map['placeOfBirth'] ?? '',
      sex: map['sex'] ?? '',
      height: map['height'] ?? '',
      weight: map['weight'] ?? '',
      maritalStatus: map['maritalStatus'] ?? '',
      citizenship: map['citizenship'] ?? '',
      frequencyOfPayment: map['frequencyOfPayment'] ?? '',
      tin: map['tin'] ?? '',
      sss: map['sss'] ?? '',
      permanentAddress: map['permanentAddress'] ?? '',
      presentAddress: map['presentAddress'] ?? '',
      preferredAddress: map['preferredAddress'] ?? '',
      cellphoneNumber: map['cellphoneNumber'] ?? '',
      dateOfRegistration: map['dateOfRegistration'] ?? '',
    );
  }

  String formatMid() {
    var padded = mid.toString().padLeft(12, '0');
    var sub0 = padded.substring(0, 4);
    var sub1 = padded.substring(4, 8);
    var sub2 = padded.substring(8, 12);
    return '$sub0-$sub1-$sub2';
  }

  String getPrefferedAddress() {
    return preferredAddress == 'Present Address'
        ? presentAddress
        : permanentAddress;
  }

  String getSpouse() {
    return spouseName == '' ? 'None' : spouseName;
  }

  Icon generateIcon() {
    if (sex == 'Male') {
      return (age < 60) ? const Icon(Icons.face) : const Icon(Icons.face_6);
    } else {
      return (age < 60) ? const Icon(Icons.face_2) : const Icon(Icons.face_4);
    }
  }

  Icon generateIconWithSize(var size) {
    if (sex == 'Male') {
      return (age < 60)
          ? Icon(Icons.face, size: size)
          : Icon(Icons.face_6, size: size);
    } else {
      return (age < 60) ? Icon(Icons.face_2, size: size) : Icon(Icons.face_4, size: size);
    }
  }

  int getAge(String birthdate) {
    DateTime now = DateTime.now();
    return now.difference(DateTime.parse(birthdate)).inDays ~/ 365.25;
  }

  @override
  String toString() {
    return '$mid: $memberName';
  }
}
