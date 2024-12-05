import 'package:hive/hive.dart';
import '../../domain/entities/employee.dart';

part 'employee_model.g.dart';

@HiveType(typeId: 0)
class EmployeeModel extends Employee {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final double salary;

  @HiveField(4)
  final double incomeTax;

  @HiveField(5)
  final double pensionTax;

  @HiveField(6)
  final String gender;

  @HiveField(7)
  final DateTime joiningDate;

  @HiveField(8)
  final bool isActive;

  @HiveField(9) 
  final double grossPay;

  @HiveField(10) 
  final double taxableEarnings;

  const EmployeeModel({
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
  }) : super(
          id: id,
          name: name,
          email: email,
          salary: salary,
          incomeTax: incomeTax,
          pensionTax: pensionTax,
          gender: gender,
          joiningDate: joiningDate,
          isActive: isActive,
          grossPay: grossPay,
          taxableEarnings: taxableEarnings,
        );

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      salary: json['salary'].toDouble(),
      incomeTax: json['incomeTax'].toDouble(),
      pensionTax: json['pensionTax'].toDouble(),
      gender: json['gender'],
      joiningDate: DateTime.parse(json['joiningDate']),
      isActive: json['isActive'],
      grossPay: json['grossPay'].toDouble(),
      taxableEarnings: json['taxableEarnings'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'salary': salary,
      'incomeTax': incomeTax,
      'pensionTax': pensionTax,
      'gender': gender,
      'joiningDate': joiningDate.toIso8601String(),
      'isActive': isActive,
      'grossPay': grossPay,
      'taxableEarnings': taxableEarnings,
    };
  }

  factory EmployeeModel.fromEntity(Employee employee) {
    return EmployeeModel(
      id: employee.id,
      name: employee.name,
      email: employee.email,
      salary: employee.salary,
      incomeTax: employee.incomeTax,
      pensionTax: employee.pensionTax,
      gender: employee.gender,
      joiningDate: employee.joiningDate,
      isActive: employee.isActive,
      grossPay: employee.grossPay,
      taxableEarnings: employee.taxableEarnings,
    );
  }
}
