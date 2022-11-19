import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:timer_app/providers/timer_provider.dart';
import 'package:timer_app/screens/screens.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return ChangeNotifierProvider(
      create: (_) => TimerProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: HomeScreen(),
      ),
    );
    
  }
}