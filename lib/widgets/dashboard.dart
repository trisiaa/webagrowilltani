import 'package:flutter/material.dart';
import 'package:webagro/widgets/custom_appbar.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String selectedGreenhouse = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown untuk pemilihan Greenhouse
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                    items: <String>['Greenhouse 1', 'Greenhouse 2'].map((String value) {
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
            // Render berdasarkan pilihan Greenhouse
            if (selectedGreenhouse.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Center(
                  child: Text(
                    'Silakan pilih Greenhouse untuk melihat Kontrol.',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ),
              )
            else
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 600) {
                      // Tata letak horizontal untuk layar besar
                      return Row(
                        children: [
                          Expanded(
                            flex: 4,
                            child: GridView.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8.0,
                              crossAxisSpacing: 8.0,
                              childAspectRatio: 1.3,
                              children: [
                                _buildInfoTile(Icons.thermostat, '0°C', 'SUHU'),
                                _buildInfoTile(Icons.wb_sunny_outlined, 'TIDAK', 'INT CAHAYA'),
                                _buildInfoTile(Icons.water_damage, '0%', 'KELEMBABAN'),
                                _buildInfoTile(Icons.water_outlined, '0L', 'DEBIT AIR'),
                                _buildInfoTile(Icons.grain, '0', 'TDS'),
                                _buildInfoTile(Icons.waves, '0', 'VOLUME'),
                              ],
                            ),
                          ),
                          SizedBox(width: 16.0), // Jarak antara kolom kiri dan kanan
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: _buildGridItem('NOTIFIKASI', Icons.notifications, Color(0xFFF7F4FD), notificationCount: 1),
                                ),
                                SizedBox(height: 16.0),
                                Expanded(
                                  flex: 1,
                                  child: _buildGridItem('IMAGE GREENHOUSE', Icons.image, Color(0xFFF7F4FD)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    } else {
                      // Tata letak vertikal untuk layar kecil
                      return Column(
                        children: [
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: _buildGridItem('NOTIFIKASI', Icons.notifications, Color(0xFFF7F4FD), notificationCount: 1),
                                ),
                                SizedBox(height: 16.0),
                                Expanded(
                                  flex: 1,
                                  child: _buildGridItem('IMAGE GREENHOUSE', Icons.image, Color(0xFFF7F4FD)),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 16.0), // Jarak antara bagian notifikasi/gambar dan suhu
                          Expanded(
                            flex: 4,
                            child: GridView.count(
                              crossAxisCount: 2,
                              mainAxisSpacing: 8.0,
                              crossAxisSpacing: 8.0,
                              childAspectRatio: 1.3,
                              children: [
                                _buildInfoTile(Icons.thermostat, '0°C', 'SUHU'),
                                _buildInfoTile(Icons.wb_sunny_outlined, 'TIDAK', 'INT CAHAYA'),
                                _buildInfoTile(Icons.water_damage, '0%', 'KELEMBABAN'),
                                _buildInfoTile(Icons.water_outlined, '0L', 'DEBIT AIR'),
                                _buildInfoTile(Icons.grain, '0', 'TDS'),
                                _buildInfoTile(Icons.waves, '0', 'VOLUME'),
                              ],
                            ),
                          ),
                        ],
                      );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(IconData icon, String value, String label) {
    return Card(
      color: Color(0xFFF7F4FD), // Warna latar belakang ungu terang
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Sudut yang membulat
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40.0, color: Colors.black), // Warna ikon hitam
            SizedBox(height: 8.0),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                color: Colors.black, // Warna teks hitam untuk nilai
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black, // Warna teks hitam untuk label
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGridItem(String title, IconData icon, Color color, {int notificationCount = 0}) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0), // Sudut yang membulat
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black, // Warna teks hitam untuk judul
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Icon(icon, size: 30.0, color: Colors.black), // Warna ikon hitam
                    if (notificationCount > 0)
                      Positioned(
                        right: 0,
                        top: 0,
                        child: CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.red,
                          child: Text(
                            '$notificationCount',
                            style: TextStyle(color: Colors.white, fontSize: 12),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16.0),
            Text(
              'Subtitle', // Tambahkan subtitle jika diperlukan
              style: TextStyle(
                fontSize: 16,
                color: Colors.black, // Warna teks hitam untuk subtitle
              ),
            ),
          ],
        ),
      ),
    );
  }
}
