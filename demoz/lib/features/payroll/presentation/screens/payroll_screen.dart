import 'package:flutter/material.dart';
import 'package:demoz/features/employee/presentation/screens/add_employee_screen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../employee/presentation/bloc/employee_bloc.dart';
import '../../../employee/presentation/bloc/employee_event.dart';
import '../../../employee/presentation/bloc/employee_state.dart';
import '../../../employee/domain/entities/employee.dart'; 

class PayrollScreen extends StatefulWidget {
  const PayrollScreen({super.key});

  @override
  State<PayrollScreen> createState() => _PayrollScreenState();
}

class _PayrollScreenState extends State<PayrollScreen> {
  final ScrollController _horizontalScrollController = ScrollController();
  int _selectedIndex = 1;  // Set initial index to 1 for middle button
  String? _selectedFileName;

   @override
  void initState() {
    super.initState();
    // Fetch employees when the screen initializes
    context.read<EmployeeBloc>().add(GetEmployeesEvent());
  }

  Future<void> _pickCSVFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['csv'],
      );

      if (result != null) {
        setState(() {
          _selectedFileName = result.files.single.name;
        });
      }
    } catch (e) {
      // Handle any errors that occur during file picking
      debugPrint('Error picking file: $e');
    }
  }

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeBloc, EmployeeState>(
      listener: (context, state) {
        if (state is EmployeeOperationSuccess) {
          // Refresh the employee list after a successful operation
          context.read<EmployeeBloc>().add(GetEmployeesEvent());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is EmployeeError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is EmployeeLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is EmployeesLoaded) {
          return _buildPayrollContent(context, state.employees);
        }

        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  @override
  Widget _buildPayrollContent(BuildContext context, List<Employee> employees) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            const Text(
              'Management',
              style: TextStyle(
                fontWeight: FontWeight.w800,
              ),
            ),
            const Spacer(),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddEmployeeScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF16C098),
                foregroundColor: Colors.white,
              ),
              icon: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.add, size: 16),
              ),
              label: const Text('Add Employee'),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _pickCSVFile,
                  icon: const Icon(Icons.upload_file),
                  label: const Text('Upload CSV'),
                ),
                if (_selectedFileName != null) ...[
                  const SizedBox(width: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.description, size: 16, color: Color(0xFF3085FE)),
                        const SizedBox(width: 8),
                        Text(
                          _selectedFileName!,
                          style: const TextStyle(color: Color(0xFF3085FE)),
                        ),
                      ],
                    ),
                  ),
                ],
                const SizedBox(width: 12),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // TODO: Implement PDF download
                  },
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('Download PDF'),
                  style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                  ),
                ),
              ]
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              controller: _horizontalScrollController,
              child: DataTable(
                headingRowColor: MaterialStateProperty.all(Colors.grey[200]),
                columns: const [
                  DataColumn(label: Text('Employee')),
                  DataColumn(label: Text('Net Salary')),
                  DataColumn(label: Text('Taxable\nEarnings')),
                  DataColumn(label: Text('Income\nTax')),
                  DataColumn(label: Text('Pension\nTax')),
                  DataColumn(label: Text('Gross\nPay')),
                  DataColumn(label: Text('Actions')),
                ],
                // rows: [
                //   _buildDataRow('Abraham Welde', '15,000', '2000', '5000', '5000', '20,000'),
                //   _buildDataRow('Birant Alemu', '25,000', '3000', '7000', '7000', '30,000'),
                //   _buildDataRow('Birate Girum', '15,000', '2000', '5000', '5000', '20,000'),
                //   _buildDataRow('Alemu Molla', '15,000', '2000', '5000', '5000', '20,000'),
                // ],
                rows: employees.map((employee) {
                  return _buildDataRow(
                    employee.name,
                    '${employee.salary}', 
                    '${employee.salary}',
                    '${employee.incomeTax}',
                    '${employee.pensionTax}',
                    '${employee.salary}',
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3085FE),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  minimumSize: const Size(double.infinity, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Bulk Pay',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  DataRow _buildDataRow(String name, String netSalary, String taxableEarnings, 
      String incomeTax, String pensionTax, String grossPay) {
    return DataRow(
      cells: [
        DataCell(Container(
          color: const Color(0xFFE5F6FF),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(name),
        )),
        DataCell(Text(netSalary)), // No background color
        DataCell(Container(
          color: const Color(0xFFE5F6FF),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(taxableEarnings),
        )),
        DataCell(Text(incomeTax)), // No background color
        DataCell(Container(
          color: const Color(0xFFE5F6FF),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Text(pensionTax),
        )),
        DataCell(Text(grossPay)), // No background color
        DataCell(
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF30BEB6),
              foregroundColor: Colors.white,
              minimumSize: const Size(60, 36),
            ),
            child: const Text('Pay'),
          ),
        ),
      ],
    );
  }
}