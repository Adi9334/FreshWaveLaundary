import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:freshwavelaundry/Models/user_model.dart';
import 'package:freshwavelaundry/api_services/global.dart';
import 'package:freshwavelaundry/api_services/user_api.dart';
import 'package:freshwavelaundry/providers/UserDataProvider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProfileUpdateScreen extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileUpdateScreen> {
  List<user_model> user = [];
  File? _image;
  Uint8List? _imageBytes;
  bool _isImageError = false;
  bool _isSaving = false;

  Future<void> loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final imagePath = prefs.getString('profile_image_path');

    if (imagePath != null && File(imagePath).existsSync()) {
      setState(() {
        _image = File(imagePath);
        _imageBytes = File(imagePath).readAsBytesSync();
      });
    } else {
      print('Image file does not exist at the stored path: $imagePath');
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker _imagePicker = ImagePicker();
    try {
      final XFile? image =
          await _imagePicker.pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final directory = await getApplicationDocumentsDirectory();
      final String path = directory.path;
      final File newImage =
          await File(image.path).copy('$path/profile_image.png');

      setState(() {
        _image = newImage;
        _imageBytes = newImage.readAsBytesSync();
        _isImageError = false;
      });

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('profile_image_path', newImage.path);
    } catch (e) {
      setState(() {
        _isImageError = true;
      });
      print('Error picking image: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error picking image. Please try again.'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    fetchusers();
    loadImage();
  }

  Future<void> fetchusers() async {
    // final userdata = Provider.of<UserDataProvider>(context, listen: false);
    // final id = userdata.userId;
    final response = await user_api.fetchuser();
    if (mounted) {
      setState(() {
        user = response;
        if (user.isNotEmpty) {
          _nameController.text = user[0].name;
          _emailController.text = user[0].email;
          _phoneController.text = user[0].phone_number;
          _addressController.text = user[0].address;
        }
      });
    }
  }

  bool _isEditing = false;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _addressController = TextEditingController();

  Future<void> _saveuserdata() async {
    if (_isSaving) return;
    setState(() {
      _isSaving = true;
    });

    final userData = Provider.of<UserDataProvider>(context, listen: false);
    final id = userData.userId;
    final apiUrl = APIservice.address + '/User/updateUser/$id';

    final userdata = {
      'username': _nameController.text,
      'email': _emailController.text,
      'address': _addressController.text,
    };
    final headers = {
      'Content-Type': 'application/json',
    };
    try {
      final response = await http.put(
        Uri.parse(apiUrl),
        headers: headers,
        body: json.encode(userdata),
      );
      if (response.statusCode == 200) {
        print(response.body);
        final responseData = jsonDecode(response.body);
        print(responseData);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('User data updated successfully.'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.green,
        ));
      } else {
        print('Error: ${response.statusCode}');
        print('Response: ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Error updating user data. Please try again.'),
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      print('Exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
        duration: Duration(seconds: 3),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        _isSaving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 25,
          ),
        ),
        backgroundColor: Colors.blue,
        actions: <Widget>[
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                _isEditing = !_isEditing;
              });
              if (!_isEditing) {
                _saveuserdata();
              }
            },
            color: _isEditing ? Colors.orange[400] : Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                    ),
                    child: _imageBytes != null
                        ? CircleAvatar(
                            radius: 60,
                            backgroundImage: MemoryImage(_imageBytes!),
                          )
                        : CircleAvatar(
                            radius: 60,
                            child: Icon(Icons.person,
                                size: 60, color: Colors.grey[600]),
                          ),
                  ),
                  Positioned(
                    bottom: -10,
                    right: -3,
                    child: IconButton(
                      onPressed: _pickImage,
                      icon: Icon(Icons.add_a_photo),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.0),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Name',
                labelStyle: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15,
                ),
                border: OutlineInputBorder(),
                enabled: _isEditing,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15,
                ),
                border: OutlineInputBorder(),
                enabled: _isEditing,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15,
                ),
                border: OutlineInputBorder(),
                enabled: false,
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                labelText: 'Address',
                labelStyle: GoogleFonts.nunito(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 15,
                ),
                border: OutlineInputBorder(),
                enabled: _isEditing,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
