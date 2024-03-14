import 'package:flutter/material.dart';

import 'package:kyc_app/LogInScreen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0), // Hide the app bar
        child: Container(),
      ),
      backgroundColor: Color.fromRGBO(0, 6, 27, 1),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Image.asset(
              'assets/images/getstarted.png',
              fit: BoxFit.cover,
              width: MediaQuery.of(context).size.width *
                  1.0, // Set the width of the image
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 10), // Add horizontal padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Few clicks away\non KYC',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Start your KYC in minutes.\nSave time and money.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginScreen()));
                  },
                  style: ElevatedButton.styleFrom(
                      minimumSize: Size(double.infinity,
                          50), // Set the width and height of the button
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10), // Set the border radius
                      ),
                      backgroundColor: Color.fromRGBO(97, 115, 149, 1)),
                  child: const Text(
                    'Create Account',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
