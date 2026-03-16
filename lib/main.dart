import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'pages/title.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky); // Hides status and navigation bars for a full-screen experience

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});                     

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TitlePage(),
    );
  }
}