import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController(text: '9876543210');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Welcome to Nachoonrent', style: AppTypography.h1),
              const SizedBox(height: 8),
              const Text(
                'Enter your mobile number to sign in or create your single unified account.',
                style: AppTypography.bodySecondary,
              ),
              const SizedBox(height: 32),
              TextField(
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  labelText: 'Mobile Phone Number',
                  prefixText: '+91 ',
                  prefixIcon: Icon(Icons.phone_rounded, color: AppColors.primaryPlum),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => OTPScreen(phoneNumber: '+91 ${_phoneController.text}'),
                      ),
                    );
                  },
                  child: const Text('Send Verification Code'),
                ),
              ),
              const Spacer(),
              Center(
                child: Text(
                  'By signing up, you agree to our Terms of Service & Privacy Policy.',
                  style: AppTypography.small,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
