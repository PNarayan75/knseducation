import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({super.key});

  @override
  State<ContactUsPage> createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage>
    with TickerProviderStateMixin {
  late final AnimationController _containerAnimationController;
  late final Animation<double> _containerAnimation;

  late final AnimationController _cardsAnimationController;
  late final Animation<double> _cardsAnimation;

  late final AnimationController _socialAnimationController;
  late final Animation<double> _socialAnimation;

  late final AnimationController _formAnimationController;
  late final Animation<double> _formAnimation;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Main container animation (scale + fade)
    _containerAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _containerAnimation = CurvedAnimation(
      parent: _containerAnimationController,
      curve: Curves.fastOutSlowIn,
    );

    // Contact cards animation (staggered slide up)
    _cardsAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _cardsAnimation = CurvedAnimation(
      parent: _cardsAnimationController,
      curve: Curves.easeOutQuart,
    );

    // Social icons animation (sequential pop in)
    _socialAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _socialAnimation = CurvedAnimation(
      parent: _socialAnimationController,
      curve: Curves.elasticOut,
    );

    // Form animation (slide up with fade)
    _formAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _formAnimation = CurvedAnimation(
      parent: _formAnimationController,
      curve: Curves.easeInOutBack,
    );

    // Sequence the animations
    _containerAnimationController.forward().then((_) {
      _cardsAnimationController.forward().then((_) {
        _socialAnimationController.forward().then((_) {
          _formAnimationController.forward();
        });
      });
    });
  }

  @override
  void dispose() {
    _containerAnimationController.dispose();
    _cardsAnimationController.dispose();
    _socialAnimationController.dispose();
    _formAnimationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ScaleTransition(
        scale: _containerAnimation,
        child: FadeTransition(
          opacity: _containerAnimation,
          child: Container(
            // constraints: const BoxConstraints(maxWidth: 600),
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.blueGrey.withOpacity(0.2),
              //     blurRadius: 20,
              //     spreadRadius: 5,
              //     offset: const Offset(0, 10),
              //   ),
              // ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.grey.shade50,
                ],
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Header with animated underline
                  _buildAnimatedHeader(),
                  const SizedBox(height: 30),

                  // Contact cards with staggered animation
                  _buildContactCards(),
                  const SizedBox(height: 30),

                  // Social media section with sequential animation
                  _buildSocialSection(),
                  const SizedBox(height: 30),

                  // Form section with slide up animation
                  _buildFormSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedHeader() {
    return Column(
      children: [
        const Text(
          "Get In Touch",
          style: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.fastOutSlowIn,
          width: _containerAnimationController.value * 100,
          height: 4,
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          "We'd love to hear from you!",
          style: TextStyle(
            fontSize: 16,
            color: Colors.blueGrey,
          ),
        ),
      ],
    );
  }

  Widget _buildContactCards() {
    return SizeTransition(
      sizeFactor: _cardsAnimation,
      child: FadeTransition(
        opacity: _cardsAnimation,
        child: Column(
          children: [
            _buildAnimatedContactCard(
              delay: 0,
              icon: Icons.phone_rounded,
              title: "Call Us",
              subtitle: "+91 79769 11779",
              color: Colors.green,
              onTap: () => _launchUrl("tel:+917976911779"),
            ),
            const SizedBox(height: 15),
            _buildAnimatedContactCard(
              delay: 0.2,
              icon: Icons.email_rounded,
              title: "Email Us",
              subtitle: "Knseducation.help@gmail.com",
              color: Colors.red,
              onTap: () => _launchUrl("mailto:Knseducation.help@gmail.com"),
            ),
            const SizedBox(height: 15),
            _buildAnimatedContactCard(
              delay: 0.4,
              icon: Icons.location_on_rounded,
              title: "Visit Us",
              subtitle: "KNS Education, Jaipur",
              color: Colors.blue,
              onTap: () =>
                  _launchUrl("https://maps.google.com/?q=KNS+Education,Jaipur"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimatedContactCard({
    required double delay,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required VoidCallback onTap,
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _cardsAnimationController,
        curve: Interval(delay, 1.0, curve: Curves.easeOutBack),
      )),
      child: FadeTransition(
        opacity: _cardsAnimationController.drive(
          CurveTween(curve: Interval(delay, 1.0, curve: Curves.easeIn)),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(15),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, color: color, size: 24),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: color),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSocialSection() {
    return Column(
      children: [
        const Text(
          "Connect With Us",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.blueGrey,
          ),
        ),
        const SizedBox(height: 15),
        const Text(
          "Follow us on social media for updates",
          style: TextStyle(
            fontSize: 14,
            color: Colors.blueGrey,
          ),
        ),
        const SizedBox(height: 20),
        Wrap(
          spacing: 15,
          runSpacing: 15,
          children: [
            _buildAnimatedSocialIcon(
              delay: 0,
              icon: Icons.youtube_searched_for,
              color: Colors.red,
              label: "YouTube",
              url: "https://youtube.com/yourchannel",
            ),
            _buildAnimatedSocialIcon(
              delay: 0.1,
              icon: Icons.facebook,
              color: Colors.blue,
              label: "Facebook",
              url: "https://facebook.com/yourpage",
            ),
            _buildAnimatedSocialIcon(
              delay: 0.2,
              icon: Icons.camera_alt,
              color: Colors.pink,
              label: "Instagram",
              url: "https://instagram.com/yourprofile",
            ),
            _buildAnimatedSocialIcon(
              delay: 0.3,
              icon: Icons.link,
              color: Colors.blueGrey,
              label: "Website",
              url: "https://yourwebsite.com",
            ),
            _buildAnimatedSocialIcon(
              delay: 0.4,
              icon: Icons.chat,
              color: Colors.green,
              label: "WhatsApp",
              url: "https://wa.me/917976911779",
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAnimatedSocialIcon({
    required double delay,
    required IconData icon,
    required Color color,
    required String label,
    required String url,
  }) {
    return ScaleTransition(
      scale: CurvedAnimation(
        parent: _socialAnimationController,
        curve: Interval(delay, 1.0, curve: Curves.elasticOut),
      ),
      child: Tooltip(
        message: label,
        child: InkWell(
          onTap: () => _launchUrl(url),
          borderRadius: BorderRadius.circular(50),
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.1),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
        ),
      ),
    );
  }

  Widget _buildFormSection() {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0, 0.5),
        end: Offset.zero,
      ).animate(_formAnimationController),
      child: FadeTransition(
        opacity: _formAnimation,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                "Send us a message",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueGrey,
                ),
              ),
              const SizedBox(height: 20),
              _buildAnimatedFormField(
                delay: 0,
                controller: _nameController,
                label: 'Your Name',
                icon: Icons.person,
              ),
              const SizedBox(height: 15),
              _buildAnimatedFormField(
                delay: 0.1,
                controller: _emailController,
                label: 'Your Email',
                icon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 15),
              _buildAnimatedFormField(
                delay: 0.2,
                controller: _messageController,
                label: 'Your Message',
                icon: Icons.message,
                maxLines: 4,
              ),
              const SizedBox(height: 25),
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedFormField({
    required double delay,
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-0.5, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: _formAnimationController,
        curve: Interval(delay, 1.0, curve: Curves.easeOut),
      )),
      child: FadeTransition(
        opacity: CurvedAnimation(
          parent: _formAnimationController,
          curve: Interval(delay, 1.0, curve: Curves.easeIn),
        ),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          maxLines: maxLines,
          decoration: InputDecoration(
            labelText: label,
            prefixIcon: Icon(icon, color: Colors.blueGrey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blueGrey.withOpacity(0.3)),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.blueGrey.withOpacity(0.3)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.blueAccent),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            if (label.contains('Email') && !value.contains('@')) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
      ),
    );
  }

  Widget _buildSubmitButton() {
    return AnimatedBuilder(
      animation: _formAnimationController,
      builder: (context, child) {
        final animationValue = _formAnimationController.value;
        final scale = 0.8 + (animationValue * 0.2);
        final opacity = animationValue;

        return Transform.scale(
          scale: scale,
          child: Opacity(
            opacity: opacity,
            child: child,
          ),
        );
      },
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: _submitForm,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blueAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
            shadowColor: Colors.blueAccent.withOpacity(0.3),
          ),
          child: const Text(
            "Send Message",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Form is valid, process the data
      final name = _nameController.text;
      final email = _emailController.text;
      final message = _messageController.text;

      // Show success animation
      _showSuccessAnimation();

      // TODO: Send the message to your backend or email service
      debugPrint('Message from $name ($email): $message');
    }
  }

  void _showSuccessAnimation() {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: ScaleTransition(
            scale: AnimationController(
              vsync: this,
              duration: const Duration(milliseconds: 300),
            )..forward(),
            child: Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.check_circle, color: Colors.green, size: 60),
                  const SizedBox(height: 20),
                  const Text(
                    "Message Sent!",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "We'll get back to you soon.",
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("OK"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Could not launch $url')),
      );
    }
  }
}
