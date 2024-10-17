import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:webagro/widgets/custom_appbar.dart';

class TambahGreenhouse extends StatefulWidget {
  const TambahGreenhouse({super.key});

  @override
  _TambahGreenhouseState createState() => _TambahGreenhouseState();
}

class _TambahGreenhouseState extends State<TambahGreenhouse> {
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
      appBar: const CustomAppBar(
        activityName: "Tambah Greenhouse",
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
                    'Tambah Greenhouse',
                    style: TextStyle(
                      fontSize: 24, // Larger font size
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF33697C),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _buildLabeledTextField('Nama', _nameController),
                const SizedBox(height: 10),
                _buildLabeledTextField('Pemilik', _ownerController),
                const SizedBox(height: 10),
                _buildLabeledTextField('Alamat', _addressController),
                const SizedBox(height: 10),
                _buildLabeledTextField('Luas', _sizeController),
                const SizedBox(height: 10),
                _buildLabeledTextField('Pengelola', _managerController),
                const SizedBox(height: 10),
                _buildLabeledTextField('Jenis Tanaman', _plantTypeController),
                const SizedBox(height: 10),
                _buildLabeledTextField('Telegram ID', _telegramIdController),
                const SizedBox(height: 10),
                const Text(
                  'Foto (Upload Gambar Ukuran Max 1 MB)',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xFF33697C),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 50.0, // Match the height of the button
                        decoration: BoxDecoration(
                          color: const Color(0xFFBAC6CB),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: _image == null
                                ? const Text('No image selected')
                                : const Text('Image Selected'),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      height: 50.0,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50.0),
                          bottomRight: Radius.circular(50.0),
                        ),
                      ),
                      child: ElevatedButton(
                        onPressed: _pickImage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF294A52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          elevation:
                              0, // Remove the button's shadow to match the container
                        ),
                        child: const Text(
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
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          final newGreenhouse = {
                            'nama': _nameController.text,
                            'pemilik': _ownerController.text,
                            'alamat': _addressController.text,
                            'ukuran': _sizeController.text,
                            'pengelola': _managerController.text,
                            'jenis_tanaman_id': _plantTypeController.text,
                            'telegramId': _telegramIdController.text,
                            'image': _image,
                          };
                          print('New Greenhouse Data: $newGreenhouse');
                          Navigator.pop(context, newGreenhouse);
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
