import 'package:flutter/material.dart';
import 'auth_manager.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isObscurePassword = true;
  bool _isObscureConfirmPassword = true;
  bool _isTermsAccepted = false;
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

  // Function to validate password and confirm password
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

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    } else if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  void _signup() async {
    if (_formKey.currentState!.validate() && _isTermsAccepted) {
      setState(() {
        _isLoading = true;
      });
      // Proceed with sign-up logic
      await AuthManager().signUp(context, _emailController.text,
          _passwordController.text, _nameController.text);
      // If all fields are valid and terms are accepted, print the form data
      print('Name: ${_nameController.text}');
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      print('Confirm Password: ${_confirmPasswordController.text}');
      print('Terms accepted: $_isTermsAccepted');

      setState(() {
        _isLoading = false;
      });
      Navigator.pushReplacementNamed(context, '/dashboard');
    } else if (!_isTermsAccepted) {
      // Show a message if terms and conditions are not accepted
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You must accept the terms and conditions to proceed.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF0797BA)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey, // Assign the form key
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),

                // Sign Up Title
                const Text(
                  'Sign up',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF01F123), // Custom green color for title
                  ),
                ),

                const SizedBox(height: 10),

                // Subtitle text
                const Text(
                  'Create an account to get started',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Color(0xFF71727A),
                  ),
                ),

                const SizedBox(height: 20),

                // Name TextField
                const Text(
                  'Name',
                  style: TextStyle(
                    color: Color(0xFF0797BA),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    hintText: 'Full Name',
                    hintStyle: const TextStyle(color: Color(0xFF71727A)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // Email Address TextField
                const Text(
                  'Email Address',
                  style: TextStyle(
                    color: Color(0xFF0797BA),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    hintStyle: const TextStyle(color: Color(0xFF71727A)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    hintText: 'name@email.com',
                  ),
                  validator: _validateEmail,
                ),

                const SizedBox(height: 20),

                // Password TextField with toggle visibility
                const Text(
                  'Password',
                  style: TextStyle(
                    color: Color(0xFF0797BA),
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isObscurePassword,
                  decoration: InputDecoration(
                    hintText: 'Create a password',
                    hintStyle: const TextStyle(color: Color(0xFF71727A)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscurePassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscurePassword = !_isObscurePassword;
                        });
                      },
                    ),
                  ),
                  validator: _validatePassword,
                ),

                const SizedBox(height: 20),

                // Confirm Password TextField with toggle visibility
                const SizedBox(height: 8),
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _isObscureConfirmPassword,
                  decoration: InputDecoration(
                    hintText: 'Confirm password',
                    hintStyle: const TextStyle(color: Color(0xFF71727A)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscureConfirmPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscureConfirmPassword =
                              !_isObscureConfirmPassword;
                        });
                      },
                    ),
                  ),
                  validator: _validateConfirmPassword,
                ),

                const SizedBox(height: 20),

                // Terms and Conditions Checkbox
                Row(
                  children: [
                    Checkbox(
                      value: _isTermsAccepted,
                      onChanged: (bool? value) {
                        setState(() {
                          _isTermsAccepted = value!;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'I agree to the terms and conditions',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Sign Up Button
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
                      onPressed: _isLoading
                          ? null
                          : _signup, // Disable button if loading
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white, // Loading indicator color
                            )
                          : Ink(
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xFF0797BA),
                                    Color(0xFF01F123)
                                  ], // Gradient colors
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                constraints:
                                    const BoxConstraints(maxHeight: 50.0),
                                child: const Text(
                                  'Signup',
                                  style: TextStyle(
                                    color: Colors.white, // White text
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
