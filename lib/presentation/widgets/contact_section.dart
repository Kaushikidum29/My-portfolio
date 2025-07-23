import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:my_portfolio/core/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/utils/responsive.dart';

class ContactSectionWidget extends StatefulWidget {
  const ContactSectionWidget({Key? key}) : super(key: key);

  @override
  State<ContactSectionWidget> createState() => _ContactSectionWidgetState();
}

class _ContactSectionWidgetState extends State<ContactSectionWidget> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _messageController = TextEditingController();

  bool _isFormValid() {
    return _emailController.text.isNotEmpty &&
        _messageController.text.isNotEmpty &&
        RegExp(
          r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
        ).hasMatch(_emailController.text);
  }

  Future<void> _launchEmailApp() async {
    final email = _emailController.text.trim();
    final message = _messageController.text.trim();

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'kaushikidum29@gmail.com',
      query: 'subject=Contact from $email&body=$message',
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Could not open the email app')),
      );
    }
  }

  void _handleSubmit() {
    if (_formKey.currentState!.validate()) {
      _launchEmailApp();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a valid email and message')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.isMobile(context) ? 16 : 100,
      ),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Responsive.isMobile(context)
          ? _buildMobileContact()
          : _buildDesktopContact(),
    );
  }

  Widget _buildMobileContact() {
    return Column(
      children: [
        Text(
          "Contact Us",
          style: TextStyle(
            color: AppTheme.textColor,
            fontWeight: FontWeight.w600,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 40),
        _buildContactForm(),
      ],
    );
  }

  Widget _buildDesktopContact() {
    return Row(
      children: [
        Expanded(child: _buildContactIllustration()),
        const SizedBox(width: 60),
        Expanded(child: _buildContactForm()),
      ],
    );
  }

  Widget _buildContactIllustration() {
    return Lottie.asset('assets/lotties/contact.json', height: 400);
  }

  Widget _buildContactForm() {
    return Form(
      key: _formKey,
      onChanged: () => setState(() {}),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTextField(
            controller: _emailController,
            hint: 'Enter email address',
            validator: (value) {
              if (value == null || value.isEmpty) return 'Email is required';
              if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$').hasMatch(value)) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildTextField(
            controller: _messageController,
            hint: 'Enter your message...',
            maxLines: 5,
            validator: (value) =>
                value == null || value.isEmpty ? 'Message is required' : null,
          ),
          const SizedBox(height: 28),
          Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: Responsive.isMobile(context) ? double.infinity : 250,
              child: ElevatedButton(
                onPressed: _isFormValid() ? _handleSubmit : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff343d68),
                  disabledBackgroundColor: Colors.grey,
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    'Send Message',
                    style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    String? Function(String?)? validator,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(color: const Color(0xffbfbec1)),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        validator: validator,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: Color(0xffbfbec1),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}
