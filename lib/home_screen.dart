// ignore_for_file: avoid_print

import 'dart:isolate';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Isolates")),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Lottie.asset('assets/animations.json'),
              ElevatedButton(
                  onPressed: () async {
                    var result = await testButton1();
                    print(result);
                  },
                  child: const Text("Button 1")),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  onPressed: () async {
                    ReceivePort receivePort = ReceivePort();
                    await Isolate.spawn(testButton2, receivePort.sendPort);
                    receivePort.listen((total) {
                      print("Isolates Result: $total");
                    });
                  },
                  child: const Text("Button 2")),
            ]),
      ),
    );
  }

  Future<double> testButton1() async {
    double total = 0.0;
    for (int i = 0; i < 1000000; i++) {
      total += i;
    }
    return total;
  }
}

testButton2(SendPort sendPort) async {
  double total = 0.0;
  for (int i = 0; i < 1000000; i++) {
    total += i;
  }
  sendPort.send(total);
}
