import 'package:flutter/material.dart';
import 'core/di/injection.dart';
import 'features/bonds/data/repositories/bond_api_service.dart';
import 'features/bonds/presentation/pages/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  // Optional: Preload bonds (for debugging/logging)
  final bondService = getIt<BondApiService>();
  final bonds = await bondService.fetchBonds();
  print("📦 Loaded ${bonds.length} bonds");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TAP Invest Assignment',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF181818),

        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.indigo,
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}
