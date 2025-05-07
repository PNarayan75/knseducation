import 'package:flutter/material.dart';

class CertificationApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CertificationScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CertificationScreen extends StatefulWidget {
  @override
  _CertificationScreenState createState() => _CertificationScreenState();
}

class _CertificationScreenState extends State<CertificationScreen> {
 
  final List<Map<String, String>> certificates = [
    {'image': 'assets/images/banner1.jpg', 'name': 'Certificate A'},
    {'image': 'assets/images/banner2.jpg', 'name': 'Certificate B'},
    {'image': 'assets/images/banner3.jpg', 'name': 'Certificate C'},
    {'image': 'assets/images/banner4.jpg', 'name': 'Certificate D'},
  ];
  int index1 = 0;
  int index2 = 1;
  int index3 = 2;

  void rotateImages() {
    setState(() {
      index1 = (index1 + 1) % certificates.length;
      index2 = (index2 + 1) % certificates.length;
      index3 = (index3 + 1) % certificates.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            // Get.back();
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 50),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildCertificate(certificates[index1]['image'].toString()),
                    Expanded(
                      child: Transform.translate(
                        offset: Offset(0, -20),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            // color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.black, width: 1.2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(
                                  0.8,
                                ), // dark shadow
                                offset: Offset(3, 3),
                                blurRadius: 3,
                                spreadRadius: 1,
                              ),
                              BoxShadow(
                                color: Colors.white.withOpacity(
                                  0.9,
                                ), // white glow
                                offset: Offset(-2, -2),
                                blurRadius: 2,
                                spreadRadius: -1,
                              ),
                            ],
                          ),
                          child: Text(
                            "Design",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 20,
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),

                    _buildCertificate(certificates[index2]['image'].toString()),
                  ],
                ),

                const SizedBox(height: 20),

                Transform.translate(
                  offset: Offset(0, -40),
                  child: Center(
                    child: _buildCertificate1(
                      certificates[index3]['image'].toString(),
                     certificates[index3]['name'].toString(),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                ElevatedButton(
                  onPressed: rotateImages,
                  child: const Text("Next"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 12,
                    ),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCertificate(String imagePath) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.275,
      height: MediaQuery.of(context).size.width * 0.4,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            spreadRadius: 3,
            offset: const Offset(4, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            // The white screen part
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // screen area white
                borderRadius: BorderRadius.circular(24), // rounded corners
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            Positioned(
              top: -8,
              child: Container(
                width: 40,
                height: 6,
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificate1(String imagePath, String cert) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: MediaQuery.of(context).size.width * 0.4,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: Colors.grey.shade800,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 10,
            spreadRadius: 3,
            offset: const Offset(4, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white, // screen area white
                borderRadius: BorderRadius.circular(24), // rounded corners
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
            Positioned(
              top: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  cert,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
