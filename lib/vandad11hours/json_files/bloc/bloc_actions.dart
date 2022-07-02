import 'package:bloclearning/vandad11hours/json_files/bloc/person.dart';
import 'package:flutter/foundation.dart' show immutable;

typedef PersonsLoader = Future<List<Person>> Function(String url);

@immutable
abstract class LoadAction {
  const LoadAction();
}

@immutable
class LoadPersonsAction implements LoadAction {
  final String url;
  final PersonsLoader loader;
  const LoadPersonsAction({required this.url, required this.loader}) : super();
}
