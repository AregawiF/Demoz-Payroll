import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/form_validators.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/screens/signup_screen.dart';

class CompanyRegistrationScreen extends StatefulWidget {
  final String email;
  final String password;

  const CompanyRegistrationScreen({
    super.key,
    required this.email,
    required this.password,
  });

  @override
  State<CompanyRegistrationScreen> createState() =>
      _CompanyRegistrationScreenState();
}

class _CompanyRegistrationScreenState extends State<CompanyRegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  final _companyNameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _tinNumberController = TextEditingController();
  final _employeeCountController = TextEditingController();
  final _bankNameController = TextEditingController();
  final _accountNumberController = TextEditingController();
  bool _isFormValid = false;

  @override
  void initState() {
    super.initState();
    // Add listeners to all controllers
    _companyNameController.addListener(_validateForm);
    _addressController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
    _tinNumberController.addListener(_validateForm);
    _employeeCountController.addListener(_validateForm);
    _bankNameController.addListener(_validateForm);
    _accountNumberController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _companyNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _tinNumberController.dispose();
    _employeeCountController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      _isFormValid = _companyNameController.text.isNotEmpty &&
          _addressController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty &&
          _tinNumberController.text.isNotEmpty &&
          _employeeCountController.text.isNotEmpty &&
          _bankNameController.text.isNotEmpty &&
          _accountNumberController.text.isNotEmpty;
    });
  }

  void _handleRegister() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(
            RegisterRequested(
              email: widget.email,
              password: widget.password,
              companyName: _companyNameController.text,
              companyAddress: _addressController.text,
              phoneNumber: _phoneController.text,
              tinNumber: _tinNumberController.text,
              numberOfEmployees: int.parse(_employeeCountController.text),
              companyBank: _bankNameController.text,
              bankAccountNumber: _accountNumberController.text,
            ),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => SignupScreen(
                  initialEmail: widget.email,
                  initialPassword: widget.password,
                ),
              ),
            );
          },
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            } else if (state is Authenticated) {
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(text: 'Register your company\n'),
                          TextSpan(text: 'to '),
                          TextSpan(
                            text: 'Demoz Payroll',
                            style: TextStyle(color: Color(0xFF579AFC)),
                          ),
                        ],
                      ),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Register your company to continue',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      controller: _companyNameController,
                      decoration: _inputDecoration('Company Name', Icons.business),
                      validator: FormValidators.companyNameValidator,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _addressController,
                      decoration: _inputDecoration('Company Address', Icons.location_on),
                      validator: FormValidators.addressValidator,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      decoration: _inputDecoration('Phone Number', Icons.phone),
                      keyboardType: TextInputType.phone,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: FormValidators.phoneNumberValidator,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _tinNumberController,
                      decoration: _inputDecoration('TIN Number', Icons.numbers),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: FormValidators.tinNumberValidator,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _employeeCountController,
                      decoration: _inputDecoration('Number of Employees', Icons.people),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: FormValidators.numberOfEmployeesValidator,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _bankNameController,
                      decoration: _inputDecoration('Company Bank', Icons.account_balance),
                      validator: FormValidators.bankNameValidator,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _accountNumberController,
                      decoration: _inputDecoration('Bank Account Number', Icons.account_balance_wallet),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      validator: FormValidators.bankAccountValidator,
                    ),
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: state is! AuthLoading && _isFormValid
                          ? _handleRegister
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF579AFC),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: state is AuthLoading
                          ? const SizedBox(
                              height: 20,
                              width: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  Colors.white,
                                ),
                              ),
                            )
                          : const Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF579AFC)),
      ),
      floatingLabelStyle: const TextStyle(color: Color(0xFF579AFC)),
    );
  }
}
