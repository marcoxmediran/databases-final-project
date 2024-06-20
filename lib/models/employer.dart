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

  String formatKey() {
    var padded = employerKey.toString().padLeft(8, '0');
    var sub0 = padded.substring(0, 4);
    var sub1 = padded.substring(4, 8);
    return '$sub0-$sub1';
  }

  @override
  String toString() {
    return '$employerKey: $employerName, $employerAddress';
  }
}
