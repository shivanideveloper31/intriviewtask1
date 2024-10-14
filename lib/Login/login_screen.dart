import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

import '../Home_Module/home_screen.dart';
import 'Controller/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginController loginController = Get.put(LoginController());

  final TextEditingController loginEmail = TextEditingController();
  final TextEditingController phone = TextEditingController();

  // Email validation regex
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // Phone number validation regex (assuming US phone number format)
  final RegExp phoneRegex = RegExp(r'^\+?[0-9]{10,15}$');

  @override
  void initState() {
    super.initState();
    _loadUserData(); // Load user data on startup
  }

  // Load user data from SharedPreferences
  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedEmail = prefs.getString('userEmail');
    String? userName = prefs.getString('userName');

    // If data exists, set the text fields
    if (savedEmail != null) {
      Get.to(() => ProductScreen());

      loginEmail.text = savedEmail;
    }
    if (userName != null) {
      phone.text = userName;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            children: [
              const SizedBox(height: 200),
              Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  image: const DecorationImage(
                    image: NetworkImage('https://symbols.getvecta.com/stencil_261/16_google-firebase.3828a6e3a4.jpg'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              const SizedBox(height: 100),
              // Email input
              InkWell(
                onTap: (){
                  loginController.handleSignIn();
                },
                child: Container(
                  height: 60,
                  decoration: const BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/google.jpg'),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Text("Google",
                        style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                    const Spacer(),
                    const Spacer(),
                  ]),
                ),
              ),

              const SizedBox(height: 20),
              // Phone input
              Container(
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: const Row(children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16.0),
                    child: Icon(
                      Icons.phone,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                  Spacer(),
                  Text("Phone",
                      style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Spacer(),
                ]),
              ),
               const SizedBox(height: 20),
              // Login button
              ElevatedButton(
                onPressed: () async {
                  // Validate inputs before navigating
                 /* if (_validateInputs()) {
                    // Save user data to SharedPreferences
                    await _saveUserData();

                    //  Get.to(() => ProductScreen());
                  }*/
                },
                child: const Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
