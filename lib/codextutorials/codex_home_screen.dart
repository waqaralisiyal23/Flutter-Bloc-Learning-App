import 'package:bloclearning/codextutorials/part1/counter_example_screen.dart';
import 'package:bloclearning/codextutorials/part2/news_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CodexHomeScreen extends StatelessWidget {
  const CodexHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Bloc'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () => Get.to(() => const CounterExampleScreen()),
                child: const Text('Part 1'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Get.to(() => const NewsScreen()),
                child: const Text('Part 2'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
