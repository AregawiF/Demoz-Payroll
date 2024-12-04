import 'package:flutter/material.dart';

class CompanyProfileScreen extends StatelessWidget {
  const CompanyProfileScreen({super.key});

  Widget _buildInfoItem(String label, String value, IconData icon) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(icon, size: 20, color: Colors.grey[600]),
              const SizedBox(width: 8),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Row(
          children: [
            Text(
              'Company Profile',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[200],
                  child: Image.asset(
                    'assets/icons/profile.png',
                    width: 60,
                    height: 60,
                    color: const Color(0xFF3085FE),
                  ),
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF3085FE),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Company Name',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Text(
              'HR Manager',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF3085FE),
              ),
            ),
            const SizedBox(height: 32),
            Card(
              margin: EdgeInsets.zero,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildInfoItem(
                      'Company Email',
                      'xxx@gmail.com',
                      Icons.email_outlined,
                    ),
                    const Divider(),
                    _buildInfoItem(
                      'Phone Number',
                      '+9312135',
                      Icons.phone_outlined,
                    ),
                    const Divider(),
                    _buildInfoItem(
                      'Company Address',
                      'Somewhere',
                      Icons.location_on_outlined,
                    ),
                    const Divider(),
                    _buildInfoItem(
                      'Number of Employees',
                      '20',
                      Icons.people_outline,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        selectedItemColor: const Color(0xFF3085FE),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          } else if (index == 1) {
            Navigator.pop(context);
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 2,
                  width: 30,
                  color: Colors.transparent,
                ),
                const SizedBox(height: 8),
                Image.asset(
                  'assets/icons/home-2.png',
                  height: 24,
                  width: 24,
                  color: Colors.grey,
                ),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 2,
                  width: 30,
                  color: Colors.transparent,
                ),
                const SizedBox(height: 8),
                Image.asset(
                  'assets/icons/note.png',
                  height: 24,
                  width: 24,
                  color: Colors.grey,
                ),
              ],
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 2,
                  width: 30,
                  color: const Color(0xFF3085FE),
                ),
                const SizedBox(height: 8),
                Image.asset(
                  'assets/icons/profile.png',
                  height: 24,
                  width: 24,
                  color: const Color(0xFF3085FE),
                ),
              ],
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
