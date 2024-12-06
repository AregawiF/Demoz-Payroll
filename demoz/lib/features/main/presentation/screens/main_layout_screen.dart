import 'package:flutter/material.dart';
import '../../../home/presentation/screens/home_screen.dart';
import '../../../payroll/presentation/screens/payroll_screen.dart';
import '../../../company/presentation/screens/company_profile_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/screens/onboarding_screen.dart';
import '../../../employee/presentation/bloc/employee_bloc.dart';
import '../../../employee/presentation/bloc/employee_event.dart';

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

  @override
  void initState() {
    super.initState();
    // if (mounted) {
      context.read<EmployeeBloc>().add(GetEmployeeStatsEvent());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is! Authenticated) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pushNamedAndRemoveUntil(
              '/login',
              (route) => false,
            );
          });
          return const SizedBox.shrink();
        }

        return Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _selectedIndex,
            selectedItemColor: const Color(0xFF3085FE),
            unselectedItemColor: Colors.grey,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white,
            elevation: 0,
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
      },
    );
  }
}
