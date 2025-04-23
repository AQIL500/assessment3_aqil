import 'package:assessment3/FAQs.dart';
import 'package:assessment3/profilepage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  bool _isPumpOn = false;

  final DatabaseReference _pumpRef = FirebaseDatabase.instance.ref("sensor_data/pump_status");
  final DatabaseReference _sensorRef = FirebaseDatabase.instance.ref("sensor_data");

  Map<String, dynamic> _sensorData = {
    'temperature': 'Loading...',
    'humidity': 'Loading...',
    'soilMoisture': 'Loading...',
    'light': 'Loading...'
  };

  // Define the blue ocean color palette
  final Color _primaryColor = const Color(0xFF1565C0);
  final Color _secondaryColor = const Color(0xFF64B5F6);
  final Color _accentColor = const Color(0xFF00ACC1);
  final Color _backgroundColor = const Color(0xFFE3F2FD);
  final Color _cardColor = const Color(0xFFBBDEFB);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.5, curve: Curves.easeIn),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.3, 1.0, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();
    _listenToPumpStatus();
    _listenToSensorData();
  }

  void _listenToPumpStatus() {
    _pumpRef.onValue.listen((event) {
      final value = event.snapshot.value;
      if (value != null && value is bool) {
        setState(() {
          _isPumpOn = value;
        });
      }
    });
  }

  void _listenToSensorData() {
    _sensorRef.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data != null && data is Map) {
        setState(() {
          _sensorData = Map<String, dynamic>.from(data);
        });
      }
    });
  }

  void _togglePump(bool value) async {
    try {
      await _pumpRef.set(value);
      setState(() {
        _isPumpOn = value;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Water Pump ${value ? 'ON' : 'OFF'}'),
          backgroundColor: value ? Colors.blue : Colors.blueGrey,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to control pump'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _backgroundColor,
      appBar: AppBar(
        title: const Text('Smart IoT Farming'),
        centerTitle: true,
        backgroundColor: _primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
            },
          ),
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => HelpPage()));
            },
          ),
        ],
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _fadeAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            ),
          );
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFE3F2FD),
                Color(0xFFBBDEFB),
              ],
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 6,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: _cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Image.network(
                            'https://smartfarm.nl/wp-content/uploads/2024/02/yoast-organisation-logo.jpg',
                            height: 100,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Welcome to Smart Farm',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: _primaryColor,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Real-time monitoring and control of your farming operations',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.blueGrey[800]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Farm Status Overview',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: _primaryColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  GridView.count(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    children: [
                      _buildStatusCard('Temperature', '${_sensorData['temperature']}°C', Icons.thermostat, _accentColor),
                      _buildStatusCard('Humidity', '${_sensorData['humidity']}%', Icons.water_drop, _secondaryColor),
                      _buildStatusCard('Soil Moisture', '${_sensorData['soil_moisture']}', Icons.grass, Colors.blue[700]!),
                      _buildStatusCard('Light Level', '${_sensorData['ldr']}', Icons.light_mode, Colors.blue[300]!),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    color: _cardColor,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            'Water Pump Control',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _primaryColor,
                            ),
                          ),
                          const SizedBox(height: 15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Icon(
                                    Icons.opacity,
                                    size: 40,
                                    color: _isPumpOn ? _accentColor : Colors.blueGrey,
                                  ),
                                  const SizedBox(height: 10),
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: 20,
                                    height: 20,
                                    decoration: BoxDecoration(
                                      color: _isPumpOn ? Colors.blue : Colors.blueGrey,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ],
                              ),
                              Switch.adaptive(
                                value: _isPumpOn,
                                onChanged: _togglePump,
                                activeColor: _accentColor,
                                activeTrackColor: _secondaryColor,
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Text(
                            _isPumpOn ? 'WATER PUMP ACTIVE' : 'WATER PUMP INACTIVE',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: _isPumpOn ? _accentColor : Colors.blueGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      // Bottom navigation bar has been removed
    );
  }

  Widget _buildStatusCard(String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      color: _cardColor,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: color),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(fontSize: 14, color: Colors.blueGrey[800])),
            const SizedBox(height: 4),
            Text(value, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _primaryColor)),
          ],
        ),
      ),
    );
  }
}