import 'dart:convert';
import 'package:bloclearning/global_widgets.dart';
import 'package:bloclearning/vandad11hours/helpers/custom_extensions.dart';
import 'package:bloclearning/vandad11hours/enums/enums.dart';
import 'package:bloclearning/vandad11hours/json_files/json_files_classes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:io';

class PersonsBloc extends Bloc<LoadAction, FetchResult?> {
  final Map<PersonUrl, List<Person>> _cache = {};

  PersonsBloc() : super(null) {
    on<LoadPersonsAction>((event, emit) async {
      final PersonUrl url = event.url;
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
          final List<Person> persons = await getPersons(url.urlString);
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

  Future<List<Person>> getPersons(String url) async {
    HttpClientRequest request = await HttpClient().getUrl(Uri.parse(url));
    HttpClientResponse response = await request.close();
    String stringData = await response.transform(utf8.decoder).join();
    List<dynamic> personsMapList = json.decode(stringData) as List<dynamic>;

    List<Person> personsList = [];
    for (Map<String, dynamic> personMap in personsMapList) {
      personsList.add(Person.fromMap(personMap));
    }

    return personsList;
  }
}
