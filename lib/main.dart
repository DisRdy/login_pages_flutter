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
        '/dashboard': (context) => DashboardScreen(email: ''),
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
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardScreen(email: email),
            ),
          );
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

  final String email;
  DashboardScreen({required this.email});

final List<Map<String, dynamic>> sahamList = [
  {'kode': 'BBCA', 'nama': 'Bank Central Asia', 'harga': 9400},
  {'kode': 'BBRI', 'nama': 'Bank Rakyat Indonesia', 'harga': 5200},
  {'kode': 'BMRI', 'nama': 'Bank Mandiri', 'harga': 6100},
  {'kode': 'TLKM', 'nama': 'Telkom Indonesia', 'harga': 3800},
  {'kode': 'ASII', 'nama': 'Astra International', 'harga': 5100},
  {'kode': 'UNVR', 'nama': 'Unilever Indonesia', 'harga': 4200},
  {'kode': 'ICBP', 'nama': 'Indofood CBP', 'harga': 11200},
  {'kode': 'INDF', 'nama': 'Indofood Sukses Makmur', 'harga': 6500},
  {'kode': 'GOTO', 'nama': 'GoTo Gojek Tokopedia', 'harga': 90},
  {'kode': 'ANTM', 'nama': 'Aneka Tambang', 'harga': 2100},
];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                  (route) => false
                );
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome, $email!',
            style: const TextStyle(
              fontSize: 24, 
              fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Text('Daftar Saham:'),

             const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: sahamList.length,
                  itemBuilder: (context, index) {
                    final saham = sahamList[index];

                    return Card(
                      // Style card untuk tampilan saham
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ListTile(
                          leading: const Icon(Icons.show_chart, color: Colors.blue),
                          title: Text(
                            saham['kode'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(saham['nama']),
                          trailing: Text('Rp ${saham['harga']}', style: const TextStyle(fontWeight: FontWeight.bold))
                        ),
                      ),
                    );
                  },
                ),
              ),
            // Add more widgets for displaying stock information
          ],
        ),
      ),
    );
  }
}

