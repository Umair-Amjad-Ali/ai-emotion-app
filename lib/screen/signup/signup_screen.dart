import 'package:ai_emotion_app/screen/signup/registration_successful_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widgets/app_background.dart';
import '../../../widgets/primary_button.dart';
import '../login/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool _agreeToTerms = false;
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.bgDark,
      resizeToAvoidBottomInset: false,
      // MainBackground is now the root of body to ensure it covers all edges
      body: MainBackground(
        child: SafeArea(
          bottom: false, // Ensures background extends behind bottom nav/keyboard area
          child: Padding(
            padding: EdgeInsets.only(
              left: screenWidth * 0.06,
              right: screenWidth * 0.06,
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  const Text(
                    'Create Your Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Form Fields
                  _buildTextField(hint: 'Full Name'),
                  const SizedBox(height: 12),
                  _buildTextField(hint: 'Phone Number', keyboardType: TextInputType.phone),
                  const SizedBox(height: 12),
                  _buildCountryPickerField(),
                  const SizedBox(height: 12),
                  _buildTextField(hint: 'Email', keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 12),
                  _buildTextField(
                    hint: 'Password',
                    isPassword: true,
                    obscureText: _obscurePassword,
                    onSuffixTap: () => setState(() => _obscurePassword = !_obscurePassword),
                  ),

                  const SizedBox(height: 15),

                  // Terms and Conditions Checkbox
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: _agreeToTerms,
                          onChanged: (val) => setState(() => _agreeToTerms = val!),
                          side: BorderSide(color: Colors.white.withOpacity(0.3)),
                          activeColor: Colors.blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 13, height: 1.4),
                            children: [
                              const TextSpan(text: 'Check it if you agree to our '),
                              const TextSpan(
                                text: 'Terms & Conditions',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                              ),
                              const TextSpan(text: ' and '),
                              const TextSpan(
                                text: 'Privacy Policy',
                                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  PrimaryButton(
                    text: 'SIGN UP',
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RegistrationSuccessfulScreen()));
                    },
                  ),

                  const SizedBox(height: 10),

                  // "Or With" Divider
                  Row(
                    children: [
                      Expanded(child: Divider(color: Colors.white.withOpacity(0.2))),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text('Or With', style: TextStyle(color: Colors.white.withOpacity(0.7))),
                      ),
                      Expanded(child: Divider(color: Colors.white.withOpacity(0.2))),
                    ],
                  ),

                  const SizedBox(height: 10),

                  // Social Media Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildSocialButton('assets/svg/google_ic.svg'),
                      /*const SizedBox(width: 15),
                      _buildSocialButton('assets/svg/facebook_ic.svg'),*/
                      const SizedBox(width: 15),
                      _buildSocialButton('assets/svg/apple_ic.svg'),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Login Redirect
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Already have an account? ', style: TextStyle(color: Colors.white.withOpacity(0.7))),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                          },
                        child: const Text('Log in', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String hint,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onSuffixTap,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F2E).withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(color: Colors.white, fontSize: 15),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 15),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          border: InputBorder.none,
          suffixIcon: isPassword
              ? IconButton(
            icon: Icon(
              obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
              color: Colors.white.withOpacity(0.3),
              size: 20,
            ),
            onPressed: onSuffixTap,
          )
              : null,
        ),
      ),
    );
  }

  Widget _buildCountryPickerField() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1F2E).withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(child: Text('Country', style: TextStyle(color: Colors.white.withOpacity(0.3), fontSize: 15))),
          const Text('🇩🇰', style: TextStyle(fontSize: 18)),
          const SizedBox(width: 5),
          Icon(Icons.arrow_drop_down, color: Colors.white.withOpacity(0.3)),
        ],
      ),
    );
  }

  Widget _buildSocialButton(String assetPath) {
    return Container(
      padding: EdgeInsets.all(12),
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.07),
        borderRadius: BorderRadius.circular(12),
      ),
      child: SvgPicture.asset(assetPath),
    );
  }
}