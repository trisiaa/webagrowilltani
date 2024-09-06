import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:webagro/utils/responsiveLayout.dart';
import 'package:webagro/widgets/custom_appbar.dart';

class Grafik extends StatefulWidget {
  @override
  _GrafikState createState() => _GrafikState();
}

class _GrafikState extends State<Grafik> {
  String? selectedGreenhouse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ResponsiveLayout(
        largeScreen: _buildContent(2), // 2 kolom untuk layar besar
        smallScreen: _buildContent(1), // 1 kolom untuk layar kecil
      ),
    );
  }

  Widget _buildContent(int crossAxisCount) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: SizedBox(),
                  hint: Text(
                    "Pilih Greenhouse ~",
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                  value: selectedGreenhouse,
                  items: <String>['Greenhouse 1', 'Greenhouse 2']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          Icon(
                            Icons.eco,
                            color: Colors.green,
                          ),
                          SizedBox(width: 8),
                          Text(
                            value,
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (newValue) {
                    setState(() {
                      selectedGreenhouse = newValue;
                    });
                  },
                  icon: Icon(Icons.arrow_drop_down, color: Colors.green),
                ),
              ),
            ),
          ),
          if (selectedGreenhouse != null)
            Container(
              height: MediaQuery.of(context).size.height - 150, // Adjust height as needed
              child: GridView.count(
                crossAxisCount: crossAxisCount,
                children: [
                  _buildGraphCard('Grafik Suhu', LineChart(sampleData1())),
                  _buildGraphCard('Grafik Kelembaban', LineChart(sampleData2())),
                  _buildGraphCard('Grafik Debit Air', LineChart(sampleData3())),
                  _buildGraphCard('Grafik TDS', LineChart(sampleData4())),
                ],
              ),
            ),
          if (selectedGreenhouse == null)
            Center(
              child: Text('Silakan pilih Greenhouse untuk melihat grafik.'),
            ),
        ],
      ),
    );
  }

  Widget _buildGraphCard(String title, Widget graph) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: graph,
            ),
          ),
        ],
      ),
    );
  }

  LineChartData sampleData1() {
    return LineChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(show: true),
      borderData: FlBorderData(show: true),
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 3),
            FlSpot(2, 5),
            FlSpot(4, 4),
            FlSpot(6, 7),
            FlSpot(8, 6),
            FlSpot(10, 8),
          ],
          isCurved: true,
          color: Colors.blue,
          barWidth: 2,
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }

  LineChartData sampleData2() {
    return LineChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(show: true),
      borderData: FlBorderData(show: true),
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 2),
            FlSpot(2, 3),
            FlSpot(4, 5),
            FlSpot(6, 4),
            FlSpot(8, 7),
            FlSpot(10, 6),
          ],
          isCurved: true,
          color: Colors.green,
          barWidth: 2,
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }

  LineChartData sampleData3() {
    return LineChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(show: true),
      borderData: FlBorderData(show: true),
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 5),
            FlSpot(2, 6),
            FlSpot(4, 3),
            FlSpot(6, 7),
            FlSpot(8, 4),
            FlSpot(10, 8),
          ],
          isCurved: true,
          color: Colors.red,
          barWidth: 2,
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }

  LineChartData sampleData4() {
    return LineChartData(
      gridData: FlGridData(show: true),
      titlesData: FlTitlesData(show: true),
      borderData: FlBorderData(show: true),
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: 10,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 4),
            FlSpot(2, 5),
            FlSpot(4, 7),
            FlSpot(6, 6),
            FlSpot(8, 9),
            FlSpot(10, 8),
          ],
          isCurved: true,
          color: Colors.purple,
          barWidth: 2,
          belowBarData: BarAreaData(show: false),
        ),
      ],
    );
  }
}