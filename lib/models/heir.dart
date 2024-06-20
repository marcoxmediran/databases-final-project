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

  String formatKey() {
    var padded = heirKey.toString().padLeft(8, '0');
    var sub0 = padded.substring(0, 4);
    var sub1 = padded.substring(4, 8);
    return '$sub0-$sub1';
  }

  @override
  String toString() {
    return '$heirKey: $heirName, $heirDateOfBirth';
  }
}
