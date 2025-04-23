import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Farming Help',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HelpPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HelpPage extends StatelessWidget {
  final Uri _emailUri = Uri(
    scheme: 'mailto',
    path: 'aqilqhori8@gmail.com',
    query: 'subject=Support Needed for Smart Farming App',
  );

  final Uri _phoneUri = Uri(scheme: 'tel', path: '+601163784290');
  final Uri _videoUri = Uri.parse('https://youtu.be/example1');

  final Color primaryColor = const Color(0xFF1565C0);
  final Color accentColor = const Color(0xFF4FC3F7);
  final Color backgroundColor = const Color(0xFFE1F5FE);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        centerTitle: true,
        backgroundColor: primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: backgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 30),
            _buildSectionTitle('Frequently Asked Questions'),
            const SizedBox(height: 15),
            _buildFAQCard(context, 'How do I connect the app to the ESP32?',
                'Ensure your ESP32 is connected to the internet and Firebase. The app will sync data automatically.'),
            _buildFAQCard(context, 'What sensors are compatible with this app?',
                'This app supports DHT22, soil moisture sensors, LDR, and MQ135.'),
            _buildFAQCard(context, 'Can I manually control the irrigation system?',
                'Yes. Switch to Manual Mode in the dashboard to control the pump manually.'),
            _buildFAQCard(context, 'Why am I not receiving updates from the farm?',
                'Check your internet connection and ensure the ESP32 is powered and connected.'),
            const SizedBox(height: 30),
            _buildSectionTitle('Contact Support'),
            const SizedBox(height: 15),
            _buildContactOption(
              context,
              icon: Icons.email,
              title: 'Email Support',
              subtitle: 'aqilqhori8@gmail.com',
              onTap: () => _launchEmail(context),
            ),
            _buildContactOption(
              context,
              icon: Icons.phone,
              title: 'Call Support',
              subtitle: '+601163784290',
              onTap: () => _launchPhone(context),
            ),
            const SizedBox(height: 30),
            _buildSectionTitle('Video Tutorials'),
            const SizedBox(height: 15),
            _buildVideoSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor.withOpacity(0.8), accentColor],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.help_outline, size: 40, color: Colors.white),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Need Help?',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                const SizedBox(height: 5),
                Text(
                  'Find answers to common questions or contact our support team',
                  style: TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.9)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: primaryColor),
      ),
    );
  }

  Widget _buildFAQCard(BuildContext context, String question, String answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20),
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: Text(answer, style: TextStyle(color: Colors.blueGrey[700], fontSize: 14)),
          ),
        ],
      ),
    );
  }

  Widget _buildContactOption(BuildContext context,
      {required IconData icon, required String title, required String subtitle, required VoidCallback onTap}) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(color: accentColor.withOpacity(0.2), shape: BoxShape.circle),
                child: Icon(icon, color: primaryColor),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
                    const SizedBox(height: 4),
                    Text(subtitle, style: TextStyle(color: Colors.blueGrey[600], fontSize: 14)),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: primaryColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVideoSection(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Container(
              height: 180,
              color: primaryColor.withOpacity(0.1),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(color: primaryColor.withOpacity(0.2), shape: BoxShape.circle),
                      child: Icon(Icons.play_circle_filled, size: 50, color: primaryColor),
                    ),
                    const SizedBox(height: 10),
                    Text('Getting Started Guide',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor)),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_videoUri.toString(), style: TextStyle(color: Colors.blueGrey[600], fontSize: 14)),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.play_circle_outline),
                    label: const Text('Watch Tutorial'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () => _launchVideo(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchEmail(BuildContext context) async {
    try {
      if (!await canLaunchUrl(_emailUri)) {
        await launchUrl(_emailUri);
      } else {
        _showError(context, 'Could not open email app');
      }
    } catch (e) {
      _showError(context, 'Error launching email: $e');
    }
  }

  Future<void> _launchPhone(BuildContext context) async {
    try {
      if (!await canLaunchUrl(_phoneUri)) {
        await launchUrl(_phoneUri);
      } else {
        _showError(context, 'Could not launch phone dialer');
      }
    } catch (e) {
      _showError(context, 'Error launching phone: $e');
    }
  }

  Future<void> _launchVideo(BuildContext context) async {
    try {
      if (!await canLaunchUrl(_videoUri)) {
        await launchUrl(_videoUri, mode: LaunchMode.externalApplication);
      } else {
        _showError(context, 'Could not open YouTube');
      }
    } catch (e) {
      _showError(context, 'Error launching video: $e');
    }
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red[400],
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
