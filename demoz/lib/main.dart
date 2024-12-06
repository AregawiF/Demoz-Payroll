import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/injection/injection_container.dart' as di;
import 'features/employee/presentation/bloc/employee_bloc.dart';
import 'features/employee/presentation/bloc/employee_event.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/screens/onboarding_screen.dart';
import 'features/auth/presentation/screens/signup_screen.dart';
import 'features/auth/presentation/screens/login_screen.dart';
import 'features/home/presentation/screens/home_screen.dart';
import 'features/main/presentation/screens/main_layout_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            final bloc = di.sl<EmployeeBloc>();
            bloc.add(GetEmployeeStatsEvent());
            return bloc;
          },
        ),
        BlocProvider(
          create: (context) {
            final bloc = di.sl<AuthBloc>();
            bloc.add(CheckAuthStatus());
            return bloc;
          },
        ),
      ],
      child: MaterialApp(
        title: 'Demoz Payroll',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3085FE)),
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
            
            if (state is Authenticated) {
              return const MainLayoutScreen();
            }
            
            if (state is AuthError) {
              return const OnboardingScreen();
            }
            return const OnboardingScreen();
          },
        ),
        routes: {
          '/login': (context) => const LoginScreen(),
          '/signup': (context) => const SignupScreen(),
          '/home': (context) => const MainLayoutScreen(),
        },
      ),
    );
  }
}
