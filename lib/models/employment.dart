import 'package:databases_final_project/models/employer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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

  String getSummary() {
    return isCurrentEmployment == 'Yes'
        ? 'Currently employed as ${isVowel(occupation) ? 'an' : 'a'} $occupation ($employmentStatus) at $employerName with a total monthly income of Php ${formatIncome()} on ${formatDateEmployed()}.'
        : 'Was previously employed as ${isVowel(occupation) ? 'an' : 'a'} $occupation ($employmentStatus) at $employerName with a total monthly income of Php ${formatIncome()} on ${formatDateEmployed()}.';
  }

  String formatDateEmployed() {
    return DateFormat.yMMMMd().format(DateTime.parse(dateEmployed));
  }

  String formatIncome() {
    return NumberFormat('###,###.0#', 'en_US')
        .format(int.parse(totalMonthlyIncome));
  }

  bool isVowel(String string) {
    var vowels = ['a', 'e', 'i', 'o', 'u'];
    return vowels.contains(string.toLowerCase().characters.first);
  }

  @override
  String toString() {
    return '$mid - $employerKey - $employerName: $isCurrentEmployment, $employmentStatus, $dateEmployed';
  }
}
