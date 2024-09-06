import 'package:flutter/material.dart';
import 'package:webagro/widgets/custom_appbar.dart';
import 'package:webagro/utils/responsiveLayout.dart';
import 'package:webagro/widgets/edit_settings.dart';

class Kontrol extends StatefulWidget {
  @override
  _KontrolState createState() => _KontrolState();
}

class _KontrolState extends State<Kontrol> {
  bool isManualMode = false; // Status saklar manual
  bool isAutomaticMode = false; // Status saklar otomatis

  String selectedGreenhouse = ''; // Variabel untuk menyimpan pilihan greenhouse

  // Variabel yang akan menyimpan nilai setting
  String suhuMinimal = '0';
  String suhuMaximal = '0';
  String tdsMinimal = '0';
  String tdsMaximal = '0';
  String kelembabanMinimal = '0';
  String kelembabanMaximal = '0';
  String volumeAirMinimal = '0';
  String volumeAirMaximal = '0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: ResponsiveLayout(
        largeScreen: _buildContent(4), // 4 kolom untuk layar besar
        smallScreen: _buildContent(2), // 2 kolom untuk layar kecil
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
                  value: selectedGreenhouse.isNotEmpty ? selectedGreenhouse : null,
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
                      selectedGreenhouse = newValue!;
                    });
                  },
                  icon: Icon(Icons.arrow_drop_down, color: Colors.green),
                ),
              ),
            ),
          ),
          if (selectedGreenhouse.isEmpty) 
            Center(
              child: Text('Silakan pilih Greenhouse untuk melihat Kontrol.'),
            ),
          if (selectedGreenhouse.isNotEmpty) ...[
            // Konten lainnya hanya ditampilkan jika greenhouse sudah dipilih
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                'https://via.placeholder.com/300x150',
                height: 150,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 16),
                Switch(
                  value: isAutomaticMode,
                  onChanged: (value) {
                    setState(() {
                      isAutomaticMode = value;
                      if (value) {
                        isManualMode = false;
                      }
                    });
                  },
                ),
                Text('Mode Otomatis'),
                SizedBox(width: 16),
                Switch(
                  value: isManualMode,
                  onChanged: (value) {
                    setState(() {
                      isManualMode = value;
                      if (value) {
                        isAutomaticMode = false;
                      }
                    });
                  },
                ),
                Text('Saklar Manual'),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(
                shrinkWrap: true,
                crossAxisCount: crossAxisCount,
                childAspectRatio: 1.0,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildInfoTile(Icons.thermostat, '0°C', 'SUHU'),
                  _buildInfoTile(Icons.wb_sunny_outlined, 'TIDAK', 'INT CAHAYA'),
                  _buildInfoTile(Icons.water_damage, '0%', 'KELEMBABAN'),
                  _buildInfoTile(Icons.water_outlined, '0L', 'DEBIT AIR'),
                ],
              ),
            ),
            // Kotak untuk pengaturan
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'SETTING',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          IconButton(
                            onPressed: () async {
                              final result = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => EditSettings(
                                    suhuMinimal: suhuMinimal,
                                    suhuMaximal: suhuMaximal,
                                    tdsMinimal: tdsMinimal,
                                    tdsMaximal: tdsMaximal,
                                    kelembabanMinimal: kelembabanMinimal,
                                    kelembabanMaximal: kelembabanMaximal,
                                    volumeAirMinimal: volumeAirMinimal,
                                    volumeAirMaximal: volumeAirMaximal,
                                  ),
                                ),
                              );

                              if (result != null) {
                                setState(() {
                                  suhuMinimal = result['suhuMinimal'];
                                  suhuMaximal = result['suhuMaximal'];
                                  tdsMinimal = result['tdsMinimal'];
                                  tdsMaximal = result['tdsMaximal'];
                                  kelembabanMinimal = result['kelembabanMinimal'];
                                  kelembabanMaximal = result['kelembabanMaximal'];
                                  volumeAirMinimal = result['volumeAirMinimal'];
                                  volumeAirMaximal = result['volumeAirMaximal'];
                                });
                              }
                            },
                            icon: Icon(Icons.settings),
                            tooltip: "Edit",
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      _buildSettingItem('Suhu Minimal', suhuMinimal),
                      _buildSettingItem('Suhu Maximal', suhuMaximal),
                      _buildSettingItem('TDS Minimal', tdsMinimal),
                      _buildSettingItem('TDS Maximal', tdsMaximal),
                      _buildSettingItem('Kelembaban Minimal', kelembabanMinimal),
                      _buildSettingItem('Kelembaban Maximal', kelembabanMaximal),
                      _buildSettingItem('Volume Air Minimal', volumeAirMinimal),
                      _buildSettingItem('Volume Air Maximal', volumeAirMaximal),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String value, String label) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.all(8),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          Text(
            value,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(label),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}