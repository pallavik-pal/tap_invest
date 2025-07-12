import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_invest/features/bonds/cubit/bond_list_cubit.dart';
import '../widgets/bond_search_card.dart';
import 'package:tap_invest/features/bonds/data/models/bond_model.dart';
import 'bond_detail_page.dart';

class BondListPage extends StatefulWidget {
  const BondListPage({super.key});

  @override
  State<BondListPage> createState() => _BondListPageState();
}

class _BondListPageState extends State<BondListPage> {
  final TextEditingController _searchController = TextEditingController();

  List<BondModel> _filterBonds(List<BondModel> bonds) {
    final query = _searchController.text.trim().toLowerCase();

    if (query.isEmpty) return bonds;

    final keywords = query
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList();

    return bonds.where((bond) {
      final combined = '${bond.companyName} ${bond.isin} ${bond.tags.join(" ")}'
          .toLowerCase();
      return keywords.any((word) => combined.contains(word));
    }).toList();
  }

  @override
  void initState() {
    super.initState();
    context.read<BondListCubit>().fetchBonds();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6F9),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Home",
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (_) => setState(() {}),
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.search, color: Colors.grey),
                        hintText: 'Search by Issuer Name or ISIN',
                        hintStyle: TextStyle(color: Colors.grey),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 16),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "SUGGESTED RESULTS",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.2,
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: BlocBuilder<BondListCubit, BondListState>(
                  builder: (context, state) {
                    return state.when(
                      initial: () => const SizedBox(),
                      loading: () => const Center(child: CircularProgressIndicator()),
                      error: (msg) => Center(child: Text(msg)),
                      loaded: (bonds) {
                        final filtered = _filterBonds(bonds);
                        return ListView.builder(
                          itemCount: filtered.length,
                          itemBuilder: (context, index) {
                            final bond = filtered[index];
                            return BondSearchCard(
                              logo: bond.logo,
                              isin: bond.isin,
                              rating: bond.rating,
                              company: bond.companyName,
                              searchTerm: _searchController.text,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BondDetailPage(isin: bond.isin),
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
