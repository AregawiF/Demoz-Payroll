import 'package:flutter/material.dart';
import 'package:demoz/features/home/presentation/screens/home_screen.dart';
import 'package:demoz/features/payroll/presentation/screens/payroll_screen.dart';
import 'package:demoz/features/company/presentation/screens/company_profile_screen.dart';

class MainLayoutScreen extends StatefulWidget {
  const MainLayoutScreen({super.key});

  @override
  State<MainLayoutScreen> createState() => _MainLayoutScreenState();
}

class _MainLayoutScreenState extends State<MainLayoutScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger the event here
    context.read<EmployeeBloc>().add(GetEmployeeStatsEvent()); 
  }
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const PayrollScreen(),
    const CompanyProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF3085FE),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 2,
                  width: 30,
                  color: _selectedIndex == 0 ? const Color(0xFF3085FE) : Colors.transparent,
                ),
                const SizedBox(height: 8),
                Image.asset(
                  'assets/icons/home-2.png',
                  height: 24,
                  width: 24,
                  color: _selectedIndex == 0 ? const Color(0xFF3085FE) : Colors.grey,
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
                  color: _selectedIndex == 1 ? const Color(0xFF3085FE) : Colors.transparent,
                ),
                const SizedBox(height: 8),
                Image.asset(
                  'assets/icons/note.png',
                  height: 24,
                  width: 24,
                  color: _selectedIndex == 1 ? const Color(0xFF3085FE) : Colors.grey,
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
                  color: _selectedIndex == 2 ? const Color(0xFF3085FE) : Colors.transparent,
                ),
                const SizedBox(height: 8),
                Image.asset(
                  'assets/icons/profile_icon.png',
                  height: 24,
                  width: 24,
                  color: _selectedIndex == 2 ? const Color(0xFF3085FE) : Colors.grey,
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
