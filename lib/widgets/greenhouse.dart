import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webagro/chopper_api/api_client.dart';
import 'package:webagro/models/greenhouse.dart' as model;
import 'package:webagro/models/perangkat.dart';
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
  List<Map<String, String>> greenhouses = [];

  List<model.Greenhouse> greenhouseModel = [];
  List<Perangkat> perangkatModel = [];

  String? token;

  final apiService = ApiClient().apiService;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  Future<void> _initialize() async {
    await _getToken(); // Wait for token retrieval
    if (token != null) {
      await _fetchGreenhouses(); // Only fetch greenhouses if token is set
      await _fetchAllPerangkat(); // Only fetch perangkat if token is set
    }
  }

  Future<void> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('bearer_token');
    setState(() {
      this.token = token;
    });
  }

  Future<void> _fetchGreenhouses() async {
    final response =
        await apiService.getAllGreenhouses('Bearer $token'); // Pass the token

    if (response.isSuccessful) {
      setState(() {
        greenhouseModel = (response.body["data"] as List)
            .map((greenhouse) => model.Greenhouse.fromJson(greenhouse))
            .toList();
        greenhouses = greenhouseModel
            .map((greenhouse) => {
                  'name': greenhouse.nama,
                  'owner': greenhouse.pemilik,
                  'manager': greenhouse.pengelola,
                  'address': greenhouse.alamat,
                  'size': greenhouse.ukuran,
                  'plantType': greenhouse.jenisTanaman.nama,
                  'telegramId': greenhouse.telegramId ?? "-",
                })
            .toList();
      });
    } else {
      // Handle error
      print('Failed to fetch greenhouses: ${response.error}');
    }
  }

  Future<void> _fetchAllPerangkat() async {
    final response =
        await apiService.getAllPerangkat('Bearer $token'); // Pass the token

    if (response.isSuccessful) {
      setState(() {
        perangkatModel = (response.body["data"] as List)
            .map((perangkat) => Perangkat.fromJson(perangkat))
            .toList();
      });
    } else {
      // Handle error
      print('Failed to fetch perangkat: ${response.error}');
    }
  }

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
                    const Tambah_greenhouse(), // Ensure the constructor name matches your implementation
                    (newGreenhouse) async {
                      setState(() {
                        greenhouses.add(newGreenhouse);
                      });
                      final data = model.Greenhouse(
                        id: greenhouses.length,
                        nama: newGreenhouse['name'] ?? "",
                        pemilik: newGreenhouse['owner'] ?? "",
                        pengelola: newGreenhouse['manager'] ?? "",
                        alamat: newGreenhouse['address'] ?? "",
                        ukuran: newGreenhouse['size'] ?? "",
                        jenisTanamanId: "1",
                        jenisTanaman: model.JenisTanaman(id: 0, nama: ""),
                        telegramId: newGreenhouse['telegramId'] ?? "",
                        gambar: newGreenhouse['imagePath'] ?? "",
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      );
                      await apiService.createGreenhouse(
                        'Bearer $token',
                        data.toJson(),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildTable(
                    'Perangkat',
                    _buildPerangkatTable(constraints.maxWidth, context),
                    context,
                    Tambah_perangkat(
                        greenhouses:
                            greenhouseModel), // Ensure the constructor name matches your implementation
                    (newDevice) async {
                      final data = Perangkat(
                        id: perangkatModel.length,
                        nama: newDevice['name'] ?? "",
                        keterangan: newDevice['description'] ?? "",
                        greenhouseId: newDevice['greenhouse_id'] ?? "",
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now(),
                      );
                      await apiService.createPerangkat(
                          'Bearer $token', data.toJson());
                      setState(() {
                        perangkatModel.add(data);
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
            print(newItem);

            if (newItem != null) {
              onAdd(newItem);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFBAC6CB),
            foregroundColor: Colors.white,
          ),
          child: const Text('Tambah'),
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
          rows: greenhouseModel.map((greenhouse) {
            return _buildGreenHouseRow(
              greenhouse.id,
              greenhouse.nama,
              greenhouse.pemilik,
              greenhouse.pengelola,
              greenhouse.alamat,
              greenhouse.ukuran,
              greenhouse.jenisTanaman.nama,
              greenhouse.telegramId ?? "",
              context,
            );
          }).toList(),
        ),
      ),
    );
  }

  DataRow _buildGreenHouseRow(
      int id,
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
                  final data = model.Greenhouse(
                    id: id,
                    nama: updatedGreenhouse['name'] ?? "",
                    pemilik: updatedGreenhouse['owner'] ?? "",
                    pengelola: updatedGreenhouse['manager'] ?? "",
                    alamat: updatedGreenhouse['address'] ?? "",
                    ukuran: updatedGreenhouse['size'] ?? "",
                    jenisTanamanId: "1",
                    jenisTanaman: model.JenisTanaman(id: 0, nama: ""),
                    telegramId: updatedGreenhouse['telegramId'] ?? "",
                    gambar: updatedGreenhouse['imagePath'] ?? "",
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  );
                  await apiService.updateGreenhouse(
                    'Bearer $token',
                    id,
                    data.toJson(),
                  );
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
              child: const Text('Ubah'),
            ),
            const SizedBox(width: 4),
            ElevatedButton(
              onPressed: () async {
                await apiService.deleteGreenhouse("bearer $token", id);
                setState(() {
                  greenhouses
                      .removeWhere((greenhouse) => greenhouse['name'] == name);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Hapus'),
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
          rows: perangkatModel.map((device) {
            return _buildPerangkatRow(
              device.nama,
              device.id.toString(),
              device.keterangan,
              greenhouseModel
                  .firstWhere(
                      (model) => model.id.toString() == device.greenhouseId)
                  .nama,
              perangkatModel.firstWhere((model) => model.id == device.id),
              context,
            );
          }).toList(),
        ),
      ),
    );
  }

  DataRow _buildPerangkatRow(String name, String id, String description,
      String greenhouse, Perangkat perangkat, BuildContext context) {
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
                  final data = Perangkat(
                    id: int.parse(id),
                    nama: updatedDevice['name'] ?? "",
                    keterangan: updatedDevice['description'] ?? "",
                    greenhouseId: updatedDevice['greenhouse'] ?? "",
                    createdAt: perangkat.createdAt,
                    updatedAt: DateTime.now(),
                  );
                  await apiService.updatePerangkat(
                    'Bearer $token',
                    int.parse(id),
                    data.toJson(),
                  );
                  setState(() {
                    final index =
                        perangkatModel.indexWhere((d) => d.id.toString() == id);
                    perangkatModel[index] = Perangkat(
                        id: updatedDevice['id'],
                        nama: updatedDevice['name'],
                        keterangan: updatedDevice['description'],
                        greenhouseId: greenhouseModel
                            .firstWhere((model) =>
                                model.nama == updatedDevice['greenhouse'])
                            .id
                            .toString(),
                        createdAt: DateTime.now(),
                        updatedAt: DateTime.now());
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: const Color(0xFF33697C),
              ),
              child: const Text('Ubah'),
            ),
            const SizedBox(width: 4),
            ElevatedButton(
              onPressed: () async {
                await apiService.deletePerangkat("bearer $token", perangkat.id);
                setState(() {
                  perangkatModel
                      .removeWhere((device) => device.id.toString() == id);
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Hapus'),
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
