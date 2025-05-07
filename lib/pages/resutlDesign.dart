import 'dart:async';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ResultSlider extends StatefulWidget {
  const ResultSlider({super.key});

  @override
  State<ResultSlider> createState() => _ResultSliderState();
}

class _ResultSliderState extends State<ResultSlider> with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> allResults = List.generate(20, (index) {
    return {
      'image': 'assets/images/student${(index % 4) + 1}.jpg', 
      'name': 'Student ${index + 1}',
      'rank': index + 1,
      'marks': 90 - (index % 10),
      'subject': ['Math', 'Science', 'English', 'History'][index % 4],
      'date': 'May ${2023 + (index ~/ 10)}'
    };
  });

  late final AnimationController _ctrl;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;
  late final ScrollController _scrollController;
  Timer? _autoSlideTimer;
  int _visibleCount = 10; // Number of results to show at once

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeOut));
    _fade = CurvedAnimation(parent: _ctrl, curve: Curves.easeIn);
    _scrollController = ScrollController();
    _ctrl.forward();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.offset;
        
        if (currentScroll >= maxScroll - 100) {
          // If near the end, scroll back to start
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        } else {
          // Scroll to next set of results
          _scrollController.animateTo(
            currentScroll + 300, // Adjust this value based on your item width
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  void _openFullScreenImage(String imagePath) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          body: Center(
            child: PhotoView(
              imageProvider: AssetImage(imagePath),
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    _scrollController.dispose();
    _autoSlideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / (_visibleCount * 0.8); // Adjust visible count
    
    return SlideTransition(
      position: _slide,
      child: FadeTransition(
        opacity: _fade,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(color: Colors.grey.shade300),
          ),
          margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Exam Results",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 180, // Fixed height for all result items
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: allResults.length,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: itemWidth,
                      child: GestureDetector(
                        onTap: () => _openFullScreenImage(allResults[index]['image']),
                        child: _buildResultItem(allResults[index]),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      _scrollController.animateTo(
                        _scrollController.offset - 300,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                  const SizedBox(width: 20),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: () {
                      _scrollController.animateTo(
                        _scrollController.offset + 300,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResultItem(Map<String, dynamic> result) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(result['image']),
            ),
            const SizedBox(height: 8),
            Text(
              result['name'],
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Rank: ${result['rank']}',
              style: const TextStyle(fontSize: 11),
            ),
            Text(
              'Marks: ${result['marks']}',
              style: const TextStyle(fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}