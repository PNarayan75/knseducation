import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_website/pages/studentRegistrationController.dart';
import 'package:get/get.dart';

class StudentRegistrationForm extends StatelessWidget {
  const StudentRegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(StudentRegistrationController());

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
                key: controller.formKey,
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
                    buildInputField(controller.nameController, 'Enter your name'),
                    buildLabel('Phone Number'),
                    buildInputField(controller.phoneController, 'Enter your phone number',
                        keyboardType: TextInputType.phone),
                    buildLabel('Email'),
                    buildInputField(controller.emailController, 'Enter your email',
                        keyboardType: TextInputType.emailAddress),
                    buildLabel('Studying in'),
                    Obx(() => DropdownButtonFormField<String>(
                          value: controller.selectedClass.value.isEmpty
                              ? null
                              : controller.selectedClass.value,
                          decoration: buildInputDecoration('10 / 11 / 12 / Drop'),
                          items: const [
                            DropdownMenuItem(value: '10', child: Text('10')),
                            DropdownMenuItem(value: '11', child: Text('11')),
                            DropdownMenuItem(value: '12', child: Text('12')),
                            DropdownMenuItem(value: 'Drop', child: Text('Drop')),
                          ],
                          onChanged: (value) {
                            controller.selectedClass.value = value ?? '';
                          },
                          validator: (value) =>
                              value == null || value.isEmpty ? 'Please select your class' : null,
                        )),
                    buildLabel('Address'),
                    TextFormField(
                      controller: controller.addressController,
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
                    Obx(() => SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: controller.isLoading.value
                                ? null
                                : controller.submitForm,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF689F38),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                            ),
                            child: controller.isLoading.value
                                ? const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text(
                                    'SUBMIT',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                          ),
                        )),
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