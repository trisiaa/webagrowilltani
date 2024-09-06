import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webagro/widgets/custom_appbar.dart';

class Tambah_greenhouse extends StatefulWidget {
  @override
  _TambahGreenhouseState createState() => _TambahGreenhouseState();
}

class _TambahGreenhouseState extends State<Tambah_greenhouse> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for the text fields
  final _nameController = TextEditingController();
  final _ownerController = TextEditingController();
  final _addressController = TextEditingController();
  final _sizeController = TextEditingController();
  final _managerController = TextEditingController();
  final _plantTypeController = TextEditingController();
  final _telegramIdController = TextEditingController();

  // File upload variable
  XFile? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile;
    });
  }

  @override
  void dispose() {
    // Clean up the controllers when the widget is disposed
    _nameController.dispose();
    _ownerController.dispose();
    _addressController.dispose();
    _sizeController.dispose();
    _managerController.dispose();
    _plantTypeController.dispose();
    _telegramIdController.dispose();
    super.dispose();
  }

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
                    'Tambah Greenhouse',
                    style: TextStyle(
                      fontSize: 24, // Larger font size
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF33697C),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildLabeledTextField('Nama', _nameController),
                SizedBox(height: 10),
                _buildLabeledTextField('Pemilik', _ownerController),
                SizedBox(height: 10),
                _buildLabeledTextField('Alamat', _addressController),
                SizedBox(height: 10),
                _buildLabeledTextField('Luas', _sizeController),
                SizedBox(height: 10),
                _buildLabeledTextField('Pengelola', _managerController),
                SizedBox(height: 10),
                _buildLabeledTextField('Jenis Tanaman', _plantTypeController),
                SizedBox(height: 10),
                _buildLabeledTextField('Telegram ID', _telegramIdController),
                SizedBox(height: 10),
                Text(
                  'Kondisi (Upload Gambar Ukuran Max 1 MB)',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF33697C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50.0, // Match the height of the button
                        decoration: BoxDecoration(
                          color: Color(0xFFBAC6CB),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: _image == null
                                ? Text('No image selected')
                                : Text('Image Selected'),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      height: 50.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50.0),
                          bottomRight: Radius.circular(50.0),
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: _pickImage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF294A52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 20.0),
                          elevation: 0, // Remove the button's shadow to match the container
                        ),
                        child: Text(
                          'Choose File',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final newGreenhouse = {
                            'name': _nameController.text,
                            'owner': _ownerController.text,
                            'address': _addressController.text,
                            'size': _sizeController.text,
                            'manager': _managerController.text,
                            'plantType': _plantTypeController.text,
                            'telegramId': _telegramIdController.text,
                            'imagePath': _image?.path,
                          };

                          print('New Greenhouse Data: $newGreenhouse');
                          Navigator.pop(context, newGreenhouse);
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

