import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // tambahkan const constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // State untuk menampilkan loading dan error message
  bool isLoading = false;
  String errorMessage = '';
  bool isPasswordVisible = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      print('Email: $email');
      print('Password: $password');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Login berhasil!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  // Validasi email sederhana
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$'); // agar pola email benar
                  if (!emailRegex.hasMatch(value)) {
                    return 'Invalid email format';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: (value) {
                  // Validasi password 
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 8) {
                    return 'Password minimal 8 karakter';
                  }
                  if (!RegExp(r'[A-Za-z]').hasMatch(value) || !RegExp(r'[0-9]').hasMatch(value)) {
                    return 'Password harus mengandung huruf dan angka';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
