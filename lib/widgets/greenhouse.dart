import 'package:flutter/material.dart';
import 'package:webagro/widgets/custom_appbar.dart';
import 'package:webagro/widgets/edit_greenhouse.dart';
import 'package:webagro/widgets/edit_perangkat.dart';
import 'package:webagro/widgets/tambah_greenhouse.dart';
import 'package:webagro/widgets/tambah_perangkat.dart';

class Greenhouse extends StatefulWidget {
  const Greenhouse({super.key});

  @override
  _GreenhouseState createState() => _GreenhouseState();
}

class _GreenhouseState extends State<Greenhouse> {
  List<Map<String, String>> greenhouses = [
    {
      'name': 'Green House 1',
      'owner': 'Owner 1',
      'manager': 'Manager 1',
      'address': 'Address 1',
      'size': 'Size 1',
      'plantType': 'Plant Type 1',
      'telegramId': 'Telegram ID 1'
    },
    {
      'name': 'Green House 2',
      'owner': 'Owner 2',
      'manager': 'Manager 2',
      'address': 'Address 2',
      'size': 'Size 2',
      'plantType': 'Plant Type 2',
      'telegramId': 'Telegram ID 2'
    },
  ];

  List<Map<String, String>> devices = [
    {
      'name': 'Perangkat 1',
      'id': '73529614656',
      'description': 'Deskripsi Perangkat 1',
      'greenhouse': 'Green House 1',
    },
    {
      'name': 'Perangkat 2',
      'id': '38924681000',
      'description': 'Deskripsi Perangkat 2',
      'greenhouse': 'Green House 2',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        activityName: "Greenhouse",
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSummaryCards(constraints.maxWidth),
                  const SizedBox(height: 20),
                  _buildTable(
                    'GreenHouse',
                    _buildGreenHouseTable(constraints.maxWidth, context),
                    context,
                    Tambah_greenhouse(), // Ensure the constructor name matches your implementation
                    (newGreenhouse) {
                      setState(() {
                        greenhouses.add(newGreenhouse);
                      });
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTable(
                    'Perangkat',
                    _buildPerangkatTable(constraints.maxWidth, context),
                    context,
                    Tambah_perangkat(), // Ensure the constructor name matches your implementation
                    (newDevice) {
                      setState(() {
                        devices.add(newDevice);
                      });
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryCards(double width) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Flexible(
          child: _buildSummaryCard('3', 'Jumlah Green House'),
        ),
        SizedBox(width: width * 0.05),
        Flexible(
          child: _buildSummaryCard('3', 'Jumlah Perangkat'),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(String number, String label) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: const Color(0xFFBAC6CB),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            decoration: const BoxDecoration(
              color: Color(0xFF33697C),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  number,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF33697C),
                  ),
                ),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    label,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTable(String title, Widget table, BuildContext context,
      Widget destination, Function(Map<String, String>) onAdd) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tabel $title',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF33697C),
          ),
        ),
        const SizedBox(height: 10),
        _buildTableContainer(
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchAndAddRow(context, destination, onAdd),
              const SizedBox(height: 10),
              table,
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchAndAddRow(BuildContext context, Widget destination,
      Function(Map<String, String>) onAdd) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 40,
            child: TextField(
              textAlign: TextAlign.left,
              decoration: InputDecoration(
                hintText: 'Cari',
                contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                fillColor: Colors.white,
                filled: true,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        ElevatedButton(
          onPressed: () async {
            final newItem = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => destination),
            );

            if (newItem != null) {
              print(newItem);
              onAdd(newItem);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFBAC6CB),
            foregroundColor: Colors.white,
          ),
          child: Text('Tambah'),
        ),
      ],
    );
  }

  Widget _buildGreenHouseTable(double width, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: width),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(const Color(0xFFBAC6CB)),
          columns: [
            DataColumn(label: _buildTableHeader('Nama')),
            DataColumn(label: _buildTableHeader('Pemilik')),
            DataColumn(label: _buildTableHeader('Pengelola')),
            DataColumn(label: _buildTableHeader('Alamat')),
            DataColumn(label: _buildTableHeader('Ukuran')),
            DataColumn(label: _buildTableHeader('Jenis Tanaman')),
            DataColumn(label: _buildTableHeader('Telegram ID')),
            DataColumn(label: _buildTableHeader('Aksi')),
          ],
          rows: greenhouses.map((greenhouse) {
            return _buildGreenHouseRow(
              greenhouse['name']!,
              greenhouse['owner']!,
              greenhouse['manager']!,
              greenhouse['address']!,
              greenhouse['size']!,
              greenhouse['plantType']!,
              greenhouse['telegramId']!,
              context,
            );
          }).toList(),
        ),
      ),
    );
  }

  DataRow _buildGreenHouseRow(
      String name,
      String owner,
      String manager,
      String address,
      String size,
      String plantType,
      String telegramId,
      BuildContext context) {
    return DataRow(
      color: WidgetStateProperty.all(Colors.white),
      cells: [
        DataCell(Text(name)),
        DataCell(Text(owner)),
        DataCell(Text(manager)),
        DataCell(Text(address)),
        DataCell(Text(size)),
        DataCell(Text(plantType)),
        DataCell(Text(telegramId)),
        DataCell(Row(
          children: [
            ElevatedButton(
              onPressed: () async {
                final updatedGreenhouse = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditGreenhousePage(
                      name: name,
                      owner: owner,
                      manager: manager,
                      address: address,
                      size: size,
                      plantType: plantType,
                      telegramId: telegramId,
                    ),
                  ),
                );
                if (updatedGreenhouse != null) {
                  setState(() {
                    final index =
                        greenhouses.indexWhere((g) => g['name'] == name);
                    greenhouses[index] = {
                      'name': updatedGreenhouse['name'],
                      'owner': updatedGreenhouse['owner'],
                      'manager': updatedGreenhouse['manager'],
                      'address': updatedGreenhouse['address'],
                      'size': updatedGreenhouse['size'],
                      'plantType': updatedGreenhouse['plantType'],
                      'telegramId': updatedGreenhouse['telegramId'],
                    };
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF33697C),
              ),
              child: Text('Ubah'),
            ),
            const SizedBox(width: 4),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  greenhouses
                      .removeWhere((greenhouse) => greenhouse['name'] == name);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('Hapus'),
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildPerangkatTable(double width, BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(minWidth: width),
        child: DataTable(
          headingRowColor: WidgetStateProperty.all(const Color(0xFFBAC6CB)),
          columns: [
            DataColumn(label: _buildTableHeader('Nama')),
            DataColumn(label: _buildTableHeader('ID Perangkat')),
            DataColumn(label: _buildTableHeader('Deskripsi')),
            DataColumn(label: _buildTableHeader('GreenHouse')),
            DataColumn(label: _buildTableHeader('Aksi')),
          ],
          rows: devices.map((device) {
            return _buildPerangkatRow(
              device['name']!,
              device['id']!,
              device['description']!,
              device['greenhouse']!,
              context,
            );
          }).toList(),
        ),
      ),
    );
  }

  DataRow _buildPerangkatRow(String name, String id, String description,
      String greenhouse, BuildContext context) {
    return DataRow(
      color: WidgetStateProperty.all(Colors.white),
      cells: [
        DataCell(Text(name)),
        DataCell(Text(id)),
        DataCell(Text(description)),
        DataCell(Text(greenhouse)),
        DataCell(Row(
          children: [
            ElevatedButton(
              onPressed: () async {
                final updatedDevice = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditPerangkatPage(
                      name: name,
                      id: id,
                      description: description,
                      greenhouse: greenhouse,
                    ),
                  ),
                );
                if (updatedDevice != null) {
                  setState(() {
                    final index = devices.indexWhere((d) => d['id'] == id);
                    devices[index] = {
                      'name': updatedDevice['name'],
                      'id': updatedDevice['id'],
                      'description': updatedDevice['description'],
                      'greenhouse': updatedDevice['greenhouse'],
                    };
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF33697C),
              ),
              child: Text('Ubah'),
            ),
            const SizedBox(width: 4),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  devices.removeWhere((device) => device['id'] == id);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: Text('Hapus'),
            ),
          ],
        )),
      ],
    );
  }

  Widget _buildTableHeader(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFF33697C),
      ),
    );
  }

  Widget _buildTableContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF33697C), // Mengatur warna latar belakang kotak
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }
}
