import 'package:flutter/material.dart';
import '../../../features/home/presentation/screens/home_screen.dart';
import '../../../features/payroll/presentation/screens/payroll_screen.dart';
import '../../../features/company/presentation/screens/company_profile_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const PayrollScreen(),
    const CompanyProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Payroll',
          ),
          NavigationDestination(
            icon: Icon(Icons.business_outlined),
            selectedIcon: Icon(Icons.business),
            label: 'Company',
          ),
        ],
      ),
    );
  }
}
