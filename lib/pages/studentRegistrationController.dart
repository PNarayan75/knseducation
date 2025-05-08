import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentRegistrationController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final addressController = TextEditingController();
  var selectedClass = RxString('');
  var isLoading = false.obs;

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    addressController.dispose();
    super.onClose();
  }

  Future<void> submitForm() async {
    if (formKey.currentState!.validate()) {
      try {
        isLoading(true);
        await FirebaseFirestore.instance.collection('student_registrations').add({
          'name': nameController.text,
          'phone': phoneController.text,
          'email': emailController.text,
          'class': selectedClass.value,
          'address': addressController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });
        
        Get.snackbar(
          'Success',
          'Form submitted successfully!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Clear form
        formKey.currentState!.reset();
        nameController.clear();
        phoneController.clear();
        emailController.clear();
        addressController.clear();
        selectedClass.value = '';
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to submit form: $e',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading(false);
      }
    }
  }
}
