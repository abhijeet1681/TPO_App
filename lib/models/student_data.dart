import 'package:flutter/foundation.dart';
class StudentData with ChangeNotifier {
  String? name;
  String? email;
  String? contact;
  String? rollNo;
  String? sscCollege;
  String? sscYear;
  double? sscObtainedMarks;
  double? sscTotalMarks;
  double? sscPercentage;
  String? hscCollege;
  String? hscYear;
  double? hscObtainedMarks;
  double? hscTotalMarks;
  double? hscPercentage;
  String? gradCollege;
  String? gradYear;
  Map<String, double> semesters = {};
  double? gradCGPA;
  double? gradPercentage;
  String? additionalCourses;
  String? resumePath;
  String? imagePath;

  void updateStudentData({
    required String name,
    required String email,
    required String contact,
    required String rollNo,
    required String sscCollege,
    required String sscYear,
    required double sscObtainedMarks,
    required double sscTotalMarks,
    required double sscPercentage,
    required String hscCollege,
    required String hscYear,
    required double hscObtainedMarks,
    required double hscTotalMarks,
    required double hscPercentage,
    required String gradCollege,
    required String gradYear,
    required Map<String, double> semesters,
    required double gradCGPA,
    required double gradPercentage,
    required String additionalCourses,
    required String resumePath,
    required String imagePath,
  }) {
    this.name = name;
    this.email = email;
    this.contact = contact;
    this.rollNo = rollNo;
    this.sscCollege = sscCollege;
    this.sscYear = sscYear;
    this.sscObtainedMarks = sscObtainedMarks;
    this.sscTotalMarks = sscTotalMarks;
    this.sscPercentage = sscPercentage;
    this.hscCollege = hscCollege;
    this.hscYear = hscYear;
    this.hscObtainedMarks = hscObtainedMarks;
    this.hscTotalMarks = hscTotalMarks;
    this.hscPercentage = hscPercentage;
    this.gradCollege = gradCollege;
    this.gradYear = gradYear;
    this.semesters = semesters;
    this.gradCGPA = gradCGPA;
    this.gradPercentage = gradPercentage;
    this.additionalCourses = additionalCourses;
    this.resumePath = resumePath;
    this.imagePath = imagePath;
    notifyListeners(); // Notify listeners after updating data
  }
}