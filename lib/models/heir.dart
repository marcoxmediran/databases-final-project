class Heir {
  final int heirKey;
  final String heirName;
  final String heirDateOfBirth;

  Heir({
    required this.heirKey,
    required this.heirName,
    required this.heirDateOfBirth,
  });

  Map<String, dynamic> toMap() {
    return {
      'heirName': heirName,
      'heirDateOfBirth': heirDateOfBirth,
    };
  }

  factory Heir.fromMap(Map<String, dynamic> map) {
    return Heir(
      heirKey: map['heirKey'] ?? '',
      heirName: map['heirName'] ?? '',
      heirDateOfBirth: map['heirDateOfBirth'] ?? '',
    );
  }

  @override
  String toString() {
    return '$heirKey: $heirName, $heirDateOfBirth';
  }
}
