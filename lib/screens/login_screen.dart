import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static const Color orange = Color(0xFFF89655);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Global key for the form, used for validation
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLoading = false;

  // Function to handle the login process
  void _handleLogin() async {
    // Validate the form before proceeding
    if (_formKey.currentState!.validate()) {
      final String email = _emailController.text.trim();
      final String password = _passwordController.text; // Do not trim password

      setState(() {
        _isLoading = true; // Show loading indicator
      });

      try {
        // Attempt to sign in with Firebase Authentication
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );

        // Show success message if login is successful
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login successful")),
        );

        // Clear input fields after successful login
        _emailController.clear();
        _passwordController.clear();

        // ✅ Navigate to the dashboard (replace '/dashboard' with your actual route)
        // Using pushReplacementNamed to prevent going back to login screen
        Navigator.pushReplacementNamed(context, '/dashboard');
      } on FirebaseAuthException catch (e) {
        String message = "Login failed. Please try again.";

        // Customize error messages based on Firebase Auth codes
        if (e.code == 'user-not-found') {
          message = "No user found for that email. Please register first.";
        } else if (e.code == 'wrong-password') {
          message = "Incorrect password. Please try again.";
        } else if (e.code == 'invalid-email') {
          message = "The email address is not valid.";
        } else if (e.code == 'too-many-requests') {
          message = "Too many login attempts. Please try again later.";
        }

        // Show the error message to the user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      } catch (e) {
        // Catch any other unexpected errors
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("An unexpected error occurred. Try again.")),
        );
      } finally {
        setState(() {
          _isLoading = false; // Hide loading indicator
        });
      }
    }
  }

  // Validator for email input
  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Validator for password input
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    // You can add more password strength validation here if needed
    return null;
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: LoginScreen.orange.withOpacity(0.15),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
          child: Form( // Wrap with Form widget for validation
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
                  "Welcome Back",
                  style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text(
                  "Login to your account",
                  style: TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 30),
                TextFormField( // Changed to TextFormField
                  controller: _emailController,
                  validator: _validateEmail, // Add validator
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "Email",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField( // Changed to TextFormField
                  controller: _passwordController,
                  validator: _validatePassword, // Add validator
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implement forgot password functionality
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Forgot password functionality coming soon!")),
                      );
                    },
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _isLoading ? null : _handleLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: LoginScreen.orange,
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                      color: Colors.white, strokeWidth: 2)
                      : const Text("Login", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
                const SizedBox(height: 20),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      // Navigate to the registration screen
                      Navigator.pushNamed(context, '/register');
                    },
                    child: Text.rich(
                      TextSpan(
                        text: "Don't have an account? ",
                        children: [
                          TextSpan(
                            text: "Sign Up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: LoginScreen.orange,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // The social login section (Apple, Facebook, Google) has been removed.
              ],
            ),
          ),
        ),
      ),
    );
  }
}