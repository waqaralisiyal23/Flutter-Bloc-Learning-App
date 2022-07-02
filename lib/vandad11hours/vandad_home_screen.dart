import 'package:bloclearning/vandad11hours/json_files/json_example_screen.dart';
import 'package:bloclearning/vandad11hours/random_names/random_names_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VandadHomeScreen extends StatelessWidget {
  const VandadHomeScreen({Key? key}) : super(key: key);

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
                onPressed: () => Get.to(() => const RandomNamesScreen()),
                child: const Text(
                  'A simple app that can pick random names from an '
                  'Iterable<String> using cubits.',
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => Get.to(() => const JsonExampleScreen()),
                child: const Text(
                  'An app that can load various JSON files and display them.',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
