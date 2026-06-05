import 'package:flutter/material.dart';
import 'router.dart';

void main() {
  runApp(const ClimaFlowApp());
}

class ClimaFlowApp extends StatelessWidget {
  const ClimaFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ClimaFlow',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
