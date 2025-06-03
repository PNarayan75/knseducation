import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ResultController extends GetxController {
  var results = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadResults();
  }

  void loadResults() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('results')
          .orderBy('rank')
          .get();

      results.value = snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    } catch (e) {
      print("Error loading results: $e");
    }
  }
}
