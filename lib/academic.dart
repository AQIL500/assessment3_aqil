import 'package:flutter/material.dart';

class ReferencesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor References',
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color(0xFF0077B6), // Ocean blue
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF0077B6), // Deep ocean blue
              Color(0xFF90E0EF), // Light ocean blue
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 16),
              const Text(
                'Device References',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Components used in our system',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  children: [
                    // DHT22 Sensor
                    _buildSensorCard(
                      context,
                      'DHT22 - Digital Humidity and Temperature Sensor',
                      'Measures temperature (range: -40°C to 80°C) and humidity (0-100% RH) with ±0.5°C accuracy.',
                      'https://m.media-amazon.com/images/I/51J9ha5fZKL.jpg',
                      const Color(0xFF00B4D8),
                    ),

                    // LDR Sensor
                    _buildSensorCard(
                      context,
                      'LDR - Light Dependent Resistor',
                      'Detects light intensity with resistance varying from 1MΩ (dark) to a few kΩ (bright light).',
                      'https://makerselectronics.com/wp-content/uploads/2017/06/4PinsLDRLightSensorModule_1.webp',
                      const Color(0xFF0096C7),
                    ),

                    // ESP32 Microcontroller
                    _buildSensorCard(
                      context,
                      'ESP32 - Microcontroller',
                      'Dual-core processor with WiFi/Bluetooth, 520KB SRAM, 4MB flash, operating at 160MHz.',
                      'https://m.media-amazon.com/images/I/61Zh+qTifeL.jpg',
                      const Color(0xFF0077B6),
                    ),

                    // Soil Moisture Sensor
                    _buildSensorCard(
                      context,
                      'Soil Moisture Sensor',
                      'Measures volumetric water content with analog output (0-4.2V) for 0-100% moisture range.',
                      'https://my.sz-kuongshun.com/uploads/201810680/capacitive-analog-soil-moisture-sensor-3-3-509190219829.png',
                      const Color(0xFF00B4D8),
                    ),

                    // Relay
                    _buildSensorCard(
                      context,
                      '5V Relay Module',
                      '10A 250V AC / 10A 30V DC switching capability with opto-isolation for safety.',
                      'https://static.cytron.io/image/cache/catalog/products/BB-RELAY-5V-02/BB-RELAY-5V-02-268x268.png',
                      const Color(0xFF0096C7),
                    ),

                    // Water Pump
                    _buildSensorCard(
                      context,
                      'Mini Water Pump',
                      '3-6V DC motor pump with 120L/H flow rate, perfect for small irrigation systems.',
                      'https://my-test-11.slatic.net/p/72b4fed0623b2c8450fa51a4b4226c9d.jpg',
                      const Color(0xFF0077B6),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSensorCard(BuildContext context, String title, String description, String imageUrl, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[100],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        imageUrl,
                        fit: BoxFit.contain,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, color: Colors.grey),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: color,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          description,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(
                height: 2,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [color.withOpacity(0.3), color, color.withOpacity(0.3)],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}