class Employer {
  final int employerKey;
  final String employerName;
  final String employerAddress;

  Employer({
    required this.employerKey,
    required this.employerName,
    required this.employerAddress,
  });

  Map<String, dynamic> toMap() {
    return {
      'employerName': employerName,
      'employerAddress': employerAddress,
    };
  }

  factory Employer.fromMap(Map<String, dynamic> map) {
    return Employer(
      employerKey: map['employerKey'] ?? '',
      employerName: map['employerName'] ?? '',
      employerAddress: map['employerAddress'] ?? '',
    );
  }

  @override
  String toString() {
    return '$employerKey: $employerName, $employerAddress';
  }
}
