import 'package:flutter/foundation.dart' show immutable;
import 'package:bloclearning/global_widgets.dart';
import 'package:bloclearning/vandad11hours/json_files/bloc/bloc_actions.dart';
import 'package:bloclearning/vandad11hours/json_files/bloc/person.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloclearning/vandad11hours/helpers/custom_extensions.dart';

class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<String, List<Person>> _cache = {};

  PersonsBloc() : super(null) {
    on<LoadPersonsAction>((event, emit) async {
      final String url = event.url;
      if (_cache.containsKey(url)) {
        // We have the value in the cache
        final List<Person> cachedPersons = _cache[url]!;
        final FetchResult fetchResult = FetchResult(
          persons: cachedPersons,
          isRetrievedFromCache: true,
        );
        emit(fetchResult);
      } else {
        try {
          final PersonsLoader loader = event.loader;
          final List<Person> persons = await loader(url);
          _cache[url] = persons;
          final FetchResult fetchResult = FetchResult(
            persons: persons,
            isRetrievedFromCache: false,
          );
          emit(fetchResult);
        } on Exception catch (e) {
          // Error
          showSnackbar(SnackbarMessage.error, e.toString());
        }
      }
    });
  }
}

@immutable
class FetchResult {
  final List<Person> persons;
  final bool isRetrievedFromCache;

  const FetchResult({
    required this.persons,
    required this.isRetrievedFromCache,
  });

  @override
  String toString() =>
      'FetchResult (isRetrievedFromCache = $isRetrievedFromCache, persons = '
      '$persons)';

  @override
  bool operator ==(covariant FetchResult other) =>
      persons.isEqualToIgnoringOrdering(other.persons) &&
      isRetrievedFromCache == other.isRetrievedFromCache;

  @override
  int get hashCode => Object.hash(persons, isRetrievedFromCache);
}
