import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab4/models/student_data.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ViewResumeScreen extends StatelessWidget {
  const ViewResumeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final studentData = Provider.of<StudentData>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('View Resume'),
      ),
      body: studentData.resumePath != null
          ? SfPdfViewer.file(File(studentData.resumePath!))
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.insert_drive_file, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No resume uploaded',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            ),
    );
  }
}