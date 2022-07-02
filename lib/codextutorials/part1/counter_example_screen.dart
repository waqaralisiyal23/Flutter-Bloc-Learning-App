import 'package:bloclearning/codextutorials/part1/counter_bloc.dart';
import 'package:flutter/material.dart';

class CounterExampleScreen extends StatefulWidget {
  const CounterExampleScreen({Key? key}) : super(key: key);

  @override
  State<CounterExampleScreen> createState() => _CounterExampleScreenState();
}

class _CounterExampleScreenState extends State<CounterExampleScreen> {
  final CounterBloc counterBloc = CounterBloc();

  @override
  void dispose() {
    counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CodeX Bloc Learning'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'You have pushed the button this many times:',
            ),
            StreamBuilder<int>(
                stream: counterBloc.counterStream,
                initialData: 0,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text('');
                  }
                  return Text(
                    '${snapshot.data}',
                    style: Theme.of(context).textTheme.headline4,
                  );
                }),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              counterBloc.eventSink.add(CounterAction.increment);
            },
            tooltip: 'Increment',
            heroTag: 'increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              counterBloc.eventSink.add(CounterAction.decrement);
            },
            tooltip: 'Decrement',
            heroTag: 'decrement',
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: () {
              counterBloc.eventSink.add(CounterAction.reset);
            },
            tooltip: 'Reset',
            heroTag: 'reset',
            child: const Icon(Icons.loop),
          ),
        ],
      ),
    );
  }
}
