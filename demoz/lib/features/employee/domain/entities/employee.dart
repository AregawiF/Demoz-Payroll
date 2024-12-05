import 'package:equatable/equatable.dart';

class Employee extends Equatable {
  final String id;
  final String name;
  final String email;
  final double salary;
  final double incomeTax;
  final double pensionTax;
  final String gender;
  final DateTime joiningDate;
  final bool isActive;
  final double grossPay;
  final double taxableEarnings;
  

  const Employee({
    required this.id,
    required this.name,
    required this.email,
    required this.salary,
    required this.incomeTax,
    required this.pensionTax,
    required this.gender,
    required this.joiningDate,
    required this.isActive,
    required this.grossPay,
    required this.taxableEarnings,
  });

  @override
  List<Object> get props => [
    id,
    name,
    email,
    salary,
    incomeTax,
    pensionTax,
    gender,
    joiningDate,
    isActive,
    grossPay,
    taxableEarnings,
  ];
}
