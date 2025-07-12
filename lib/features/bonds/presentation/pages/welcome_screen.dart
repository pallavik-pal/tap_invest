import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tap_invest/core/di/injection.dart';
import 'package:tap_invest/features/bonds/cubit/bond_list_cubit.dart';
import 'package:tap_invest/features/bonds/presentation/pages/bond_list_page.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (_) => getIt<BondListCubit>()..fetchBonds(),
            child: const BondListPage(),
          ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181818),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              const Text(
                "Welcome to Tap Invest",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              const Text(
                "Smart way to invest in Bonds",
                style: TextStyle(
                  fontSize: 16,
                  color: Color(0xFFAAAAAA),
                ),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 2),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
