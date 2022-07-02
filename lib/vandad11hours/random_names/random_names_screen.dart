import 'package:bloclearning/vandad11hours/random_names/names_cubit.dart';
import 'package:flutter/material.dart';

class RandomNamesScreen extends StatefulWidget {
  const RandomNamesScreen({Key? key}) : super(key: key);

  @override
  State<RandomNamesScreen> createState() => _RandomNamesScreenState();
}

class _RandomNamesScreenState extends State<RandomNamesScreen> {
  late final NamesCubit namesCubit;

  @override
  void initState() {
    super.initState();
    namesCubit = NamesCubit();
  }

  @override
  void dispose() {
    namesCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Random Names Exxample'),
      ),
      body: StreamBuilder<String?>(
        stream: namesCubit.stream,
        builder: (context, snapshot) {
          final TextButton textButton = TextButton(
            onPressed: () => namesCubit.pickRandomName(),
            child: const Text('Pick a Random Name'),
          );
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: textButton);
            case ConnectionState.waiting:
              return Center(child: textButton);
            case ConnectionState.active:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(snapshot.data ?? ''),
                    const SizedBox(height: 20),
                    textButton,
                  ],
                ),
              );
            case ConnectionState.done:
              return const SizedBox(); // Never reaches here because it keeps listening
          }
        },
      ),
    );
  }
}
