import 'package:flutter/material.dart';
import 'package:email_otp/email_otp.dart';
import 'package:kyc_app/Form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  final EmailOTP myAuth = EmailOTP();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(0, 6, 27, 1),
      body: Column(
        children: [
          Container(
            color: Color.fromRGBO(0, 6, 27, 1), // Same color as the background
            child: Padding(
              padding: const EdgeInsets.only(top: 30, bottom: 10),
              child: Image.asset(
                'assets/images/g2.png',
                height: MediaQuery.of(context).size.height * 0.1,
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white, // White background
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Login",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      SizedBox(
                        height: 50,
                      ),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Email Address',
                          prefixIcon: Icon(Icons.email, color: Colors.black),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          hintStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _sendOTP,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(97, 115, 149, 1),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Get OTP'),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          hintText: 'OTP',
                          prefixIcon: Icon(Icons.lock, color: Colors.black),
                          filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                          hintStyle: TextStyle(color: Colors.black),
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _verifyOTP,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromRGBO(97, 115, 149, 1),
                          foregroundColor: Colors.white,
                        ),
                        child: const Text('Verify OTP'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendOTP() async {
    // Dynamically set the EmailOTP configuration with the user's email
    myAuth.setConfig(
      appEmail: "me@rohitchouhan.com",
      appName: "Standard Chartered KYC",
      userEmail: _emailController.text.trim(), // Use trimmed email
      otpLength: 6,
      otpType: OTPType.digitsOnly,
    );

    try {
      final success = await myAuth.sendOTP();
      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("OTP has been sent to your email"),
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Failed to send OTP. Please try again"),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error sending OTP: $e"),
      ));
    }
  }

  Future<void> _verifyOTP() async {
    try {
      final isVerified = await myAuth.verifyOTP(
          otp: _otpController.text.trim()); // Direct string comparison
      if (isVerified) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("OTP verified successfully!"),
        ));
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => FormScreen()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Invalid OTP. Please try again"),
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Error verifying OTP: $e"),
      ));
    }
  }
}
