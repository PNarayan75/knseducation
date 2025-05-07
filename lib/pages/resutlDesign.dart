import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:photo_view/photo_view.dart';

class ResultSlider extends StatefulWidget {
  const ResultSlider({super.key});

  @override
  State<ResultSlider> createState() => _ResultSliderState();
}

class _ResultSliderState extends State<ResultSlider>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> allResults = List.generate(20, (index) {
    return {
      'image': 'assets/images/sir.jpg',
      'name': 'Student ${index + 1}',
      'rank': index + 1,
      'marks': 90 - (index % 10),
      'subject': ['Math', 'Science', 'English', 'History'][index % 4],
      'date': 'May ${2023 + (index ~/ 10)}',
      'accuracy': '${85 + (index % 15)}%',
      'attempted': '${45 - (index % 5)}/50',
      'timeSpent': '${120 - (index % 20)} mins',
    };
  });

  late final AnimationController _ctrl;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;
  late final ScrollController _scrollController;
  Timer? _autoSlideTimer;
  int _currentVisibleCount = 1;

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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateVisibleCount();
  }

  void _updateVisibleCount() {
    final screenWidth = MediaQuery.of(context).size.width;
    setState(() {
      if (screenWidth > 1200) {
        _currentVisibleCount = 4;
      } else if (screenWidth > 900) {
        _currentVisibleCount = 3;
      } else if (screenWidth > 600) {
        _currentVisibleCount = 2;
      } else {
        _currentVisibleCount = 1;
      }
    });
  }

  void _startAutoSlide() {
    _autoSlideTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (_scrollController.hasClients) {
        final maxScroll = _scrollController.position.maxScrollExtent;
        final currentScroll = _scrollController.offset;

        if (currentScroll >= maxScroll - 100) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        } else {
          _scrollController.animateTo(
            currentScroll + _getScrollAmount(),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeInOut,
          );
        }
      }
    });
  }

  double _getScrollAmount() {
    final screenWidth = MediaQuery.of(context).size.width;
    return (screenWidth / _currentVisibleCount) * 0.9;
  }

  void _openFullScreenResult(Map<String, dynamic> result) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: Text(result['name']),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 600,
              ),
              child: _buildFullResultItem(result),
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
    return LayoutBuilder(
      builder: (context, constraints) {
        // Update visible count when layout changes
        WidgetsBinding.instance
            .addPostFrameCallback((_) => _updateVisibleCount());

        return SlideTransition(
          position: _slide,
          child: FadeTransition(
            opacity: _fade,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 2,
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "IIT JEE Performance Analysis",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 380,
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: allResults.length,
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: MediaQuery.of(context).size.width /
                              _currentVisibleCount *
                              0.9,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: GestureDetector(
                              onTap: () =>
                                  _openFullScreenResult(allResults[index]),
                              child: _buildResultItem(allResults[index]),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back_ios, size: 24),
                          onPressed: () {
                            _scrollController.animateTo(
                              _scrollController.offset - _getScrollAmount(),
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                        const SizedBox(width: 20),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward_ios, size: 24),
                          onPressed: () {
                            _scrollController.animateTo(
                              _scrollController.offset + _getScrollAmount(),
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.easeInOut,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildResultItem(Map<String, dynamic> result) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: _buildResultContent(result),
    );
  }

  Widget _buildFullResultItem(Map<String, dynamic> result) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: _buildResultContentfullpage(result),
      ),
    );
  }

  Widget _buildResultContent(Map<String, dynamic> result,
      {bool isFullScreen = false}) {
    String preparationFeedback = _getPreparationFeedback(result['rank']);
    List<String> suggestions = _getSuggestions(result['rank']);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        backgroundColor: Colors.black,
                        appBar: AppBar(
                          backgroundColor: Colors.transparent,
                          leading: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        body: PhotoView(
                          imageProvider: AssetImage(result['image']),
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _getRankColor(result['rank']),
                      width: 3,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: isFullScreen ? 48 : 32,
                    backgroundColor: Colors.grey.shade100,
                    backgroundImage: AssetImage(result['image']),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Name and Rank
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isFullScreen ? 24 : 18,
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/rank.svg',
                              width: 40,
                              height: 40,
                           
                            ),
                            Text(
                              'Rank ${result['rank']}',
                              style: TextStyle(
                                fontSize: isFullScreen ? 20 : 16,
                                fontWeight: FontWeight.w600,
                                color: _getRankColor(result['rank']),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(Icons.score,
                                size: isFullScreen ? 24 : 20,
                                color: Colors.teal.shade700),
                            Text(
                              '${result['marks']} Marks',
                              style: TextStyle(
                                  fontSize: isFullScreen ? 20 : 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.teal.shade700),
                            ),
                          ],
                        )
                      ],
                    ),
                    if (isFullScreen) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Subject: ${result['subject']} • Date: ${result['date']}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Performance Summary',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: isFullScreen ? 18 : 15,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildStatItem(
                      'Accuracy',
                      result['accuracy'],
                      Icons.check,
                      isFullScreen: isFullScreen,
                    ),
                    _buildStatItem(
                      'Attempted',
                      result['attempted'],
                      Icons.checklist,
                      isFullScreen: isFullScreen,
                    ),
                    _buildStatItem(
                      'Time Spent',
                      result['timeSpent'],
                      Icons.timer,
                      isFullScreen: isFullScreen,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getFeedbackColor(result['rank']).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline,
                        size: isFullScreen ? 28 : 20,
                        color: _getFeedbackColor(result['rank'])),
                    const SizedBox(width: 8),
                    Text(
                      'Preparation Tips',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: _getFeedbackColor(result['rank']),
                        fontSize: isFullScreen ? 18 : 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  preparationFeedback,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: isFullScreen ? 16 : 14,
                  ),
                ),

                // if (suggestions.isNotEmpty) ...[
                //   const SizedBox(height: 12),
                //   Text(
                //     'Suggested Actions:',
                //     style: TextStyle(
                //       fontWeight: FontWeight.w600,
                //       fontSize: isFullScreen ? 16 : 13,
                //     ),
                //   ),
                //   const SizedBox(height: 8),
                //   ...suggestions.map((suggestion) => Padding(
                //     padding: const EdgeInsets.only(left: 8, bottom: 4),
                //     child: Row(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         const Text('• '),
                //         Expanded(
                //           child: Text(
                //             suggestion,
                //             style: TextStyle(
                //               fontSize: isFullScreen ? 15 : 13,
                //               height: 1.4,
                //             ),
                //           ),
                //         ),
                //       ],
                //     ),
                //   )).toList(),
                // ],
              ],
            ),
          ),
        ),
        if (isFullScreen) ...[
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // Action for detailed analysis
              },
              child: const Text(
                'View Detailed Analysis',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildResultContentfullpage(Map<String, dynamic> result,
      {bool isFullScreen = false}) {
    String preparationFeedback = _getPreparationFeedback(result['rank']);
    List<String> suggestions = _getSuggestions(result['rank']);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        backgroundColor: Colors.black,
                        appBar: AppBar(
                          backgroundColor: Colors.transparent,
                          leading: IconButton(
                            icon: const Icon(Icons.arrow_back,
                                color: Colors.white),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ),
                        body: PhotoView(
                          imageProvider: AssetImage(result['image']),
                        ),
                      ),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: _getRankColor(result['rank']),
                      width: 3,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: isFullScreen ? 48 : 32,
                    backgroundColor: Colors.grey.shade100,
                    backgroundImage: AssetImage(result['image']),
                  ),
                ),
              ),
              const SizedBox(width: 16),

              // Name and Rank
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isFullScreen ? 24 : 18,
                        color: Colors.indigo,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.emoji_events,
                            size: isFullScreen ? 24 : 20,
                            color: _getRankColor(result['rank'])),
                        const SizedBox(width: 8),
                        Text(
                          'Rank ${result['rank']}',
                          style: TextStyle(
                            fontSize: isFullScreen ? 20 : 16,
                            fontWeight: FontWeight.w600,
                            color: _getRankColor(result['rank']),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Icon(Icons.score,
                            size: isFullScreen ? 24 : 20,
                            color: Colors.teal.shade700),
                        const SizedBox(width: 8),
                        Text(
                          '${result['marks']} Marks',
                          style: TextStyle(
                              fontSize: isFullScreen ? 20 : 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.teal.shade700),
                        ),
                      ],
                    ),
                    if (isFullScreen) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Subject: ${result['subject']} • Date: ${result['date']}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Performance Summary',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: isFullScreen ? 18 : 15,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildStatItem(
                      'Accuracy',
                      result['accuracy'],
                      Icons.check,
                      isFullScreen: isFullScreen,
                    ),
                    _buildStatItem(
                      'Attempted',
                      result['attempted'],
                      Icons.checklist,
                      isFullScreen: isFullScreen,
                    ),
                    _buildStatItem(
                      'Time Spent',
                      result['timeSpent'],
                      Icons.timer,
                      isFullScreen: isFullScreen,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _getFeedbackColor(result['rank']).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.lightbulb_outline,
                        size: isFullScreen ? 28 : 20,
                        color: _getFeedbackColor(result['rank'])),
                    const SizedBox(width: 8),
                    Text(
                      'Preparation Tips',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: _getFeedbackColor(result['rank']),
                        fontSize: isFullScreen ? 18 : 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  preparationFeedback,
                  style: TextStyle(
                    height: 1.5,
                    fontSize: isFullScreen ? 16 : 14,
                  ),
                ),
                if (suggestions.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    'Suggested Actions:',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: isFullScreen ? 16 : 13,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...suggestions
                      .map((suggestion) => Padding(
                            padding: const EdgeInsets.only(left: 8, bottom: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('• '),
                                Expanded(
                                  child: Text(
                                    suggestion,
                                    style: TextStyle(
                                      fontSize: isFullScreen ? 15 : 13,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ))
                      .toList(),
                ],
              ],
            ),
          ),
        ),
        if (isFullScreen) ...[
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: () {
                // Action for detailed analysis
              },
              child: const Text(
                'View Detailed Analysis',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildStatItem(String title, String value, IconData icon,
      {bool isFullScreen = false}) {
    return Expanded(
      child: Column(
        children: [
          // Icon(icon, size: isFullScreen ? 28 : 20, color: Colors.blueGrey),
          // const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: isFullScreen ? 18 : 14,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: isFullScreen ? 14 : 12,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  String _getPreparationFeedback(int rank) {
    if (rank <= 3) {
      return 'Excellent performance! Your consistent revision and focused practice are yielding great results. Maintain this momentum while paying special attention to any remaining weak areas.';
    } else if (rank <= 10) {
      return 'Good work! You\'re on the right track. To move into the top ranks, focus on solving more previous year papers under timed conditions to improve both speed and accuracy.';
    } else {
      return 'Solid foundation detected but needs more strategic preparation. Focus on conceptual understanding through NCERT and reference books. Create and stick to a structured study schedule.';
    }
  }

  List<String> _getSuggestions(int rank) {
    if (rank <= 3) {
      return [
        'Continue advanced problem solving (2 hours daily)',
        'Weekly mock tests under exam conditions',
        'Focus on time management strategies'
      ];
    } else if (rank <= 10) {
      return [
        'Solve 5 extra challenging problems daily',
        'Join peer study group for collaborative learning',
        'Analyze mistakes from previous tests weekly'
      ];
    } else {
      return [
        'Create and follow a strict study timetable',
        'Focus on NCERT fundamentals before advanced topics',
        'Practice 10 numerical problems daily'
      ];
    }
  }

  Color _getRankColor(int rank) {
    if (rank == 1) return Colors.amber.shade700;
    if (rank <= 3) return Colors.orange.shade700;
    if (rank <= 10) return Colors.teal.shade700;
    return Colors.blueGrey;
  }

  Color _getFeedbackColor(int rank) {
    if (rank <= 3) return Colors.green.shade700;
    if (rank <= 10) return Colors.blue.shade700;
    return Colors.orange.shade700;
  }
}
