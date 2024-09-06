import 'package:flutter/material.dart';
import 'package:webagro/widgets/custom_appbar.dart';

class Tambah_perangkat extends StatefulWidget {
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
      appBar: CustomAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Tambah Perangkat',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF33697C),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildLabeledTextField('Nama', _nameController),
                SizedBox(height: 10),
                _buildLabeledTextField('Perangkat ID', _perangkatid),
                SizedBox(height: 10),
                _buildLabeledTextField('Keterangan', _keterangan),
                SizedBox(height: 10),
                Text(
                  'Greenhouse',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF33697C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Container(
                  width: double.infinity,
                  height: 50.0, // Set the height of the container
                  decoration: BoxDecoration(
                    color: Color(0xFFBAC6CB),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 50.0, // Match the height of the button
                          decoration: BoxDecoration(
                            color: Color(0xFFBAC6CB),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                        ),
                      ),
                      Container(
                        height: 50.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(50.0),
                            bottomRight: Radius.circular(50.0),
                          ),
                        ),
                        child: ElevatedButton(
                          
                          onPressed: () => _showGreenhouseDialog(),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF294A52),
                             // Make the button background transparent
                            shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(50.0)
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20.0), // Padding for the button text
                            elevation: 0, // Remove the button's shadow to match the container
                          ),
                          child: Text(
                            _selectedGreenhouse ?? 'Pilih Greenhouse',
                            style: TextStyle(
                              color: Colors.white, // Set the text color to white
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
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

                    Navigator.pop(context, newDevice); // Mengembalikan data baru
                  }
                },
                child: Text('Tambah'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF294A52),
                  foregroundColor: Colors.white,
                ),
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Kembali'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
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
          title: Text('Pilih Greenhouse'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                ListTile(
                  title: Text('Greenhouse 1'),
                  onTap: () {
                    setState(() {
                      _selectedGreenhouse = 'Greenhouse 1';
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Greenhouse 2'),
                  onTap: () {
                    setState(() {
                      _selectedGreenhouse = 'Greenhouse 2';
                    });
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Greenhouse 3'),
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

  Widget _buildLabeledTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Color(0xFF33697C),
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            fillColor: Color(0xFFBAC6CB),
            filled: true,
            contentPadding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 16.0),
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

