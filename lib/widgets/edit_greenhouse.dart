import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webagro/widgets/custom_appbar.dart';
import 'dart:io'; // Import this to use File

class EditGreenhousePage extends StatefulWidget {
  final String name;
  final String owner;
  final String manager;
  final String address;
  final String size;
  final String plantType;
  final String telegramId;

  EditGreenhousePage({
    required this.name,
    required this.owner,
    required this.manager,
    required this.address,
    required this.size,
    required this.plantType,
    required this.telegramId,
  });

  @override
  _EditGreenhousePageState createState() => _EditGreenhousePageState();
}

class _EditGreenhousePageState extends State<EditGreenhousePage> {
  final _formKey = GlobalKey<FormState>(); // Declare and initialize _formKey
  late TextEditingController _nameController;
  late TextEditingController _ownerController;
  late TextEditingController _managerController;
  late TextEditingController _addressController;
  late TextEditingController _sizeController;
  late TextEditingController _plantTypeController;
  late TextEditingController _telegramIdController;

  // File upload variable
  XFile? _image;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
    _ownerController = TextEditingController(text: widget.owner);
    _managerController = TextEditingController(text: widget.manager);
    _addressController = TextEditingController(text: widget.address);
    _sizeController = TextEditingController(text: widget.size);
    _plantTypeController = TextEditingController(text: widget.plantType);
    _telegramIdController = TextEditingController(text: widget.telegramId);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = pickedFile;
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ownerController.dispose();
    _managerController.dispose();
    _addressController.dispose();
    _sizeController.dispose();
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
          key: _formKey, // Assign _formKey to the Form widget
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Edit Greenhouse',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF33697C),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                _buildLabeledTextField('Nama Greenhouse', _nameController),
                SizedBox(height: 10),
                _buildLabeledTextField('Pemilik', _ownerController),
                SizedBox(height: 10),
                _buildLabeledTextField('Pengelola', _managerController),
                SizedBox(height: 10),
                _buildLabeledTextField('Alamat', _addressController),
                SizedBox(height: 10),
                _buildLabeledTextField('Ukuran', _sizeController),
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
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: _image == null
                                  ? Text('No image selected.')
                                  : Image.file(
                                      File(_image!.path),
                                      fit: BoxFit.cover,
                                    ),
                            ),
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
                          onPressed: _pickImage,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF294A52),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50.0),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 20.0), // Padding for the button text
                            elevation: 0, // Remove the button's shadow to match the container
                          ),
                          child: Text(
                            'Choose File',
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final updatedGreenhouse = {
                            'name': _nameController.text,
                            'owner': _ownerController.text,
                            'manager': _managerController.text,
                            'address': _addressController.text,
                            'size': _sizeController.text,
                            'plantType': _plantTypeController.text,
                            'telegramId': _telegramIdController.text,
                          };

                          Navigator.pop(context, updatedGreenhouse);
                        }
                      },
                      child: Text('Simpan'),
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

void main() {
  runApp(MaterialApp(
    home: EditGreenhousePage(
      name: 'Greenhouse A',
      owner: 'Owner A',
      manager: 'Manager A',
      address: 'Address A',
      size: '100m2',
      plantType: 'Tomato',
      telegramId: '123456789',
    ),
  ));
}
