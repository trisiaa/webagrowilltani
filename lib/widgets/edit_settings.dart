import 'package:flutter/material.dart';

class EditSettings extends StatefulWidget {
  final String suhuMinimal;
  final String suhuMaximal;
  final String tdsMinimal;
  final String tdsMaximal;
  final String kelembabanMinimal;
  final String kelembabanMaximal;
  final String volumeAirMinimal;
  final String volumeAirMaximal;

  const EditSettings({
    super.key,
    required this.suhuMinimal,
    required this.suhuMaximal,
    required this.tdsMinimal,
    required this.tdsMaximal,
    required this.kelembabanMinimal,
    required this.kelembabanMaximal,
    required this.volumeAirMinimal,
    required this.volumeAirMaximal,
  });

  @override
  _EditSettingsState createState() => _EditSettingsState();
}

class _EditSettingsState extends State<EditSettings> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the text fields
  late TextEditingController _suhuMinimalController;
  late TextEditingController _suhuMaximalController;
  late TextEditingController _tdsMinimalController;
  late TextEditingController _tdsMaximalController;
  late TextEditingController _kelembabanMinimalController;
  late TextEditingController _kelembabanMaximalController;
  late TextEditingController _volumeAirMinimalController;
  late TextEditingController _volumeAirMaximalController;

  @override
  void initState() {
    super.initState();
    _suhuMinimalController = TextEditingController(text: widget.suhuMinimal);
    _suhuMaximalController = TextEditingController(text: widget.suhuMaximal);
    _tdsMinimalController = TextEditingController(text: widget.tdsMinimal);
    _tdsMaximalController = TextEditingController(text: widget.tdsMaximal);
    _kelembabanMinimalController =
        TextEditingController(text: widget.kelembabanMinimal);
    _kelembabanMaximalController =
        TextEditingController(text: widget.kelembabanMaximal);
    _volumeAirMinimalController =
        TextEditingController(text: widget.volumeAirMinimal);
    _volumeAirMaximalController =
        TextEditingController(text: widget.volumeAirMaximal);
  }

  @override
  void dispose() {
    _suhuMinimalController.dispose();
    _suhuMaximalController.dispose();
    _tdsMinimalController.dispose();
    _tdsMaximalController.dispose();
    _kelembabanMinimalController.dispose();
    _kelembabanMaximalController.dispose();
    _volumeAirMinimalController.dispose();
    _volumeAirMaximalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Edit Settings',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF33697C),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildLabeledTextField('Suhu Minimal', _suhuMinimalController),
                const SizedBox(height: 10),
                _buildLabeledTextField('Suhu Maximal', _suhuMaximalController),
                const SizedBox(height: 10),
                _buildLabeledTextField('TDS Minimal', _tdsMinimalController),
                const SizedBox(height: 10),
                _buildLabeledTextField('TDS Maximal', _tdsMaximalController),
                const SizedBox(height: 10),
                _buildLabeledTextField(
                    'Kelembaban Minimal', _kelembabanMinimalController),
                const SizedBox(height: 10),
                _buildLabeledTextField(
                    'Kelembaban Maximal', _kelembabanMaximalController),
                const SizedBox(height: 10),
                _buildLabeledTextField(
                    'Volume Air Minimal', _volumeAirMinimalController),
                const SizedBox(height: 10),
                _buildLabeledTextField(
                    'Volume Air Maximal', _volumeAirMaximalController),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.pop(context, {
                            'suhuMinimal': _suhuMinimalController.text,
                            'suhuMaximal': _suhuMaximalController.text,
                            'tdsMinimal': _tdsMinimalController.text,
                            'tdsMaximal': _tdsMaximalController.text,
                            'kelembabanMinimal':
                                _kelembabanMinimalController.text,
                            'kelembabanMaximal':
                                _kelembabanMaximalController.text,
                            'volumeAirMinimal':
                                _volumeAirMinimalController.text,
                            'volumeAirMaximal':
                                _volumeAirMaximalController.text,
                          });
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF294A52),
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Simpan'),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabeledTextField(
      String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Color(0xFF33697C),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            fillColor: const Color(0xFFBAC6CB),
            filled: true,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50.0),
              borderSide: BorderSide.none,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Field ini harus diisi';
            }
            return null;
          },
        ),
      ],
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EditSettings(
      suhuMinimal: '20',
      suhuMaximal: '30',
      tdsMinimal: '500',
      tdsMaximal: '1000',
      kelembabanMinimal: '60',
      kelembabanMaximal: '80',
      volumeAirMinimal: '100',
      volumeAirMaximal: '200',
    ),
  ));
}
