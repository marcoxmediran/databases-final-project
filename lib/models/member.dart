class Member {
  final String occupationalStatus;
  final String membershipType;
  final String memberName;
  final String motherName;
  final String fatherName;
  final String spouseName;
  final String dateOfBirth;
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
    required this.occupationalStatus,
    required this.membershipType,
    required this.memberName,
    required this.motherName,
    required this.fatherName,
    required this.spouseName,
    required this.dateOfBirth,
    required this.placeOfBirth,
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
      occupationalStatus: map['occupationalStatus'] ?? '',
      membershipType: map['membershipType'] ?? '',
      memberName: map['memberName'] ?? '',
      motherName: map['motherName'] ?? '',
      fatherName: map['fatherName'] ?? '',
      spouseName: map['spouseName'] ?? '',
      dateOfBirth: map['dateOfBirth'] ?? '',
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
}
