import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../features/auth/presentation/screens/signup_screen.dart';

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
        child: SingleChildScrollView(
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
                  decoration: InputDecoration(
                    labelText: 'Company Name',
                    hintText: 'Enter company name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    floatingLabelStyle: const TextStyle(color: Color(0xFF579AFC)),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Company name is required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Company Address',
                    hintText: 'Enter company address',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    floatingLabelStyle: const TextStyle(color: Color(0xFF579AFC)),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Address is required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    hintText: 'Enter phone number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    floatingLabelStyle: const TextStyle(color: Color(0xFF579AFC)),
                  ),
                  keyboardType: TextInputType.phone,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Phone number is required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _tinNumberController,
                  decoration: InputDecoration(
                    labelText: 'TIN Number',
                    hintText: 'Enter TIN number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    floatingLabelStyle: const TextStyle(color: Color(0xFF579AFC)),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'TIN number is required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _employeeCountController,
                  decoration: InputDecoration(
                    labelText: 'Number of Employees',
                    hintText: 'Enter number of employees',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    floatingLabelStyle: const TextStyle(color: Color(0xFF579AFC)),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Number of employees is required'
                      : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _bankNameController,
                  decoration: InputDecoration(
                    labelText: 'Company Bank',
                    hintText: 'Enter bank name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    floatingLabelStyle: const TextStyle(color: Color(0xFF579AFC)),
                  ),
                  validator: (value) =>
                      value?.isEmpty ?? true ? 'Bank name is required' : null,
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _accountNumberController,
                  decoration: InputDecoration(
                    labelText: 'Bank Account Number',
                    hintText: 'Enter bank account number',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    floatingLabelStyle: const TextStyle(color: Color(0xFF579AFC)),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) => value?.isEmpty ?? true
                      ? 'Bank account number is required'
                      : null,
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _isFormValid
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            // Navigate to home screen after successful registration
                            Navigator.pushReplacementNamed(context, '/home');
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF579AFC),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                    disabledBackgroundColor: Colors.grey.shade300,
                  ),
                  child: const Text(
                    'Submit for Approval',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
