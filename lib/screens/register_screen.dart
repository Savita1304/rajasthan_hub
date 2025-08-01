import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  static const Color orange = Color(0xFFF89655);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;

  void handleRegister() async {
    if (_formKey.currentState!.validate()) {
      final name = nameController.text.trim();
      final email = emailController.text.trim();
      final String password = passwordController.text; // Ensure password is not trimmed

      setState(() {
        _isLoading = true;
      });

      try {
        // ✅ Firebase create account
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Registration successful!")),
        );

        // ✅ Clear inputs
        nameController.clear();
        emailController.clear();
        passwordController.clear();

        // ✅ Navigate to login page
        Navigator.pushReplacementNamed(context, '/login');
      } on FirebaseAuthException catch (e) {
        String message = "Registration failed";

        if (e.code == 'email-already-in-use') {
          message = "This email is already registered.";
        } else if (e.code == 'invalid-email') {
          message = "Invalid email address.";
        } else if (e.code == 'weak-password') {
          message = "Password should be at least 6 characters.";
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } catch (_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Something went wrong.")),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  String? validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: orange.withOpacity(0.15),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.pop(context),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Register",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Create your new account",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                TextFormField(
                  controller: nameController,
                  validator: validateName,
                  decoration: InputDecoration(
                    hintText: "Name",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: emailController,
                  validator: validateEmail,
                  decoration: InputDecoration(
                    hintText: "Email",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  validator: validatePassword,
                  decoration: InputDecoration(
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _isLoading ? null : handleRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: orange,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2)
                      : const Text("Register", style: TextStyle(color: Colors.white)), // Added color for text
                ),
                const SizedBox(height: 20),
                Center(
                  child: Column(
                    children: [
                      const Text("Or continue with"),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Apple Icon with White Background
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Image.asset('assets/images/apple.png', width: 30),
                          ),
                          const SizedBox(width: 20),
                          // Facebook Icon with White Background (for consistency)
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Image.asset('assets/images/facebook.png', width: 30),
                          ),
                          const SizedBox(width: 20),
                          // Google Icon with White Background (for consistency)
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade300),
                            ),
                            child: Image.asset('assets/images/google.png', width: 30),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ], // Closing bracket for Column
            ), // Closing bracket for Form
          ), // Closing bracket for SingleChildScrollView
        ), // Closing bracket for SafeArea
      ), // Closing bracket for Scaffold
    ); // Closing bracket for build method return
  } // Closing bracket for build method
} // Closing bracket for _RegisterScreenState class