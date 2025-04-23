import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:assessment3/profilepage.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  State<AnalyticsPage> createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  int _currentIndex = 1;
  final List<double> temperatureData = [24.5, 25.0, 24.8, 25.2, 24.9];
  final List<double> humidityData = [60, 62, 58, 59, 61];
  final List<double> soilMoistureData = [40, 42, 38, 37, 39];
  final List<double> lightData = [300, 310, 305, 320, 315];

  void _onTabTapped(int index) {
    if (index == _currentIndex) return;
    final pages = [ ProfilePage()];
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => pages[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Analytics Dashboard",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        backgroundColor: const Color(0xFF1976D2), // Marine blue
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: const Color(0xFFF5F9FF), // Light blue background
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          const SizedBox(height: 8),
          _buildHeaderCard(),
          const SizedBox(height: 24),
          _buildGraphCard("Temperature (°C)", temperatureData, const Color(0xFFE53935)),
          const SizedBox(height: 20),
          _buildGraphCard("Humidity (%)", humidityData, const Color(0xFF1E88E5)),
          const SizedBox(height: 20),
          _buildGraphCard("Soil Moisture (%)", soilMoistureData, const Color(0xFF43A047)),
          const SizedBox(height: 20),
          _buildGraphCard("Light Level (lux)", lightData, const Color(0xFFFFB300)),
        ],
      ),
    );
  }

  Widget _buildHeaderCard() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.insights, color: Colors.blue.shade700, size: 24),
                const SizedBox(width: 8),
                Text(
                  "Sensor Analytics",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              "View real-time and historical data trends from your farm sensors",
              style: TextStyle(
                fontSize: 14,
                color: Colors.blueGrey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGraphCard(String title, List<double> values, Color color) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      shadowColor: Colors.blue.shade100,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getIconForTitle(title),
                    color: color,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 180,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: true,
                    horizontalInterval: _getInterval(values),
                    getDrawingHorizontalLine: (value) => FlLine(
                      color: Colors.grey.shade200,
                      strokeWidth: 1,
                    ),
                  ),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: 1,
                        reservedSize: 22,
                        getTitlesWidget: (value, meta) => Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            "Day ${value.toInt() + 1}",
                            style: TextStyle(
                              fontSize: 10,
                              color: Colors.blueGrey.shade600,
                            ),
                          ),
                        ),
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        interval: _getInterval(values),
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) => Text(
                          value.toInt().toString(),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.blueGrey.shade600,
                          ),
                        ),
                      ),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(
                    show: true,
                    border: Border.all(
                      color: Colors.grey.shade300,
                      width: 1,
                    ),
                  ),
                  minX: 0,
                  maxX: values.length.toDouble() - 1,
                  minY: _getMinY(values),
                  maxY: _getMaxY(values),
                  lineBarsData: [
                    LineChartBarData(
                      spots: List.generate(
                        values.length,
                            (index) => FlSpot(index.toDouble(), values[index]),
                      ),
                      isCurved: true,
                      color: color,
                      barWidth: 3,
                      belowBarData: BarAreaData(
                        show: true,
                        color: color.withOpacity(0.1),
                      ),
                      dotData: FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                              radius: 3,
                              color: color,
                              strokeWidth: 2,
                              strokeColor: Colors.white,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconForTitle(String title) {
    if (title.contains("Temp")) return Icons.thermostat;
    if (title.contains("Humidity")) return Icons.water_drop;
    if (title.contains("Soil")) return Icons.grass;
    if (title.contains("Light")) return Icons.wb_sunny;
    return Icons.show_chart;
  }

  double _getMinY(List<double> values) {
    final min = values.reduce((a, b) => a < b ? a : b);
    return min - (min * 0.1); // Add 10% padding below
  }

  double _getMaxY(List<double> values) {
    final max = values.reduce((a, b) => a > b ? a : b);
    return max + (max * 0.1); // Add 10% padding above
  }

  double _getInterval(List<double> values) {
    final range = _getMaxY(values) - _getMinY(values);
    if (range <= 10) return 2;
    if (range <= 20) return 5;
    return 10;
  }
}