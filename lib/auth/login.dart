import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../pages/shop.dart';
import '../widgets/dialogs/error_dialog.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;
  bool _isLoading = false;

  // Function to validate email format
  String? _validateEmail(String? value) {
    const emailPattern = r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$';
    final regExp = RegExp(emailPattern);

    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!regExp.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  // Validate password
  String? _validatePassword(String? value) {
    const passwordPattern =
        r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$';
    final regExp = RegExp(passwordPattern);

    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (!regExp.hasMatch(value)) {
      return 'Password must be at least 8 characters, include an uppercase letter, number, and special character';
    }
    return null;
  }

  // Method to handle login logic
  Future<Widget?> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      try {
        await _auth.signInWithEmailAndPassword(
            email: _emailController.text, password: _passwordController.text);
      } catch (e) {
        ErrorDialog(e.toString());
      }

      // print('Email: ${_emailController.text}');
      // print('Password: ${_passwordController.text}');

      setState(() {
        _isLoading = false;
      });

      return const ShopPage();
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 220,
              color: const Color(0xFFEAF2FF),
              child: Center(
                child: Image.asset(
                  'assets/images/Delivery-Robot.png',
                  height: 220.0,
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Welcome!',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF01F123),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Form(
              key: _formKey,
              child: Column(
                children: [
                  // Email TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(color: Color(0xFF71727A)),
                        hintText: 'Enter your email',
                        hintStyle: const TextStyle(color: Color(0xFF71727A)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                      validator: _validateEmail, // Validation function
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Password TextField
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _isObscure,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(color: Color(0xFF71727A)),
                        hintText: 'Enter your password',
                        hintStyle: const TextStyle(color: Color(0xFF71727A)),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _isObscure
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),
                      ),
                      validator: _validatePassword, // Validation function
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Forgot password?',
                    style: TextStyle(
                      color: Color(0xFF0797BA),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Login button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                  onPressed:
                      _isLoading ? null : _login, // Disable button if loading
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : Ink(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF0797BA), Color(0xFF01F123)],
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Container(
                            alignment: Alignment.center,
                            constraints: const BoxConstraints(maxHeight: 50.0),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Register text
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Not a member?'),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(
                      context,
                      '/signup',
                    );
                  },
                  child: const Text(
                    'Register now.',
                    style: TextStyle(
                      color: Color(0xFF0797BA),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
