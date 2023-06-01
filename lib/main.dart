import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player_tes/bloc/home_bloc_bloc.dart';
import 'package:music_player_tes/screens/home_screen.dart';
import 'package:music_player_tes/utils/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        iconTheme: const IconThemeData(color: kWhite),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
