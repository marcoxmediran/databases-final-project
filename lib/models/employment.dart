import 'package:databases_final_project/models/employer.dart';

class Employment extends Employer {
  final int mid;
  final String isCurrentEmployment;
  final String occupation;
  final String employmentStatus;
  final String totalMonthlyIncome;
  final String dateEmployed;

  Employment({
    required super.employerKey,
    required super.employerName,
    required super.employerAddress,
    required this.mid,
    required this.isCurrentEmployment,
    required this.occupation,
    required this.employmentStatus,
    required this.totalMonthlyIncome,
    required this.dateEmployed,
  });

  Map<String, dynamic> toMap() {
    return {
      'employerKey': employerKey,
      'mid': mid,
      'isCurrentEmployment': isCurrentEmployment,
      'occupation': occupation,
      'employmentStatus': employmentStatus,
      'totalMonthlyIncome': totalMonthlyIncome,
      'dateEmployed': dateEmployed,
    };
  }

  factory Employment.fromMap(Map<String, dynamic> map) {
    return Employment(
      employerKey: map['employerKey'] ?? '',
      employerName: map['employerName'] ?? '',
      employerAddress: map['employerAddress'] ?? '',
      mid: map['mid'] ?? '',
      isCurrentEmployment: map['isCurrentEmployment'] ?? '',
      occupation: map['occupation'] ?? '',
      employmentStatus: map['employmentStatus'] ?? '',
      totalMonthlyIncome: map['totalMonthlyIncome'] ?? '',
      dateEmployed: map['dateEmployed'],
    );
  }

  @override
  String toString() {
    return '$mid - $employerKey - $employerName: $isCurrentEmployment, $employmentStatus, $dateEmployed';
  }
}
