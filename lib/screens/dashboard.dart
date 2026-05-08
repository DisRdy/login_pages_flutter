import 'package:flutter/material.dart';
import 'login.dart';

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
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
              context, 
              MaterialPageRoute(
                builder: (context) => LoginScreen()), 
                (route) => false);


              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Logged out successfully!"),
                  backgroundColor: Colors.green,
                ),
              );
            },
          )
        ],
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
          ],
        ),
      ),
    );
  }
}
