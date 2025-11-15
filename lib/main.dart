import 'package:flutter/material.dart';
import 'package:flutter_biometric_change_detector/flutter_biometric_change_detector.dart';
import 'package:flutter_biometric_change_detector/status_enum.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biometric Change Detector Demo',
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _status = "Belum dicek";

  Future<void> _checkBiometric() async {
    try {
      final result =
          await FlutterBiometricChangeDetector.detectBiometricChange();

      setState(() {
        _status =
            (result == AuthChangeStatus.CHANGED)
                ? "⚠️ Biometrik telah berubah!"
                : "✅ Biometrik masih sama, aman.";
      });
    } catch (e) {
      setState(() {
        _status = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Biometric Change Detector")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_status),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _checkBiometric,
              child: const Text("Cek Biometric"),
            ),
          ],
        ),
      ),
    );
  }
}

class BiometricService {
  final _biometricChangeDetector =
      FlutterBiometricChangeDetector.checkBiometric();

  Future<bool> hasBiometricChanged() async {
    try {
      final bool changed = await _biometricChangeDetector.hasBiometricChanged();
      return changed;
    } catch (e) {
      print("Error checking biometric changes: $e");
      return false;
    }
  }
}
