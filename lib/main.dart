import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'telas/telaHomePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageData>(
      create: (_) => HomePageData(),
      child: MaterialApp(
        title: 'Organizador de Eventos',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}

// A Home real está em telas/telaHomePage.dart (HomeScreen)
