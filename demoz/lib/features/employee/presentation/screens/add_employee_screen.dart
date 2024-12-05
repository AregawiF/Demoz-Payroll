import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/employee.dart';
import '../bloc/employee_bloc.dart';
import '../bloc/employee_event.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({super.key});

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _employeeNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _tinNumberController = TextEditingController();
  final _grossSalaryController = TextEditingController();
  final _taxableEarningsController = TextEditingController();
  final _startDateController = TextEditingController();
  bool isPerMonth = true;
  bool isFormValid = false;
  DateTime? _selectedDate;

  @override
  void dispose() {
    _employeeNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _tinNumberController.dispose();
    _grossSalaryController.dispose();
    _taxableEarningsController.dispose();
    _startDateController.dispose();
    super.dispose();
  }

  void _validateForm() {
    setState(() {
      isFormValid = _formKey.currentState?.validate() ?? false;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _startDateController.text = picked.toIso8601String().split('T')[0];
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final employee = Employee(
        id: DateTime.now().toString(),
        name: _employeeNameController.text,
        email: _emailController.text,
        salary: double.parse(_grossSalaryController.text),
        incomeTax: double.parse(_taxableEarningsController.text) * 0.15, // 15% income tax
        pensionTax: double.parse(_grossSalaryController.text) * 0.07, // 7% pension
        gender: 'Male', // TODO: Add gender selection
        joiningDate: _selectedDate ?? DateTime.now(),
        isActive: true,
        grossPay: double.parse(_grossSalaryController.text),
        taxableEarnings: double.parse(_taxableEarningsController.text),
      );

      context.read<EmployeeBloc>().add(AddEmployeeEvent(employee));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Add Employee',
          style: TextStyle(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          onChanged: _validateForm,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Add New Employee',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Here you add your new employee and start ',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                  children: const [
                    TextSpan(
                      text: 'calculating his tax and salary',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _employeeNameController,
                decoration: const InputDecoration(labelText: 'Employee name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter employee name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email address'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email address';
                  }
                  if (!value.contains('@')) {
                    return 'Please enter valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter phone number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _tinNumberController,
                decoration: const InputDecoration(labelText: 'Tin number'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter TIN number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _grossSalaryController,
                decoration: const InputDecoration(labelText: 'Gross salary'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter gross salary';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter valid salary';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _taxableEarningsController,
                decoration: const InputDecoration(labelText: 'Taxable earnings'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter taxable earnings';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Please enter valid taxable earnings';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _startDateController,
                decoration: InputDecoration(
                  labelText: 'Start Date',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                readOnly: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please select a start date';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        setState(() {
                          isPerMonth = true;
                        });
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: isPerMonth ? const Color(0xFF3085FE) : Colors.grey[200],
                        foregroundColor: isPerMonth ? Colors.white : Colors.black87,
                      ),
                      child: const Text('per Month'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        setState(() {
                          isPerMonth = false;
                        });
                      },
                      style: FilledButton.styleFrom(
                        backgroundColor: !isPerMonth ? const Color(0xFF3085FE) : Colors.grey[200],
                        foregroundColor: !isPerMonth ? Colors.white : Colors.black87,
                      ),
                      child: const Text('per Contract'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: isFormValid ? _submitForm : null,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Add Employee',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
