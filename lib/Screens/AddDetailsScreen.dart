import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:freshwavelaundry/Screens/home_main.dart';
import 'package:freshwavelaundry/api_services/global.dart';
import 'package:freshwavelaundry/api_services/user_api.dart';
import 'package:freshwavelaundry/providers/UserDataProvider.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDetailsScreen extends StatelessWidget {
  final phone_number;

  AddDetailsScreen({this.phone_number}) {
    phoneNumberController.text = phone_number;
  }

  // Controllers for text fields
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future<void> _saveUserData() async {
      if (_formKey.currentState?.validate() ?? false) {
        final id = await user_api.fetchUserID();
        final apiUrl = APIservice.address + '/User/updateUser/$id';

        final userData = {
          'username': usernameController.text,
          'password': passwordController.text,
          'email': emailController.text,
          'address': addressController.text,
        };

        final headers = {
          'Content-Type': 'application/json',
        };

        try {
          final response = await http.put(
            Uri.parse(apiUrl),
            headers: headers,
            body: json.encode(userData),
          );
          if (response.statusCode == 200) {
            print(response.body);
            final responseData = jsonDecode(response.body);
            print(responseData);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => home_main(),
              ),
            );
          } else {
            print('Error: ${response.statusCode}');
            print('Response: ${response.body}');
          }
        } catch (e) {
          print('Exception: $e');
        }
      }
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: Color.fromRGBO(227, 240, 253, 1),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: SingleChildScrollView(
                padding: EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Text(
                        'Add Your Details',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color.fromARGB(255, 55, 119, 247),
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 30),
                      _buildTextField(
                        controller: usernameController,
                        labelText: 'Username',
                        prefixIcon: Icons.person,
                        labelColor: Color.fromARGB(255, 0, 0, 0),
                      ),
                      SizedBox(height: 20),
                      _buildTextField(
                        controller: passwordController,
                        labelText: 'Password',
                        prefixIcon: Icons.lock,
                        labelColor: Color.fromARGB(255, 0, 0, 0),
                        obscureText: true,
                      ),
                      SizedBox(height: 20),
                      _buildTextField(
                        controller: phoneNumberController,
                        labelText: 'Phone number',
                        prefixIcon: Icons.phone,
                        labelColor: Color.fromARGB(255, 0, 0, 0),
                        enabled: false,
                      ),
                      SizedBox(height: 20),
                      _buildTextField(
                        controller: emailController,
                        labelText: 'E-mail',
                        prefixIcon: Icons.email,
                        labelColor: Color.fromARGB(255, 0, 0, 0),
                      ),
                      SizedBox(height: 20),
                      _buildTextField(
                        controller: addressController,
                        labelText: 'Address',
                        prefixIcon: Icons.location_on,
                        labelColor: Color.fromARGB(255, 0, 0, 0),
                      ),
                      SizedBox(height: 30),
                      ElevatedButton(
                        onPressed: _saveUserData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String labelText,
    required IconData prefixIcon,
    required Color labelColor,
    Color? iconColor, // Added iconColor parameter
    bool obscureText = false,
    bool enabled = true,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(
          color: labelColor,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: Icon(
          prefixIcon,
          color: iconColor ?? null, // Apply iconColor if provided
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$labelText is required';
        }
        return null;
      },
    );
  }
}
