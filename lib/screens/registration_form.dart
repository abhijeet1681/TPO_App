import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:lab4/models/student_data.dart';
import 'package:lab4/screens/my_details_screen.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  String? _resumePath;
  String? _imagePath;

  // Controllers for form fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();
  final TextEditingController _rollNoController = TextEditingController();
  final TextEditingController _sscCollegeController = TextEditingController();
  final TextEditingController _sscYearController = TextEditingController();
  final TextEditingController _sscObtainedMarksController = TextEditingController();
  final TextEditingController _sscTotalMarksController = TextEditingController();
  double sscPercentage = 0.00;
  double hscPercentage = 0.00;
  final TextEditingController _hscCollegeController = TextEditingController();
  final TextEditingController _hscYearController = TextEditingController();
  final TextEditingController _hscObtainedMarksController = TextEditingController();
  final TextEditingController _hscTotalMarksController = TextEditingController();
  final TextEditingController _gradCollegeController = TextEditingController();
  final TextEditingController _gradYearController = TextEditingController();
  final TextEditingController _sem1Controller = TextEditingController();
  final TextEditingController _sem2Controller = TextEditingController();
  final TextEditingController _sem3Controller = TextEditingController();
  final TextEditingController _sem4Controller = TextEditingController();
  final TextEditingController _sem5Controller = TextEditingController();
  final TextEditingController _additionalCoursesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Form'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Personal Details Section
              _buildSectionCard(
                'Personal Details',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRow('Name', 'Enter your name', _nameController),
                    _buildRow('Email', 'Enter your email', _emailController),
                    _buildRow('Contact', 'Enter your contact number', _contactController),
                    _buildRow('Roll No', 'Enter your roll number', _rollNoController),
                  ],
                ),
              ),

              // SSC Details Section
              _buildSectionCard(
                'SSC Details',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRow('SSC College', 'Enter SSC college name', _sscCollegeController),
                    _buildRow('SSC Year', 'Enter SSC year of passing', _sscYearController),
                    _buildRow('SSC Obtained Marks', 'Enter SSC obtained marks', _sscObtainedMarksController),
                    _buildRow('SSC Total Marks', 'Enter SSC total marks', _sscTotalMarksController),
                    SizedBox(height: 10),
                    _buildPercentageBox('SSC Percentage', sscPercentage),
                  ],
                ),
              ),

              // HSC Details Section
              _buildSectionCard(
                'HSC Details',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRow('HSC College', 'Enter HSC college name', _hscCollegeController),
                    _buildRow('HSC Year', 'Enter HSC year of passing', _hscYearController),
                    _buildRow('HSC Obtained Marks', 'Enter HSC obtained marks', _hscObtainedMarksController),
                    _buildRow('HSC Total Marks', 'Enter HSC total marks', _hscTotalMarksController),
                    SizedBox(height: 10),
                    _buildPercentageBox('HSC Percentage', hscPercentage),
                  ],
                ),
              ),

              // Graduation Details Section
              _buildSectionCard(
                'Graduation Details',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRow('Graduation College', 'Enter Graduation college name', _gradCollegeController),
                    _buildRow('Graduation Year', 'Enter Graduation year of passing', _gradYearController),
                    _buildRow('Semester 1 CGPA', 'Enter Semester 1 CGPA', _sem1Controller),
                    _buildRow('Semester 2 CGPA', 'Enter Semester 2 CGPA', _sem2Controller),
                    _buildRow('Semester 3 CGPA', 'Enter Semester 3 CGPA', _sem3Controller),
                    _buildRow('Semester 4 CGPA', 'Enter Semester 4 CGPA', _sem4Controller),
                    _buildRow('Semester 5 CGPA', 'Enter Semester 5 CGPA', _sem5Controller),
                    SizedBox(height: 10),
                    _buildPercentageBox('Overall CGPA', _calculateOverallCGPA()),
                    _buildPercentageBox('Overall Percentage', _calculateOverallPercentage()),
                  ],
                ),
              ),

              // Additional Courses Section
              _buildSectionCard(
                'Additional Courses',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildRow('Courses', 'Enter additional courses', _additionalCoursesController),
                  ],
                ),
              ),

              // Documents Section
              _buildSectionCard(
                'Documents',
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ElevatedButton(
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles(
                          type: FileType.image,
                        );
                        if (result != null) {
                          setState(() {
                            _imagePath = result.files.single.path;
                          });
                        }
                      },
                      child: Text('Upload Photo'),
                    ),
                    if (_imagePath != null)
                      Text('Photo Path: $_imagePath'),
                    SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () async {
                        FilePickerResult? result = await FilePicker.platform.pickFiles();
                        if (result != null) {
                          setState(() {
                            _resumePath = result.files.single.path;
                          });
                        }
                      },
                      child: Text('Upload Resume'),
                    ),
                    if (_resumePath != null)
                      Text('Resume Path: $_resumePath'),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Submit Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    double gradCGPA = _calculateOverallCGPA();
                    double gradPercentage = _calculateOverallPercentage();

                    Provider.of<StudentData>(context, listen: false).updateStudentData(
                      name: _nameController.text,
                      email: _emailController.text,
                      contact: _contactController.text,
                      rollNo: _rollNoController.text,
                      sscCollege: _sscCollegeController.text,
                      sscYear: _sscYearController.text,
                      sscObtainedMarks: double.parse(_sscObtainedMarksController.text),
                      sscTotalMarks: double.parse(_sscTotalMarksController.text),
                      sscPercentage: sscPercentage,
                      hscCollege: _hscCollegeController.text,
                      hscYear: _hscYearController.text,
                      hscObtainedMarks: double.parse(_hscObtainedMarksController.text),
                      hscTotalMarks: double.parse(_hscTotalMarksController.text),
                      hscPercentage: hscPercentage,
                      gradCollege: _gradCollegeController.text,
                      gradYear: _gradYearController.text,
                      semesters: {
                        'Sem 1': double.parse(_sem1Controller.text),
                        'Sem 2': double.parse(_sem2Controller.text),
                        'Sem 3': double.parse(_sem3Controller.text),
                        'Sem 4': double.parse(_sem4Controller.text),
                        'Sem 5': double.parse(_sem5Controller.text),
                      },
                      gradCGPA: gradCGPA,
                      gradPercentage: gradPercentage,
                      additionalCourses: _additionalCoursesController.text,
                      resumePath: _resumePath ?? '',
                      imagePath: _imagePath ?? '',
                    );

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Registration Successful')),
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyDetailsScreen()),
                    );
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard(String title, Widget content) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            content,
          ],
        ),
      ),
    );
  }

  Widget _buildPercentageBox(String label, double value) {
    return Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.blue.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade200),
      ),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Text(
            '${value.toStringAsFixed(2)}%',
            style: TextStyle(fontSize: 16, color: Colors.blue.shade800),
          ),
        ],
      ),
    );
  }

  _calculatePercentageSSC(String obtained, String total) {
    if (obtained.isEmpty || total.isEmpty) return 0.0;
    double obtainedMarks = double.parse(obtained);
    double totalMarks = double.parse(total);
    sscPercentage = (obtainedMarks / totalMarks) * 100;
  }

  _calculatePercentageHSC(String obtained, String total) {
    if (obtained.isEmpty || total.isEmpty) return 0.0;
    double obtainedMarks = double.parse(obtained);
    double totalMarks = double.parse(total);
    hscPercentage = (obtainedMarks / totalMarks) * 100;
  }

  double _calculateOverallCGPA() {
    double sem1 = double.tryParse(_sem1Controller.text) ?? 0.0;
    double sem2 = double.tryParse(_sem2Controller.text) ?? 0.0;
    double sem3 = double.tryParse(_sem3Controller.text) ?? 0.0;
    double sem4 = double.tryParse(_sem4Controller.text) ?? 0.0;
    double sem5 = double.tryParse(_sem5Controller.text) ?? 0.0;
    return (sem1 + sem2 + sem3 + sem4 + sem5) / 5;
  }

  double _calculateOverallPercentage() {
    return _calculateOverallCGPA() * 9.5;
  }

  Widget _buildRow(String label, String placeholder, TextEditingController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 3,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: placeholder,
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter $label';
                }
                return null;
              },
              onChanged: (value) {
                if (label == 'SSC Total Marks') {
                  setState(() {
                    _calculatePercentageSSC(_sscObtainedMarksController.text, _sscTotalMarksController.text);
                  });
                } else if (label == 'HSC Total Marks') {
                  setState(() {
                    _calculatePercentageHSC(_hscObtainedMarksController.text, _hscTotalMarksController.text);
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}