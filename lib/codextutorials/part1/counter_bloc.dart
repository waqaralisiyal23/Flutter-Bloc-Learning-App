import 'dart:async';

enum CounterAction { increment, decrement, reset }

class CounterBloc {
  late int counter;

  final StreamController<int> _stateStreamController =
      StreamController<int>(); // Single Subscription
  // For multiple subscription
  // final StreamController<int> _stateStreamController =
  //     StreamController<int>.broadcast(); // For multiple subscription
  // For input
  StreamSink<int> get _counterSink => _stateStreamController.sink;
  // For output
  Stream<int> get counterStream => _stateStreamController.stream;

  final StreamController<CounterAction> _eventStreamController =
      StreamController<CounterAction>();
  StreamSink<CounterAction> get eventSink => _eventStreamController.sink;
  Stream<CounterAction> get _eventStream => _eventStreamController.stream;

  CounterBloc() {
    counter = 0;
    _eventStream.listen((event) {
      if (event == CounterAction.increment) {
        counter++;
      } else if (event == CounterAction.decrement) {
        counter--;
      } else if (event == CounterAction.reset) {
        counter = 0;
      }

      _counterSink.add(counter);
    });
  }

  void dispose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
