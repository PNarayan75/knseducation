import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_website/components/components.dart';
import 'package:flutter_website/pages/studentRegistrationform.dart';
import 'package:flutter_website/utils/utils.dart';
import 'package:get/route_manager.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:universal_io/io.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebsiteMenuBar extends StatelessWidget {
  const WebsiteMenuBar({super.key});

  @override
  Widget build(BuildContext context) {
    const Color navLinkColor = Color(0xFF6E7274);
    return Container(
      height: 66,
      decoration: const BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(color: Color(0x1A000000), offset: Offset(0, 2), blurRadius: 4)
      ]),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Icon(Icons.menu, color: textPrimary, size: 28)),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () =>
                  Navigator.of(context).popUntil((route) => route.isFirst),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 16, 5),
                child: Image.asset("assets/images/logo.png",
                    height: 47, fit: BoxFit.contain),
              ),
            ),
          ),
          const Spacer(),
          ResponsiveVisibility(
            visible: false,
            visibleConditions: const [Condition.largerThan(name: MOBILE)],
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                // onTap: () => openUrl("https://flutter.dev/docs"),
                onTap: () {},
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text("",
                      style: TextStyle(
                          fontSize: 16,
                          color: navLinkColor,
                          fontFamily: fontFamily)),
                ),
              ),
            ),
          ),
          // ResponsiveVisibility(
          //   visible: false,
          //   visibleConditions: const [Condition.largerThan(name: MOBILE)],
          //   child: MouseRegion(
          //     cursor: SystemMouseCursors.click,
          //     child: GestureDetector(
          //       onTap: () {},
          //       child: const Padding(
          //         padding: EdgeInsets.symmetric(horizontal: 16),
          //         child: Text("Showcase",
          //             style: TextStyle(
          //                 fontSize: 16,
          //                 color: navLinkColor,
          //                 fontFamily: fontFamily)),
          //       ),
          //     ),
          //   ),
          // ),
          // ResponsiveVisibility(
          //   visible: false,
          //   visibleConditions: const [Condition.largerThan(name: MOBILE)],
          //   child: MouseRegion(
          //     cursor: SystemMouseCursors.click,
          //     child: GestureDetector(
          //       onTap: () {},
          //       child: const Padding(
          //           padding: EdgeInsets.symmetric(horizontal: 16),
          //           child: Text("Community",
          //               style: TextStyle(
          //                   fontSize: 16,
          //                   color: navLinkColor,
          //                   fontFamily: fontFamily))),
          //     ),
          //   ),
          // ),
          const ResponsiveVisibility(
            visible: false,
            visibleConditions: [Condition.largerThan(name: MOBILE)],
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: ImageIcon(
                    AssetImage("assets/images/icon_search_64x.png"),
                    color: navLinkColor,
                    size: 24),
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ImageIcon(
                    AssetImage("assets/images/icon_twitter_64x.png"),
                    color: navLinkColor,
                    size: 24),
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ImageIcon(
                    AssetImage("assets/images/icon_youtube_64x.png"),
                    color: navLinkColor,
                    size: 24),
              ),
            ),
          ),
          MouseRegion(
            cursor: SystemMouseCursors.click,
            child: GestureDetector(
              onTap: () {},
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ImageIcon(
                    AssetImage("assets/images/icon_github_64x.png"),
                    color: navLinkColor,
                    size: 24),
              ),
            ),
          ),
          ResponsiveVisibility(
            visible: false,
            visibleConditions: const [Condition.largerThan(name: MOBILE)],
            child: Padding(
              padding: const EdgeInsets.only(left: 8, right: 0),
              child: TextButton(
                onPressed: () {
                  print("onpressed ");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => StudentRegistrationForm()),
                  );
                },
                style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all<Color>(primary),
                    overlayColor: WidgetStateProperty.resolveWith<Color>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.hovered)) {
                          return buttonPrimaryDark;
                        }
                        if (states.contains(WidgetState.focused) ||
                            states.contains(WidgetState.pressed)) {
                          return buttonPrimaryDarkPressed;
                        }
                        return primary;
                      },
                    ),
                    // Shape sets the border radius from default 3 to 0.
                    shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
                      (Set<WidgetState> states) {
                        if (states.contains(WidgetState.focused) ||
                            states.contains(WidgetState.pressed)) {
                          return const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)));
                        }
                        return const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(0)));
                      },
                    ),
                    padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                        const EdgeInsets.symmetric(
                            vertical: 22, horizontal: 28)),
                    // Side adds pressed highlight outline.
                    side: WidgetStateProperty.resolveWith<BorderSide>(
                        (Set<WidgetState> states) {
                      if (states.contains(WidgetState.focused) ||
                          states.contains(WidgetState.pressed)) {
                        return const BorderSide(
                            width: 3, color: buttonPrimaryPressedOutline);
                      }
                      // Transparent border placeholder as Flutter does not allow
                      // negative margins.
                      return const BorderSide(width: 3, color: Colors.white);
                    })),
                child: Text(
                  "Get started",
                  style: buttonTextStyle.copyWith(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class GetStarted extends StatelessWidget {
//   const GetStarted({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(24),
//       padding: const EdgeInsets.all(32),
//       decoration: BoxDecoration(
//         gradient: const LinearGradient(
//           colors: [Color(0xFFB388F4), Color(0xFF8E24AA)],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//         borderRadius: BorderRadius.circular(16),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.15),
//             blurRadius: 10,
//             offset: const Offset(0, 4),
//           )
//         ],
//       ),
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Text(
//             "Don't Miss This Opportunity!",
//             textAlign: TextAlign.center,
//             style: TextStyle(
//               fontSize: 28,
//               fontWeight: FontWeight.bold,
//               color: Colors.white,
//             ),
//           ),
//           const SizedBox(height: 16),
//           Text(
//             "Join hundreds of successful students who have transformed their JEE preparation journey.",
//             textAlign: TextAlign.center,
//             style: const TextStyle(
//               fontSize: 18,
//               color: Colors.white70,
//             ),
//           ),
//           const SizedBox(height: 32),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (_) => const StudentRegistrationForm()),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               backgroundColor: const Color(0xFF4CAF50),
//               padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(30),
//               ),
//               elevation: 5,
//             ),
//             child: const Text(
//               'Register Now - It\'s Free!',
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.white,
//                 letterSpacing: 1.1,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

class GetStarted extends StatefulWidget {
  const GetStarted({super.key});

  @override
  State<GetStarted> createState() => _GetStartedState();
}

class _GetStartedState extends State<GetStarted>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

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
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slide,
      child: FadeTransition(
          opacity: _fade,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: border)),
            margin: blockMargin,
            padding: const EdgeInsets.all(40),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 780),
                child: Column(
                  children: [
                    Text(
                      "Don't Miss This Opportunity!",
                      textAlign: TextAlign.center,
                      style: headlineSecondaryTextStyle.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Join hundreds of successful students who have transformed their JEE preparation journey.",
                      textAlign: TextAlign.center,
                      style: bodyTextStyle.copyWith(
                        fontSize: 18,
                        color: Colors.black54,
                      ),
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const StudentRegistrationForm(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 32),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      child: Text(
                        "Register Now - It's Free!",
                        style: buttonTextStyle.copyWith(
                            fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class KnowYourMentor extends StatefulWidget {
  const KnowYourMentor({super.key});

  @override
  State<KnowYourMentor> createState() => _KnowYourMentorState();
}

class _KnowYourMentorState extends State<KnowYourMentor>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<Offset> _slide;
  late final Animation<double> _fade;

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
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slide,
      child: FadeTransition(
          opacity: _fade,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: border)),
            margin: blockMargin,
            padding: const EdgeInsets.all(40),
            child: Align(
              alignment: Alignment.center,
              child: Container(
                constraints: const BoxConstraints(maxWidth: 780),
                child: Column(
                  children: [
                    Text(
                      "Know your Mentor",
                      textAlign: TextAlign.center,
                      style: headlineSecondaryTextStyle.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: Colors.deepPurple,
                            width: 2.0,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        margin: const EdgeInsets.all(20),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.blueAccent.withOpacity(0.5),
                                  width: 3.0,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 10,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  const CircleAvatar(
                                    radius: 50,
                                    backgroundImage:
                                        AssetImage('assets/images/sir.jpg'),
                                  ),
                                  Container(
                                    width: 100,
                                    height: 100,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      gradient: LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Colors.transparent,
                                          Colors.black.withOpacity(0.4),
                                        ],
                                      ),
                                    ),
                                  ),
                                  // const Positioned(
                                  //   bottom: 8,
                                  //   child: Text(
                                  //     "Professor",
                                  //     style: TextStyle(
                                  //       color: Colors.white,
                                  //       fontSize: 14,
                                  //       fontWeight: FontWeight.bold,
                                  //       shadows: [
                                  //         Shadow(
                                  //           blurRadius: 5,
                                  //           color: Colors.black,
                                  //           offset: Offset(1, 1),
                                  //         ),
                                  //       ],
                                  //     ),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text(
                              'Er. Alok Singh',
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Educator | Mentor',
                              style: TextStyle(color: Colors.grey),
                            ),
                            const Divider(height: 30, thickness: 1),
                            const InfoRow(
                              title: 'Qualification',
                              value:
                                  'B.Tech in Electrical Engineering from MNIT, Jaipur',
                            ),
                            const InfoRow(
                              title: 'Experience',
                              value: '25+ years of teaching excellence',
                            ),
                            const InfoRow(
                              title: 'Previous Role',
                              value:
                                  'Head of Dept., Mathematics, Career Point, Jaipur',
                            ),
                            const InfoRow(
                              title: 'Passion',
                              value:
                                  'Inspiring and empowering students in their academic journey',
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class InfoRow extends StatefulWidget {
  final String title;
  final String value;

  const InfoRow({super.key, required this.title, required this.value});

  @override
  State<InfoRow> createState() => _InfoRowState();
}

class _InfoRowState extends State<InfoRow> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovering = true),
      onExit: (_) => setState(() => _isHovering = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: _isHovering ? Colors.deepPurple.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: _isHovering ? Colors.deepPurple : Colors.grey.shade300,
            width: 1.5,
          ),
          boxShadow: _isHovering
              ? [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.2),
                    blurRadius: 6,
                    offset: const Offset(0, 3),
                  )
                ]
              : [],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline, color: Colors.deepPurple),
            const SizedBox(width: 8),
            // Use Expanded or Flexible to wrap long text
            Expanded(
              child: Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${widget.title}: ',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.deepPurple,
                        fontSize: 16,
                      ),
                    ),
                    TextSpan(
                      text: widget.value,
                      style: const TextStyle(
                        color: Colors.black87,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class Features extends StatelessWidget {
//   const Features({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(4),
//           border: Border.all(color: border)),
//       margin: blockMargin,
//       child: ResponsiveRowColumn(
//         layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
//             ? ResponsiveRowColumnType.COLUMN
//             : ResponsiveRowColumnType.ROW,
//         rowCrossAxisAlignment: CrossAxisAlignment.start,
//         columnCrossAxisAlignment: CrossAxisAlignment.center,
//         columnMainAxisSize: MainAxisSize.min,
//         rowPadding: const EdgeInsets.symmetric(horizontal: 80, vertical: 80),
//         columnPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 50),
//         columnSpacing: 50,
//         rowSpacing: 50,
//         children: [

//         ],
//       ),
//     );
//   }
// }

// Widget _buildCertificate(String imagePath) {
//   double screenWidth = MediaQuery.of(context).size.width;
//   double certificateWidth = screenWidth > 1000 ? 200 : screenWidth * 0.2;
//   double certificateHeight = certificateWidth * 1.5;
//   return Container(
//     width: certificateWidth,
//     height: certificateHeight,
//     margin: const EdgeInsets.symmetric(horizontal: 5),
//     decoration: BoxDecoration(
//       color: Colors.grey.shade800,
//       borderRadius: BorderRadius.circular(30),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.4),
//           blurRadius: 10,
//           spreadRadius: 3,
//           offset: const Offset(4, 6),
//         ),
//       ],
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(6.0),
//       child: Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(24),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(24),
//               child: Image.asset(
//                 imagePath,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: double.infinity,
//               ),
//             ),
//           ),
//           Positioned(
//             top: -8,
//             child: Container(
//               width: 40,
//               height: 6,
//               decoration: BoxDecoration(
//                 color: Colors.grey.shade800,
//                 borderRadius: BorderRadius.circular(3),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

// Widget _buildCertificate1(String imagePath, String cert) {
//   double screenWidth = MediaQuery.of(context).size.width;
//   double certificateWidth = screenWidth > 1000 ? 200 : screenWidth * 0.3;
//   double certificateHeight = certificateWidth * 1.5;
//   return Container(
//     width: certificateWidth,
//     height: certificateHeight,
//     margin: const EdgeInsets.symmetric(horizontal: 5),
//     decoration: BoxDecoration(
//       color: Colors.grey.shade800,
//       borderRadius: BorderRadius.circular(30),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.4),
//           blurRadius: 10,
//           spreadRadius: 3,
//           offset: const Offset(4, 6),
//         ),
//       ],
//     ),
//     child: Padding(
//       padding: const EdgeInsets.all(6.0),
//       child: Stack(
//         alignment: Alignment.topCenter,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(24),
//             ),
//             child: ClipRRect(
//               borderRadius: BorderRadius.circular(24),
//               child: Image.asset(
//                 imagePath,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//                 height: double.infinity,
//               ),
//             ),
//           ),
//           Positioned(
//             top: 8,
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//               decoration: BoxDecoration(
//                 color: Colors.black.withOpacity(0.7),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: Text(
//                 cert,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 12,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     ),
//   );
// }

Widget buildMaterialIconCircle(String assetPath, double size) {
  return Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
      color: Colors.grey[200],
      shape: BoxShape.circle,
    ),
    child: Center(
      child: Image.asset(
        assetPath,
        width: size * 0.6,
        height: size * 0.6,
      ),
    ),
  );
}

class BeautifulUI extends StatefulWidget {
  const BeautifulUI({super.key});

  @override
  State<BeautifulUI> createState() => _BeautifulUIState();
}

class _BeautifulUIState extends State<BeautifulUI> {
  late VideoPlayerController videoController;
  late Future<void> initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    videoController =
        VideoPlayerController.asset("assets/videos/BeautifulUI.mp4");
    videoController.setVolume(0);
    videoController.setLooping(true);
    initializeVideoPlayerFuture = videoController.initialize().then((_) {
      if (mounted) {
        // Display the first frame of the video before playback.
        setState(() {});
        videoPlay();
      }
    });
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  void videoPlay() {
    videoController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: border)),
      margin: blockMargin,
      padding: blockPadding(context),
      child: ResponsiveRowColumn(
        layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveRowColumnItem(
            rowFlex: 1,
            columnOrder: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 32, 25, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: buildMaterialIconCircle(
                        "assets/images/icon_ui.png", 68),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 32),
                    child: Text("Expressive, beautiful UIs",
                        style: headlineTextStyle),
                  ),
                  RichText(
                    text: TextSpan(
                      style: bodyTextStyle,
                      children: [
                        const TextSpan(
                            text:
                                "Delight your users with Flutter's built-in beautiful Material Design and Cupertino (iOS-flavor) widgets, rich motion APIs, smooth natural scrolling, and platform awareness."),
                        const TextSpan(text: "\n\n"),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                openUrl(
                                    "https://flutter.dev/docs/development/ui/widgets/catalog");
                              },
                            text: "Browse the widget catalog",
                            style: bodyLinkTextStyle),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          ResponsiveRowColumnItem(
            rowFlex: 2,
            columnOrder: 1,
            child: FutureBuilder(
              future: initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the VideoPlayerController has finished initialization, use
                  // the data it provides to limit the aspect ratio of the VideoPlayer.
                  return AspectRatio(
                    aspectRatio: videoController.value.aspectRatio,
                    child: RepaintBoundary(child: VideoPlayer(videoController)),
                  );
                } else {
                  // If the VideoPlayerController is still initializing, show a
                  // loading spinner.
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class NativePerformance extends StatefulWidget {
  const NativePerformance({super.key});

  @override
  State<NativePerformance> createState() => _NativePerformanceState();
}

class _NativePerformanceState extends State<NativePerformance> {
  late VideoPlayerController videoController;
  late Future<void> initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    videoController =
        VideoPlayerController.asset("assets/videos/NativePerformance.mp4");
    videoController.setVolume(0);
    videoController.setLooping(true);
    initializeVideoPlayerFuture = videoController.initialize().then((_) {
      if (mounted) {
        // Display the first frame of the video before playback.
        setState(() {});
        videoPlay();
      }
    });
  }

  @override
  void dispose() {
    videoController.dispose();
    super.dispose();
  }

  void videoPlay() {
    videoController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: border)),
      margin: blockMargin,
      padding: blockPadding(context),
      child: ResponsiveRowColumn(
        layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveRowColumnItem(
            rowFlex: 2,
            child: FutureBuilder(
              future: initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If the VideoPlayerController has finished initialization, use
                  // the data it provides to limit the aspect ratio of the VideoPlayer.
                  return AspectRatio(
                    aspectRatio: videoController.value.aspectRatio,
                    child: RepaintBoundary(child: VideoPlayer(videoController)),
                  );
                } else {
                  // If the VideoPlayerController is still initializing, show a
                  // loading spinner.
                  return Container();
                }
              },
            ),
          ),
          ResponsiveRowColumnItem(
            rowFlex: 1,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 32, 25, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: buildMaterialIconCircle(
                        "assets/images/icon_performance.png", 68),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 32),
                    child: Text("Native Performance", style: headlineTextStyle),
                  ),
                  RichText(
                    text: TextSpan(
                      style: bodyTextStyle,
                      children: [
                        const TextSpan(
                            text:
                                "Flutter’s widgets incorporate all critical platform differences such as scrolling, navigation, icons and fonts to provide full native performance on both iOS and Android."),
                        const TextSpan(text: "\n\n"),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                openUrl("https://flutter.dev/showcase");
                              },
                            text: "Examples of apps built with Flutter",
                            style: bodyLinkTextStyle),
                        const TextSpan(text: "\n\n"),
                        TextSpan(
                            text: "Demo design inspired by ",
                            style: bodyTextStyle.copyWith(fontSize: 12)),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                openUrl("https://dribbble.com/aureliensalomon");
                              },
                            text: "Aurélien Salomon",
                            style: bodyTextStyle.copyWith(
                                fontSize: 12, color: primary)),
                        TextSpan(
                            text: "'s ",
                            style: bodyTextStyle.copyWith(fontSize: 12)),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                openUrl(
                                    "https://dribbble.com/shots/2940231-Google-Newsstand-Navigation-Pattern");
                              },
                            text: "Google Newsstand Navigation Pattern",
                            style: bodyTextStyle.copyWith(
                                fontSize: 12, color: primary)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class LearnFromDevelopers extends StatefulWidget {
  const LearnFromDevelopers({super.key});

  @override
  State<LearnFromDevelopers> createState() => _LearnFromDevelopersState();
}

class _LearnFromDevelopersState extends State<LearnFromDevelopers> {
  final String videoUrl = "https://www.youtube.com/embed/W1pNjxmNHNQ";
  final double videoAspectRatio = 1.78;
  UniqueKey webViewKey = UniqueKey();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: border)),
      margin: blockMargin,
      padding: blockPadding(context),
      child: ResponsiveRowColumn(
        layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveRowColumnItem(
            rowFlex: 1,
            columnOrder: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 32, 25, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 32),
                    child:
                        Text("Learn from developers", style: headlineTextStyle),
                  ),
                  RichText(
                    text: TextSpan(
                      style: bodyTextStyle,
                      children: [
                        const TextSpan(
                            text:
                                "Watch these videos to learn from Google and developers as you build with Flutter."),
                        const TextSpan(text: "\n\n"),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                openUrl("https://www.youtube.com/flutterdev");
                              },
                            text: "Visit our YouTube playlist",
                            style: bodyLinkTextStyle),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          ResponsiveRowColumnItem(
            rowFlex: 2,
            columnOrder: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: AspectRatio(
                aspectRatio: videoAspectRatio,
                child: (kIsWeb || Platform.isAndroid || Platform.isIOS)
                    ? WebViewWidget(
                        key: webViewKey,
                        controller: WebViewController()
                          ..loadRequest(Uri.parse(videoUrl)),
                      )
                    : Image.asset(
                        "assets/images/video_thumbnail_learn_from_developers.png",
                        fit: BoxFit.contain)
                // TODO: Legacy WebView on Web workarounds.
//                HtmlElementView(
//                        key: webViewKey,
//                        viewType: webViewKey.toString(),
//                      )
                ,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WhoUsesFlutter extends StatelessWidget {
  const WhoUsesFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: border)),
      margin: blockMargin,
      padding: blockPadding(context),
      child: ResponsiveRowColumn(
        layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        rowCrossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ResponsiveRowColumnItem(
            rowFlex: 5,
            columnOrder: 2,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(25, 24, 25, 0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child:
                        Text("Who's using Flutter?", style: headlineTextStyle),
                  ),
                  RichText(
                    text: TextSpan(
                      style: bodyTextStyle,
                      children: [
                        const TextSpan(
                            text:
                                "Organizations around the world are building apps with Flutter."),
                        const TextSpan(text: "\n\n"),
                        TextSpan(
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                openUrl("https://flutter.dev/showcase");
                              },
                            text: "See what’s being created",
                            style: bodyLinkTextStyle),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          ResponsiveRowColumnItem(
              rowFlex: 7,
              columnOrder: 1,
              child: Image.asset("assets/images/companies_using_flutter.png",
                  fit: BoxFit.contain)),
        ],
      ),
    );
  }
}

class FlutterNewsRow extends StatelessWidget {
  const FlutterNewsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: blockMargin,
      child: ResponsiveRowColumn(
        layout: ResponsiveBreakpoints.of(context).smallerThan(DESKTOP)
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        rowCrossAxisAlignment: CrossAxisAlignment.start,
        rowSpacing: 25,
        columnSpacing: 32,
        children: const [
          ResponsiveRowColumnItem(
            rowFlex: 1,
            rowFit: FlexFit.tight,
            child: FlutterNewsCard(
              title: "Announcing Flutter 1.12",
              imagePath: "assets/images/news_flutter_1.12.png",
              linkUrl:
                  "https://developers.googleblog.com/2019/12/flutter-ui-ambient-computing.html",
            ),
          ),
          ResponsiveRowColumnItem(
            rowFlex: 1,
            rowFit: FlexFit.tight,
            child: FlutterNewsCard(
              title: "CodePen now supports Flutter",
              imagePath: "assets/images/news_flutter_codepen.png",
              linkUrl:
                  "https://medium.com/flutter/announcing-codepen-support-for-flutter-bb346406fe50",
            ),
          ),
        ],
      ),
    );
  }
}

class FlutterNewsCard extends StatelessWidget {
  final String title;
  final String imagePath;
  final String linkUrl;

  const FlutterNewsCard(
      {super.key,
      required this.title,
      required this.imagePath,
      required this.linkUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: border)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            constraints: const BoxConstraints(maxHeight: 400),
            child: Image.asset(imagePath, fit: BoxFit.fitWidth),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text("News",
                      style: bodyTextStyle.copyWith(
                          fontSize: 12, color: const Color(0xFF6C757D))),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(title, style: headlineSecondaryTextStyle),
                ),
                GestureDetector(
                  onTap: () => openUrl(linkUrl),
                  child: Text("Read More", style: bodyLinkTextStyle),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FlutterCodelab extends StatefulWidget {
  const FlutterCodelab({super.key});

  @override
  State<FlutterCodelab> createState() => _FlutterCodelabState();
}

class _FlutterCodelabState extends State<FlutterCodelab>
    with AutomaticKeepAliveClientMixin<FlutterCodelab> {
  static List<String> codelabIds = ["Spinning Flutter", "Fibonacci", "Counter"];
  static List<String> codelabUrls = [
    "https://dartpad.dev/embed-flutter.html?id=c0450ca427127acfb710a31c99761f1a",
    "https://dartpad.dev/embed-flutter.html?id=38311b87e4b3c76329812077c82323b4",
    "https://dartpad.dev/embed-flutter.html?id=7b5710b344431457753253625a596158"
  ];
  String codelabSelected = codelabIds[0];
  String codelabUrlSelected = codelabUrls[0];
  final double videoAspectRatio = 1.75;

  late Map<String, Widget> codelabExamples;
  UniqueKey webViewKey = UniqueKey();

  @override
  void initState() {
    super.initState();
    codelabExamples = <String, Widget>{
      codelabIds[0]: getCupertinoSelectionWidget(codelabIds[0]),
      codelabIds[1]: getCupertinoSelectionWidget(codelabIds[1]),
      codelabIds[2]: getCupertinoSelectionWidget(codelabIds[2]),
    };
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: border)),
      margin: blockMargin,
      padding: blockPadding(context),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text("Try Flutter in your browser",
                    style: headlineTextStyle),
              ),
              CupertinoSlidingSegmentedControl(
                groupValue: codelabSelected,
                onValueChanged: (dynamic value) => setCodelabSelected(value),
                children: codelabExamples,
              ),
              RepaintBoundary(
                key: webViewKey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(25, 16, 25, 16),
                  child: AspectRatio(
                    aspectRatio: videoAspectRatio,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFFD3D3D3), width: 1),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(0)),
                      ),
                      child: WebViewWidget(
                        key: webViewKey,
                        controller: WebViewController()
                          ..loadRequest(Uri.parse(codelabUrlSelected)),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 16),
                child: RichText(
                  text: TextSpan(
                    style: headlineSecondaryTextStyle,
                    children: [
                      const TextSpan(text: "Want more practice? "),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              openUrl("https://flutter.dev/codelabs");
                            },
                          text: "Try a codelab",
                          style: headlineSecondaryTextStyle.copyWith(
                              color: primary)),
                      const TextSpan(text: ".")
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;

  void setCodelabSelected(String codelab) {
    codelabSelected = codelab;
    codelabUrlSelected = codelabUrls[codelabIds.indexOf(codelab)];
    setState(() {});
  }

  Widget getCupertinoSelectionWidget(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Text(text, style: bodyTextStyle),
    );
  }
}

class InstallFlutter extends StatelessWidget {
  const InstallFlutter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: border)),
      margin: blockMargin,
      padding: blockPadding(context),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          constraints: const BoxConstraints(maxWidth: 800),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 16),
                child: Text("Install Flutter today.", style: headlineTextStyle),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text("It’s free and open source.",
                    style: bodyTextStyle.copyWith(fontSize: 24)),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32),
                child: TextButton(
                  onPressed: () =>
                      openUrl("https://flutter.dev/docs/get-started/install"),
                  style: ButtonStyle(
                      backgroundColor: WidgetStateProperty.all<Color>(primary),
                      overlayColor: WidgetStateProperty.resolveWith<Color>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.hovered)) {
                            return buttonPrimaryDark;
                          }
                          if (states.contains(WidgetState.focused) ||
                              states.contains(WidgetState.pressed)) {
                            return buttonPrimaryDarkPressed;
                          }
                          return primary;
                        },
                      ),
                      // Shape sets the border radius from default 3 to 0.
                      shape: WidgetStateProperty.resolveWith<OutlinedBorder>(
                        (Set<WidgetState> states) {
                          if (states.contains(WidgetState.focused) ||
                              states.contains(WidgetState.pressed)) {
                            return const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(0)));
                          }
                          return const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(0)));
                        },
                      ),
                      padding: WidgetStateProperty.all<EdgeInsetsGeometry>(
                          const EdgeInsets.symmetric(
                              vertical: 32, horizontal: 90)),
                      // Side adds pressed highlight outline.
                      side: WidgetStateProperty.resolveWith<BorderSide>(
                          (Set<WidgetState> states) {
                        if (states.contains(WidgetState.focused) ||
                            states.contains(WidgetState.pressed)) {
                          return const BorderSide(
                              width: 3, color: buttonPrimaryPressedOutline);
                        }
                        // Transparent border placeholder as Flutter does not allow
                        // negative margins.
                        return const BorderSide(width: 3, color: Colors.white);
                      })),
                  child: Text(
                    "Get started",
                    style: buttonTextStyle.copyWith(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundDark,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
      width: double.infinity,
      child: ResponsiveRowColumn(
        layout: ResponsiveBreakpoints.of(context).isMobile
            ? ResponsiveRowColumnType.COLUMN
            : ResponsiveRowColumnType.ROW,
        columnSpacing: 20,
        rowSpacing: 40,
        children: [
          ResponsiveRowColumnItem(
            rowFlex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "assets/images/logo.png",
                  height: 60,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 12),
                Text(
                  "Empowering students to achieve academic excellence.",
                  style: bodyTextStyle.copyWith(
                      fontSize: 14, color: Colors.white70, height: 1.5),
                ),
              ],
            ),
          ),
          ResponsiveRowColumnItem(
            rowFlex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _footerLink("Courses", "/courses"),
                _footerLink("About Us", "/about"),
                _footerLink("Contact", "/contact"),
                _footerLink("Terms & Conditions", "/terms"),
              ],
            ),
          ),
          ResponsiveRowColumnItem(
            rowFlex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Contact Us",
                  style: bodyTextStyle.copyWith(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _contactRow(Icons.phone, "+91 98765 43210"),
                _contactRow(Icons.email, "info@coachinginstitute.com"),
                _contactRow(Icons.location_on, "123, ABC Road, Prayagraj"),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _socialIcon(Icons.search, "https://wa.me/919876543210"),
                    const SizedBox(width: 10),
                    _socialIcon(Icons.play_circle_fill,
                        "https://youtube.com/coachingchannel"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _footerLink(String text, String route) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GestureDetector(
        onTap: () {},
        child: Text(
          text,
          style: bodyTextStyle.copyWith(
              fontSize: 14,
              color: Colors.white.withOpacity(0.85),
              decoration: TextDecoration.underline),
        ),
      ),
    );
  }

  Widget _contactRow(IconData icon, String info) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.white70),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              info,
              style:
                  bodyTextStyle.copyWith(fontSize: 13, color: Colors.white70),
            ),
          ),
        ],
      ),
    );
  }

  Widget _socialIcon(IconData icon, String url) {
    return InkWell(
      onTap: () => openUrl(url),
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white10,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.white, size: 20),
      ),
    );
  }
}
