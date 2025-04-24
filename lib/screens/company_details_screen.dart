import 'package:flutter/material.dart';

class CompanyDetailsScreen extends StatelessWidget {
  const CompanyDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Company Details'),
      ),
      body: ListView(
        children: [
          _buildCompanyCard(
            'Company A',
            'Mumbai',
            '₹3L - ₹6L',
            'Software Developer',
            Icons.code,
          ),
          _buildCompanyCard(
            'Company B',
            'Bangalore',
            '₹4L - ₹8L',
            'Data Analyst',
            Icons.analytics,
          ),
          // Add more companies
        ],
      ),
    );
  }

  Widget _buildCompanyCard(String name, String location, String salary, String profile, IconData icon) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 40, color: Colors.blue),
                SizedBox(width: 10),
                Text(
                  name,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text('Location: $location', style: TextStyle(fontSize: 16)),
            Text('Salary Range: $salary', style: TextStyle(fontSize: 16)),
            Text('Profile: $profile', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}