import 'package:flutter/material.dart';
import 'package:demoz/features/employee/presentation/screens/add_employee_screen.dart';
import 'package:demoz/features/company/presentation/screens/company_profile_screen.dart';

class PayrollScreen extends StatefulWidget {
  const PayrollScreen({super.key});

  @override
  State<PayrollScreen> createState() => _PayrollScreenState();
}

class _PayrollScreenState extends State<PayrollScreen> {
  final ScrollController _horizontalScrollController = ScrollController();
  int _selectedIndex = 1;  // Set initial index to 1 for middle button

  @override
  void dispose() {
    _horizontalScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Management',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          FilledButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddEmployeeScreen()),
              );
            },
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF30BEB6),
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.add),
            label: const Text('Add Employee'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilledButton.icon(
                      onPressed: () {},
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.grey[200],
                        foregroundColor: Colors.black87,
                      ),
                      icon: const Icon(Icons.upload_file),
                      label: const Text('Upload CSV'),
                    ),
                  ],
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
                    rows: [
                      _buildDataRow('Abraham Welde', '15,000', '2000', '5000', '5000', '20,000'),
                      _buildDataRow('Birant Alemu', '25,000', '3000', '7000', '7000', '30,000'),
                      _buildDataRow('Birate Girum', '15,000', '2000', '5000', '5000', '20,000'),
                      _buildDataRow('Alemu Molla', '15,000', '2000', '5000', '5000', '20,000'),
                    ],
                  ),
                ),
                const SizedBox(height: 80), // Space for bottom button
              ],
            ),
          ),
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: FilledButton.icon(
              onPressed: () {},
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF30BEB6),
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              icon: const Icon(Icons.payments_outlined),
              label: const Text(
                'Bulk Pay',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
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
              if (index == 0) {
                Navigator.pop(context);
              } else if (index == 1) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PayrollScreen()),
                );
              } else if (index == 2) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const CompanyProfileScreen()),
                );
              }
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
                      'assets/icons/profile.png',
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
          FilledButton(
            onPressed: () {},
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFF30BEB6),
              minimumSize: const Size(60, 36),
            ),
            child: const Text('Pay'),
          ),
        ),
      ],
    );
  }

}
