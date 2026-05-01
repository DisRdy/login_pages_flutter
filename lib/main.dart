import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); // const constructor

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {
        '/forgot-password': (context) => ForgotPasswordScreen(),
        '/dashboard': (context) => DashboardScreen(),
      },
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

  // State
  bool isLoading = false;
  String errorMessage = '';
  bool isPasswordVisible = false;

  void _login() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true;
        errorMessage = '';
      });

      String email = _emailController.text;
      String password = _passwordController.text;
      print('Email: $email');
      print('Password: $password');

      // Simulasi delay tambahan
      Future.delayed(const Duration(seconds: 2), () {
        if (email == "disna@gmail.com" && password == "password123") {
          Navigator.pushReplacementNamed(context, '/dashboard');
          // SnackBar sukses
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Login berhasil!"),
              backgroundColor: Colors.green,
              duration: Duration(seconds: 2),
            ),

          );
        } else {
          // SnackBar error 
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Email atau password salah!"),
              backgroundColor: Colors.red,
            ),
          );
        }

        setState(() {
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login Screen')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Email
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Invalid email format';
                  }
                  return null;
                },
              ),

              // Password
              TextFormField(
                controller: _passwordController,
                obscureText: !isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  if (value.length < 8) {
                    return 'Password minimal 8 karakter';
                  }
                  if (!RegExp(r'[A-Za-z]').hasMatch(value) ||
                      !RegExp(r'[0-9]').hasMatch(value)) {
                    return 'Password harus mengandung huruf dan angka';
                  }
                  return null;
                },
              ),

              // Lupa Password Button
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/forgot-password');
                },
                child: const Text('Lupa Password?'),
              ),

              // Error message
              if (errorMessage.isNotEmpty) ...[
                const SizedBox(height: 10),
                Text(errorMessage, style: const TextStyle(color: Colors.red)),
              ],

              const SizedBox(height: 20),

              // Tombol Login / Loading
              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      child: const Text('Login'),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}


class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final globalkey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();

  bool isLoading = false;

  void sendResetLink() {
    if (globalkey.currentState!.validate()) {
      setState(() {
        isLoading = true;
      });

      Future.delayed(const Duration(seconds: 2), () {
        setState(() {
          isLoading = false;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Reset link sent to your email!"),
            backgroundColor: Colors.green,
          ),
        );

        setState(() {
          isLoading = false;
        });
      });
    }
  }


  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lupa Password')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: globalkey,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Invalid email format';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: sendResetLink,
                      child: const Text('Send Reset Link'),
                    ),

              const SizedBox(height: 10),

              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Back to Login'),
              )
              ],
            ),
          ),
        ),
      ),
      );
    }
  }

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: const Center(
        child: Text('Welcome to the Dashboard!'),
      ),
    );
  }
}

