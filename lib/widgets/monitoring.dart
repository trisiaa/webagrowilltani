import 'package:flutter/material.dart';
import 'package:webagro/widgets/custom_appbar.dart';
import 'package:webagro/utils/responsiveLayout.dart';

class Monitoring extends StatefulWidget {
  const Monitoring({super.key});

  @override
  _MonitoringState createState() => _MonitoringState();
}

class _MonitoringState extends State<Monitoring> {
  String selectedGreenhouse = '';
  List<String> greenhouseOptions = ['Greenhouse 1', 'Greenhouse 2'];

  // Data untuk setiap Greenhouse
  Map<String, List<Map<String, String>>> greenhouseData = {
    'Greenhouse 1': [
      {
        'Perangkat': 'Perangkat 1',
        'Tanggal': '18 Agustus',
        'Kelembaban': '10%',
        'Suhu': '20°C',
        'Intensitas Cahaya': '1200 Lux',
        'Debit Air': '5 L/min',
        'TDS': '200 ppm',
        'Volume Air': '90 L'
      },
    ],
    'Greenhouse 2': [
      {
        'Perangkat': 'Perangkat A',
        'Tanggal': '19 Agustus',
        'Kelembaban': '15%',
        'Suhu': '22°C',
        'Intensitas Cahaya': '1500 Lux',
        'Debit Air': '6 L/min',
        'TDS': '210 ppm',
        'Volume Air': '100 L'
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        activityName: "Monitoring",
      ),
      body: ResponsiveLayout(
        largeScreen: _buildContent(),
        smallScreen: _buildContent(),
      ),
      floatingActionButton: selectedGreenhouse.isNotEmpty
          ? FloatingActionButton.extended(
              onPressed: () => _showTambahDataDialog(context),
              label: const Text('Tambah Data'),
              icon: const Icon(Icons.add),
            )
          : null,
    );
  }

  Widget _buildContent() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDropdown(),
          const SizedBox(height: 20),
          if (selectedGreenhouse.isEmpty)
            const Center(
              child: Text(
                  'Silakan pilih Greenhouse untuk melihat data monitoring.'),
            )
          else
            _buildDataTable(),
        ],
      ),
    );
  }

  Widget _buildDropdown() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: DropdownButton<String>(
          isExpanded: true,
          underline: const SizedBox(),
          hint: Text(
            "Pilih Greenhouse",
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          value: selectedGreenhouse.isNotEmpty ? selectedGreenhouse : null,
          items: greenhouseOptions.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Row(
                children: [
                  const Icon(
                    Icons.eco,
                    color: Colors.green,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    value,
                    style: const TextStyle(fontSize: 16),
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
          icon: const Icon(Icons.arrow_drop_down, color: Colors.green),
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    final data = greenhouseData[selectedGreenhouse]!;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('Perangkat')),
          DataColumn(label: Text('Tanggal')),
          DataColumn(label: Text('Kelembaban')),
          DataColumn(label: Text('Suhu')),
          DataColumn(label: Text('Intensitas Cahaya')),
          DataColumn(label: Text('Debit Air')),
          DataColumn(label: Text('TDS')),
          DataColumn(label: Text('Volume Air')),
          DataColumn(label: Text('Aksi')),
        ],
        rows: data
            .asMap()
            .entries
            .map(
              (entry) => DataRow(cells: [
                DataCell(Text(entry.value['Perangkat']!)),
                DataCell(Text(entry.value['Tanggal']!)),
                DataCell(Text(entry.value['Kelembaban']!)),
                DataCell(Text(entry.value['Suhu']!)),
                DataCell(Text(entry.value['Intensitas Cahaya']!)),
                DataCell(Text(entry.value['Debit Air']!)),
                DataCell(Text(entry.value['TDS']!)),
                DataCell(Text(entry.value['Volume Air']!)),
                DataCell(Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => _showEditDataDialog(context, entry.key),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteData(entry.key),
                    ),
                  ],
                )),
              ]),
            )
            .toList(),
      ),
    );
  }

  void _showTambahDataDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final Map<String, String> newData = {
      'Perangkat': '',
      'Tanggal': '',
      'Kelembaban': '',
      'Suhu': '',
      'Intensitas Cahaya': '',
      'Debit Air': '',
      'TDS': '',
      'Volume Air': '',
    };

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Tambah Data Baru'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: newData.keys.map((key) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: key),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '$key tidak boleh kosong';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        newData[key] = value!;
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Simpan'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  setState(() {
                    greenhouseData[selectedGreenhouse]!.add(newData);
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _showEditDataDialog(BuildContext context, int index) {
    final formKey = GlobalKey<FormState>();
    final existingData = greenhouseData[selectedGreenhouse]![index];
    final Map<String, String> editedData = Map.from(existingData);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Edit Data'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                children: editedData.keys.map((key) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: TextFormField(
                      initialValue: editedData[key],
                      decoration: InputDecoration(labelText: key),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return '$key tidak boleh kosong';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        editedData[key] = value!;
                      },
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Simpan'),
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  setState(() {
                    greenhouseData[selectedGreenhouse]![index] = editedData;
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  void _deleteData(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Hapus Data'),
          content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Batal'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: const Text('Hapus'),
              onPressed: () {
                setState(() {
                  greenhouseData[selectedGreenhouse]!.removeAt(index);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
