import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_invest/features/bonds/cubit/bond_detail_cubit.dart';
import 'package:tap_invest/features/bonds/data/models/bond_detail_model.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../../core/di/injection.dart';

class BondDetailPage extends StatelessWidget {
  final String isin;

  const BondDetailPage({super.key, required this.isin});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<BondDetailCubit>()..fetchDetails(isin),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB),
        body: SafeArea(
          child: BlocBuilder<BondDetailCubit, BondDetailState>(
            builder: (context, state) {
              return state.when(
                initial: () => const SizedBox(),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (msg) => Center(child: Text(msg)),
                loaded: (detail) => _BondDetailContent(detail: detail),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _BondDetailContent extends StatefulWidget {
  final BondDetailModel detail;

  const _BondDetailContent({required this.detail});

  @override
  State<_BondDetailContent> createState() => _BondDetailContentState();
}

class _BondDetailContentState extends State<_BondDetailContent> {
  bool showProsCons = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                widget.detail.logo,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.image_not_supported),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.detail.companyName,
              style:
              const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Text(
          widget.detail.description,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFE7ECFD),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Text(
                'ISIN: ${widget.detail.isin}',
                style: const TextStyle(
                    color: Color(0xFF1A4EFF), fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: const Color(0xFFDFF6EA),
                borderRadius: BorderRadius.circular(6),
              ),
              child: const Text(
                'ACTIVE',
                style: TextStyle(
                    color: Color(0xFF31C77A), fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          children: [
            GestureDetector(
              onTap: () => setState(() => showProsCons = false),
              child: Column(
                children: [
                  Text(
                    "ISIN Analysis",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: showProsCons
                          ? Colors.black54
                          : const Color(0xFF1A4EFF),
                    ),
                  ),
                  if (!showProsCons)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      height: 2,
                      width: 90,
                      color: const Color(0xFF1A4EFF),
                    )
                ],
              ),
            ),
            const SizedBox(width: 24),
            GestureDetector(
              onTap: () => setState(() => showProsCons = true),
              child: Column(
                children: [
                  Text(
                    "Pros & Cons",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: showProsCons
                          ? const Color(0xFF1A4EFF)
                          : Colors.black54,
                    ),
                  ),
                  if (showProsCons)
                    Container(
                      margin: const EdgeInsets.only(top: 4),
                      height: 2,
                      width: 90,
                      color: const Color(0xFF1A4EFF),
                    )
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        if (showProsCons) ...[
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 6,
                    offset: const Offset(0, 3))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Pros",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, height: 1.5)),
                const SizedBox(height: 12),
                ...widget.detail.prosAndCons.pros.map(
                      (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.check_circle_outline,
                            color: Colors.green, size: 20),
                        const SizedBox(width: 6),
                        Expanded(
                            child: Text(e,
                                style: const TextStyle(
                                    height: 2,
                                    fontSize: 14,
                                    color: Colors.black))),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text("Cons",
                    style:
                    TextStyle(fontWeight: FontWeight.bold, height: 1.5)),
                const SizedBox(height: 12),
                ...widget.detail.prosAndCons.cons.map(
                      (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.error_outline,
                            color: Colors.orange, size: 20),
                        const SizedBox(width: 6),
                        Expanded(
                            child: Text(e,
                                style: const TextStyle(
                                    height: 2,
                                    fontSize: 14,
                                    color: Colors.black))),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ] else ...[
          FinancialChartCard(
            revenueData: widget.detail.financials.revenue,
            ebitdaData: widget.detail.financials.ebitda,
          ),
          const SizedBox(height: 16),
          Container(
            padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
            margin: const EdgeInsets.only(bottom: 24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFE0E0E0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title with icon and divider
                Row(
                  children: const [
                    Icon(Icons.contact_page_outlined,
                        size: 18, color: Colors.black87),
                    SizedBox(width: 8),
                    Text(
                      "Issuer Details",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const Divider(color: Color(0xFFE0E0E0), thickness: 1),
                _buildStyledDetail(
                    "Issuer Name", widget.detail.issuerDetails.issuerName),
                _buildStyledDetail("Type of Issuer",
                    widget.detail.issuerDetails.typeOfIssuer),
                _buildStyledDetail(
                    "Sector", widget.detail.issuerDetails.sector),
                _buildStyledDetail(
                    "Industry", widget.detail.issuerDetails.industry),
                _buildStyledDetail("Issuer nature",
                    widget.detail.issuerDetails.issuerNature),
                _buildStyledDetail("Corporate Identity Number (CIN)",
                    widget.detail.issuerDetails.cin),
                _buildStyledDetail("Name of the Lead Manager",
                    widget.detail.issuerDetails.leadManager),
                _buildStyledDetail(
                    "Registrar", widget.detail.issuerDetails.registrar),
                _buildStyledDetail("Name of Debenture Trustee",
                    widget.detail.issuerDetails.debentureTrustee),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStyledDetail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1A4EFF), // Blue label
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value.isNotEmpty ? value : "-",
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}


class FinancialChartCard extends StatefulWidget {
  final List<MonthData> revenueData;
  final List<MonthData> ebitdaData;

  const FinancialChartCard({super.key, required this.revenueData, required this.ebitdaData});

  @override
  State<FinancialChartCard> createState() => _FinancialChartCardState();
}

class _FinancialChartCardState extends State<FinancialChartCard> {
  String selectedMetric = 'EBITDA';

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 6, offset: const Offset(0, 3)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text("COMPANY FINANCIALS", style: TextStyle(fontWeight: FontWeight.w600,color:Colors.grey,)),
              const Spacer(),
              Container(
                height: 30,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: const Color(0xFFEDEDED),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => setState(() => selectedMetric = 'EBITDA'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: selectedMetric == 'EBITDA' ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'EBITDA',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: selectedMetric == 'EBITDA' ? Colors.black : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => selectedMetric = 'Revenue'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        decoration: BoxDecoration(
                          color: selectedMetric == 'Revenue' ? Colors.white : Colors.transparent,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Revenue',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: selectedMetric == 'Revenue' ? Colors.black : Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceBetween,
                maxY: 35,
                barGroups: List.generate(widget.revenueData.length, (index) {
                  final revenue = widget.revenueData[index].value / 1000000;
                  final ebitda = widget.ebitdaData[index].value / 1000000;

                  final bool isEBITDAMode = selectedMetric == 'EBITDA';

                  return BarChartGroupData(
                    x: index,
                    barRods: [
                      BarChartRodData(
                        toY: revenue,
                        width: 12,
                        color: isEBITDAMode ? Colors.blue.shade100 : Colors.blue.shade400,
                        borderRadius: BorderRadius.zero,
                        rodStackItems: isEBITDAMode
                            ? [
                          BarChartRodStackItem(
                            0,
                            ebitda.clamp(0, revenue),
                            Colors.black,
                          ),
                          if (ebitda > revenue)
                            BarChartRodStackItem(
                              revenue,
                              ebitda,
                              Colors.black,
                            ),
                        ]
                            : [],
                      ),
                    ],
                  );
                }),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, _) {
                        if (value == 10) return const Text("\u20B91L");
                        if (value == 20) return const Text("\u20B92L");
                        if (value == 30) return const Text("\u20B93L");
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, _) {
                        final index = value.toInt();
                        return Text(widget.revenueData[index % widget.revenueData.length].month);
                      },
                    ),
                  ),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(
                  show: true,
                  drawHorizontalLine: true,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.grey.shade300,
                    strokeWidth: 1,
                  ),
                ),
                barTouchData: BarTouchData(enabled: false),
              ),
            ),
          ),
        ],
      ),
    );
  }
}