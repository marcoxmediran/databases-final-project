import 'package:databases_final_project/models/heir.dart';

class Relationship extends Heir {
  final int mid;
  final String heirRelationship;

  Relationship({
    required super.heirKey,
    required super.heirName,
    required super.heirDateOfBirth,
    required this.mid,
    required this.heirRelationship,
  });

  Map<String, dynamic> toMap() {
    return {
      'mid': mid,
      'heirKey': heirKey,
      'heirRelationship': heirRelationship,
    };
  }

  factory Relationship.fromMap(Map<String, dynamic> map) {
    return Relationship(
      heirKey: map['heirKey'] ?? '',
      heirName: map['heirName'] ?? '',
      heirDateOfBirth: map['heirDateOfBirth'] ?? '',
      mid: map['mid'] ?? '',
      heirRelationship: map['heirRelationship'] ?? '',
    );
  }

  @override
  String toString() {
    return '$mid - $heirKey, $heirName, $heirRelationship';
  }
}
