import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:demoz/features/payroll/presentation/screens/payroll_screen.dart';
import 'package:demoz/features/company/presentation/screens/company_profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 0;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  Widget _buildStatCard(String title, String value, Color color, int index) {
    return Card(
      color: color.withOpacity(0.1),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: color,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              softWrap: true,
              overflow: TextOverflow.visible,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaxCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Date',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Aug 1, 2024 - Aug 30, 2024', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFE7E4),
                    foregroundColor: const Color(0xFFFF7F74),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Pay Now'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Income Tax'),
                      SizedBox(height: 4),
                      Text(
                        '4000 ETB',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Pension Tax'),
                      SizedBox(height: 4),
                      Text(
                        '5000 ETB',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 100,
                  child: const Text(
                    'August Tax\non due',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFFF7F74),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmployeeCompositionCard() {
    // Sample data - replace with real data
    const malePercentage = 60.0;
    const femalePercentage = 40.0;
    const totalEmployees = 125;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Employee Composition',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/icons/fa-solid_male.png',
                      width: 20,
                      height: 20,
                      color: const Color(0xFF16C098),
                    ),
                    const Text('60%'),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: SizedBox(
                  height: 110,
                  child: PieChart(
                    PieChartData(
                      sections: [
                        PieChartSectionData(
                          value: 60,
                          color: const Color(0xFF16C098),
                          radius: 20,
                          showTitle: false,
                        ),
                        PieChartSectionData(
                          value: 40,
                          color: const Color(0xFF5932EA),
                          radius: 25,
                          showTitle: false,
                        ),
                      ],
                      centerSpaceRadius: 30,
                      sectionsSpace: 2,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Image.asset(
                      'assets/icons/fa-solid_female.png',
                      width: 20,
                      height: 20,
                      color: const Color(0xFF5932EA),
                    ),
                    const Text('40%'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              '$totalEmployees employees total',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaxSummaryCard() {
    // Sample data - replace with real data
    const amount = "125,000";
    const percentage = 12.5;
    const isIncrease = true;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tax Summary',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            '$amount ETB',
            style: const TextStyle(
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                isIncrease ? Icons.arrow_upward : Icons.arrow_downward,
                size: 16,
                color: isIncrease ? const Color(0xFF25D036) : Colors.red,
              ),
              const SizedBox(width: 4),
              Text(
                '${percentage.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: isIncrease ? const Color(0xFF25D036) : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUpcomingPaymentTab() {
    return _buildTaxCard();
  }

  Widget _buildPastPaymentTab() {
    return const Center(child: Text('No past payments'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.grey[100],
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'Home',
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Number of Employees',
                      '20',
                      const Color(0xFF3085FE),
                      0,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      'Income Tax paid',
                      '2000',
                      const Color(0xFFA3D139),
                      1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: _buildStatCard(
                      'Pension Tax paid',
                      '4',
                      const Color(0xFF30BEB6),
                      2,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildStatCard(
                      'Employees Performance',
                      '95 %',
                      const Color(0xFFFF7F74),
                      3,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedTab = 0;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedTab == 0
                            ? const Color(0xFF579AFC)
                            : Colors.grey.shade100,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Upcoming',
                        style: TextStyle(
                          fontSize: 16,
                          color: _selectedTab == 0
                              ? Colors.white
                              : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _selectedTab = 1;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _selectedTab == 1
                            ? const Color(0xFF579AFC)
                            : Colors.grey.shade100,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        'Past',
                        style: TextStyle(
                          fontSize: 16,
                          color: _selectedTab == 1
                              ? Colors.white
                              : Colors.grey.shade700,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 200,
                child: _selectedTab == 0
                    ? _buildUpcomingPaymentTab()
                    : _buildPastPaymentTab(),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 250,
                      child: Card(
                        color: Colors.white,
                        child: _buildEmployeeCompositionCard(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: SizedBox(
                      height: 250,
                      child: Card(
                        color: Colors.white,
                        child: _buildTaxSummaryCard(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
