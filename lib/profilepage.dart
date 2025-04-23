import 'package:assessment3/FAQs.dart';
import 'package:assessment3/academic.dart';
import 'package:assessment3/dashboard.dart';
import 'package:assessment3/loginpage.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE0F7FA), // Light sea blue background
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        backgroundColor: const Color(0xFF0288D1), // Sea blue
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              Container(
                child: ClipOval(
                  child: Image.asset(
                    'assets/1.jpg',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Icon(
                      Icons.person,
                      size: 80,
                      color: Colors.blueGrey[200],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'AQIL ABQHORI BIN HASANI',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0288D1), // Sea blue
                ),
              ),
              const SizedBox(height: 8),
              Divider(thickness: 1, color: Colors.cyan[300]),
              const SizedBox(height: 20),

              _buildInfoTile('Class', '4B'),
              _buildInfoTile('Age', '20'),
              _buildInfoTile('Education', 'Diploma in Electronic Engineering (IoT)'),
              const SizedBox(height: 30),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Background Summary',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF00796B), // Sea green for title
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'I am a passionate student currently pursuing a Diploma in Electronic Engineering with a specialization in IoT at Kolej Kemahiran Tinggi MARA Petaling Jaya. I have experience working with sensors, ESP32,and Firebase. My final year project involves developing a Solar Powered Classroom.',
                style: TextStyle(fontSize: 16, color: Colors.blueGrey[800]),
                textAlign: TextAlign.justify,
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00ACC1), // Lighter sea blue
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'Help & Support',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReferencesPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF006064), // Deep teal
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'Academic Integrity',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AnalyticsPage()));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF4DD0E1), // Turquoise
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                  minimumSize: Size(double.infinity, 50),
                ),
                child: Text(
                  'Dashboard',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(Icons.info_outline, color: Color(0xFF00ACC1), size: 20),
          const SizedBox(width: 10),
          Text(
            '$title: ',
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 16),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
