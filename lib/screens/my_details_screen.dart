import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab4/models/student_data.dart';

class MyDetailsScreen extends StatelessWidget {
  const MyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentData = Provider.of<StudentData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Details', style: TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.white, Colors.blue.shade50],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (studentData.imagePath != null && studentData.imagePath!.isNotEmpty)
                  Center(
                    child: Hero(
                      tag: 'profile-image',
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(75),
                        child: Image.file(
                          File(studentData.imagePath!),
                          width: MediaQuery.of(context).size.width * 0.4,
                          height: MediaQuery.of(context).size.width * 0.4,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                SizedBox(height: 20),
                _buildDetailItem('Name', studentData.name),
                _buildDetailItem('Email', studentData.email),
                _buildDetailItem('Contact', studentData.contact),
                _buildDetailItem('Roll No', studentData.rollNo),
                SizedBox(height: 20),
                _buildSectionTitle('SSC Details'),
                _buildDetailItem('SSC College', studentData.sscCollege),
                _buildDetailItem('SSC Year', studentData.sscYear),
                _buildDetailItem('SSC Percentage', '${studentData.sscPercentage}%'),
                SizedBox(height: 20),
                _buildSectionTitle('HSC Details'),
                _buildDetailItem('HSC College', studentData.hscCollege),
                _buildDetailItem('HSC Year', studentData.hscYear),
                _buildDetailItem('HSC Percentage', '${studentData.hscPercentage}%'),
                SizedBox(height: 20),
                _buildSectionTitle('Graduation Details'),
                _buildDetailItem('Graduation College', studentData.gradCollege),
                _buildDetailItem('Graduation Year', studentData.gradYear),
                _buildDetailItem('Graduation Percentage', '${studentData.gradPercentage}%'),
                SizedBox(height: 20),
                _buildSectionTitle('Semester Marks'),
                _buildDetailItem('Semester 1', '${studentData.semesters['Sem 1']}'),
                _buildDetailItem('Semester 2', '${studentData.semesters['Sem 2']}'),
                _buildDetailItem('Semester 3', '${studentData.semesters['Sem 3']}'),
                _buildDetailItem('Semester 4', '${studentData.semesters['Sem 4']}'),
                _buildDetailItem('Semester 5', '${studentData.semesters['Sem 5']}'),
                SizedBox(height: 20),
                _buildDetailItem('Additional Courses', studentData.additionalCourses),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
      ),
    );
  }

  Widget _buildDetailItem(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$label: ', style: TextStyle(fontWeight: FontWeight.w600)),
          Expanded(child: Text(value ?? '-', style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}