class Heir {
  final String heirName;
  final String heirDateOfBirth;

  Heir({
    required this.heirName,
    required this.heirDateOfBirth,
  });

  Map<String, dynamic> toMap() {
    return {
      'heir_name': heirName,
      'heir_date_of_birth': heirDateOfBirth,
    };
  }

  factory Heir.fromMap(Map<String, dynamic> map) {
    return Heir(
      heirName: map['heirName'] ?? '',
      heirDateOfBirth: map['heirDateOfBirth'] ?? '',
    );
  }
}
