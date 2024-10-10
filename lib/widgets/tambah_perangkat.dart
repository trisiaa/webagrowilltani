import 'package:flutter/material.dart';
import 'package:webagro/widgets/custom_appbar.dart';

class Tambah_perangkat extends StatefulWidget {
  const Tambah_perangkat({super.key});

  @override
  _TambahPerangkatState createState() => _TambahPerangkatState();
}

class _TambahPerangkatState extends State<Tambah_perangkat> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the text fields
  final _nameController = TextEditingController();
  final _perangkatid = TextEditingController();
  final _keterangan = TextEditingController();

  // Selected greenhouse
  String? _selectedGreenhouse;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        activityName: "Tambah Perangkat",
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
                    'Tambah Perangkat',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF33697C),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildLabeledTextField('Nama', _nameController),
                const SizedBox(height: 10),
                _buildLabeledTextField('Perangkat ID', _perangkatid),
                const SizedBox(height: 10),
                _buildLabeledTextField('Keterangan', _keterangan),
                const SizedBox(height: 10),
                const Text(
                  'Greenhouse',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF33697C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 50.0, // Set the height of the container
                  decoration: BoxDecoration(
                    color: const Color(0xFFBAC6CB),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50.0, // Match the height of the button
                          decoration: BoxDecoration(
                            color: const Color(0xFFBAC6CB),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                      Container(
                        height: 50.0,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50.0),
                            bottomRight: Radius.circular(50.0),
                          ),
                        ),
                        child: ElevatedButton(
                          onPressed: () => _showGreenhouseDialog(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF294A52),
                            // Make the button background transparent
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0)),
                            padding: const EdgeInsets.symmetric(
                                horizontal:
                                    20.0), // Padding for the button text
                            elevation:
                                0, // Remove the button's shadow to match the container
                          ),
                          child: Text(
                            _selectedGreenhouse ?? 'Pilih Greenhouse',
                            style: const TextStyle(
                              color:
                                  Colors.white, // Set the text color to white
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final newDevice = {
                            'name': _nameController.text,
                            'id': _perangkatid.text,
                            'description': _keterangan.text,
                            'greenhouse': _selectedGreenhouse,
                          };

                          Navigator.pop(
                              context, newDevice); // Mengembalikan data baru
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF294A52),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Tambah'),
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
                      child: const Text('Kembali'),
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

  void _showGreenhouseDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Pilih Greenhouse'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  title: const Text('Greenhouse 1'),
                  onTap: () {
                    setState(() {
                      _selectedGreenhouse = 'Greenhouse 1';
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Greenhouse 2'),
                  onTap: () {
                    setState(() {
                      _selectedGreenhouse = 'Greenhouse 2';
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: const Text('Greenhouse 3'),
                  onTap: () {
                    setState(() {
                      _selectedGreenhouse = 'Greenhouse 3';
                    });
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
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
