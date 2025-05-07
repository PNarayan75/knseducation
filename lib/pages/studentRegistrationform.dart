import 'package:flutter/material.dart';

class StudentRegistrationForm extends StatefulWidget {
  const StudentRegistrationForm({super.key});

  @override
  State<StudentRegistrationForm> createState() => _StudentRegistrationFormState();
}

class _StudentRegistrationFormState extends State<StudentRegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  String? _selectedClass;

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: const Text('STUDENT REGISTRATION'),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB388F4), Color(0xFF8E24AA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: 400,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'STUDENT REGISTRATION',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: Colors.deepPurple[900],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    buildLabel('Name'),
                    buildInputField(_nameController, 'Enter your name'),

                    buildLabel('Phone Number'),
                    buildInputField(_phoneController, 'Enter your phone number',
                        keyboardType: TextInputType.phone),

                    buildLabel('Email'),
                    buildInputField(_emailController, 'Enter your email',
                        keyboardType: TextInputType.emailAddress),

                    buildLabel('Studying in'),
                    DropdownButtonFormField<String>(
                      value: _selectedClass,
                      decoration: buildInputDecoration('10 / 11 / 12 / Drop'),
                      items: const [
                        DropdownMenuItem(value: '10', child: Text('10')),
                        DropdownMenuItem(value: '11', child: Text('11')),
                        DropdownMenuItem(value: '12', child: Text('12')),
                        DropdownMenuItem(value: 'Drop', child: Text('Drop')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _selectedClass = value;
                        });
                      },
                      validator: (value) =>
                          value == null || value.isEmpty ? 'Please select your class' : null,
                    ),

                    buildLabel('Address'),
                    TextFormField(
                      controller: _addressController,
                      maxLines: 3,
                      decoration: buildInputDecoration('Enter your address'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 24),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Form submitted successfully!'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF689F38),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text(
                          'SUBMIT',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
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
    );
  }

  Widget buildLabel(String text) => Padding(
        padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
        child: Text(
          text,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      );

  Widget buildInputField(TextEditingController controller, String hintText,
      {TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      decoration: buildInputDecoration(hintText),
      keyboardType: keyboardType,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $hintText';
        }
        return null;
      },
    );
  }

  InputDecoration buildInputDecoration(String hint) => InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      );
}
