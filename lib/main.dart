import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_website/firebase_options.dart';
import 'package:flutter_website/pages/blinkbutton.dart';
import 'package:flutter_website/pages/contact_us.dart';
import 'package:flutter_website/pages/resutlDesign.dart';
import 'package:flutter_website/pages/studentRegistrationform.dart';
import 'package:flutter_website/pages/testcirclepage.dart';
import 'package:flutter_website/test.dart';
import 'package:url_launcher/url_launcher.dart'; // for launching URLs

import 'package:flutter_website/components/colors.dart';
import 'package:flutter_website/ui/block_wrapper.dart';
import 'package:flutter_website/ui/carousel/carousel.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:universal_io/io.dart';

import 'ui/blocks.dart';

void main()async {
   WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        builder: (context, widget) => ResponsiveBreakpoints.builder(
              child: Builder(builder: (context) {
                return ResponsiveScaledBox(
                    width: ResponsiveValue<double?>(context,
                        defaultValue: null,
                        conditionalValues: [
                          const Condition.equals(
                              name: 'MOBILE_SMALL', value: 480),
                        ]).value,
                    child: ClampingScrollWrapper.builder(context, widget!));
              }),
              breakpoints: [
                const Breakpoint(start: 0, end: 480, name: 'MOBILE_SMALL'),
                const Breakpoint(start: 481, end: 850, name: MOBILE),
                const Breakpoint(start: 850, end: 1080, name: TABLET),
                const Breakpoint(
                    start: 1081, end: double.infinity, name: DESKTOP),
              ],
            ),
      debugShowCheckedModeBanner: false,

        home: Builder(
          builder: (context) => Scaffold(
            backgroundColor: background,
            appBar: const PreferredSize(
                preferredSize: Size(double.infinity, 66),
                child: WebsiteMenuBar()),
            body: Stack(
              children: [
                ListView.builder(
                  itemCount: blocks.length,
                  itemBuilder: (context, index) {
                    return blocks[index];
                  },
                ),
                Positioned(
                  right: 0,
                  top: MediaQuery.of(context).size.height / 2 - 60,
                  child: _WhatsAppHoverButton(),
                ),
                Positioned(
                  right: 0,
                  top: MediaQuery.of(context).size.height / 2 + 20,
                  child: _TelegramHoverButton(),
                ),
                Positioned(
                  left: 10,
                  top: MediaQuery.of(context).size.height / 2 + 160,
                  child: BlinkingRegisterButton(onTap: () {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>  SemiCircleContainerPage(),
                        ),
                      );
                    });
                  }),
                ),
              ],
            ),
          ),
        ));
  }
}

List<Widget> blocks = [
  MaxWidthBox(
    maxWidth: 1200,
    child: FittedBox(
      fit: BoxFit.fitWidth,
      alignment: Alignment.topCenter,
      child: Container(
          width: 1200,
          height: 640,
          alignment: Alignment.center,
          child: RepaintBoundary(child: Carousel())),
    ),
  ),
  const BlockWrapper(ResultSlider()),

  const BlockWrapper(KnowYourMentor()),
  const BlockWrapper(GetStarted()),

  const BlockWrapper(ContactUsPage()),
  // ContactUsPage(),
  // const BlockWrapper(NativePerformance()),
  // const BlockWrapper(LearnFromDevelopers()),
  // const BlockWrapper(WhoUsesFlutter()),
  // if (kIsWeb || Platform.isAndroid || Platform.isIOS)
  //   const ResponsiveVisibility(
  //     hiddenConditions: [Condition.smallerThan(name: DESKTOP)],
  //     child: BlockWrapper(FlutterCodelab()),
  //   ),
  // const BlockWrapper(FlutterNewsRow()),
  // const BlockWrapper(InstallFlutter()),
  const Footer(),
];

class _WhatsAppHoverButton extends StatefulWidget {
  @override
  State<_WhatsAppHoverButton> createState() => _WhatsAppHoverButtonState();
}

class _WhatsAppHoverButtonState extends State<_WhatsAppHoverButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse("https://wa.me/9876543210"));
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 199, 220, 199),
            borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                '/assets/images/whatsapp.png',
                height: 40,
                width: 40,
              ),
              if (_isHovering)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'WhatsApp',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TelegramHoverButton extends StatefulWidget {
  @override
  State<_TelegramHoverButton> createState() => _TelegramHoverButtonState();
}

class _TelegramHoverButtonState extends State<_TelegramHoverButton> {
  bool _isHovering = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        launchUrl(Uri.parse("https://youtube/"));
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovering = true),
        onExit: (_) => setState(() => _isHovering = false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 215, 224, 231),
            borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                '/assets/images/youtube.png',
                height: 40,
                width: 40,
              ),
              if (_isHovering)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'Youtube',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
